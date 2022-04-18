"""
Created on August 2nd 2021
@author: garrm

This module is part of the RAVEN Validation template
"""
from __future__ import division, print_function, unicode_literals, absolute_import
import warnings
warnings.simplefilter('default', DeprecationWarning)
# standard library
import os
import sys
# external libraries
# RAVEN libraries
## caution: using abspath here does not do desirable things on Windows Mingw.
import _utils as hutils
raven_path = os.path.abspath(hutils.get_raven_loc()) 
sys.path.append(raven_path)
# Importing XML functions from RAVEN 
from utils import xmlUtils
# Importing Template base class from RAVEN
from InputTemplates.TemplateBaseClass import Template



class ValidationTemplate(Template):
    """
    Template class to create the validation file for the RAVEN validation template
    """
    #Template.addNamingTemplates({'step name': '{action}_{subject}', 'distribution': '{var}_dist', 'metric var': '{metric}_{var}'})

    def __init__(self, metrics, distributions, calibration):
        """ 
        Validation Template Constructor 
            @ In, metrics, dict, dictionary of metrics implemented with information
            @ In, distributions, dict, dictionary of distributions implemented with information
            @ In, calibration, boolean, indicates if the validation XML file will be used for calibration
            @ Out, None 
        """
        super(ValidationTemplate, self).__init__()
        self.metrics = metrics
        self.distributions = distributions
        self.calibration = calibration
    
    # =============================================================================
    #     API methods
    # =============================================================================
    
    def createWorkflow(self, model=None, exp=None, variables=None, metric=None, romTag=False, **kwargs):
        """
        Creates a new RAVEN workflow file based on the information in kwargs.
        Specific to individual templates. Must overload to be useful.
            @ In, romTag, bool, whether validation workflow should be written for 
            @ In, model, dict, information about the model
            @ In, exp, dict, information about the experimental data
            @ In, variables, dict, information about the variables, dictionary of dictionary 
                each variable dictionary has with the following keys : 
                    - path, str: path of the variable in the model 
                    - distribution, str: probability distribution name 
                    - dist_params, list[float]: numerical parameters defining the PDF
                    - alias, str: alias of the variable in the RAVEN XML file
            @ In, metric, str, metric used to compute the distance bet. model and exp data 
            @ In, romTag, bool, optional, indicates whether or not a ROM is used for calibration
            @ In, kwargs, dict, other unused keyword arguments
            @ Out, xml.etree.ElementTree.Element, modified copy of template
        """
        template = Template.createWorkflow(self, **kwargs)
        # Fill variables list
        allVars = list(variables.keys())
        # Adjust Files block: Dymola initialization and experimental data
        if romTag: 
            self._addFile(xml=template, fileName='romPk', path='trainROMWorkDir\\romPk', ftype='')
            inputNode = template.find("Steps").find("IOStep[@name='loadROM']").find('Input')
            self._updateCommaSeperatedList(inputNode, "romPk")
        else:
            self._addFile(xml=template, fileName='dsin.txt', path= model['dymola_ini'], ftype='DymolaInitialisation')
        if exp['pp']:
            self._addFile(xml=template, fileName='expInput', path=exp['clean_dataset'])
        else:
            self._addFile(xml=template, fileName='expInput', path=exp['dataset'])
        # Add variables
        for var in allVars:
            if self.calibration: 
                self._addInputVariableForCalibration(xml=template, varPath=variables[var]['path'], romTag=romTag)
            else:
                self._addInputVariableForValidation(xml=template, varName=var, varDict=variables[var])
        # Metric 
        # Syncing post processor if basic metrics used
        self._addMetric(xml=template, metric=metric)
        if metric != 'DTW':
            self._addSync(template, metric=metric)
        for targetCodeAlias, targetExpName in zip(model['targets'].keys(), exp['targets']): 
            path = model['targets'][targetCodeAlias]
            self._addTarget(xml=template, targetExpName=targetExpName, 
                targetCodeAlias=targetCodeAlias, targetCodePath=path, metric=metric, romTag=romTag)
        # Add executable to Code
        if not romTag:
            template.find('Models').find('Code').find('executable').text = model['dymola_exe']
        return template
    
    
    # =============================================================================
    #     Input construction shortcuts
    # =============================================================================    
    def _addSync(self, xml, metric):
        """
        Add a syncing post processor to the validation workflow, add corresponding Steps, modifies the Sequence and 
        add necessary DataObjects
            @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
            @ In, metric, str, name(RAVEN) of the metric used for the target comparison
            @ Out, None
        """
        # Post processor model
        pp = xmlUtils.newNode('PostProcessor', attrib={'name':'sync', 'subType':'HistorySetSync'})
        pp.append(xmlUtils.newNode('numberOfSamples', text = '10000'))
        pp.append(xmlUtils.newNode('pivotParameter', text='Time'))
        pp.append(xmlUtils.newNode('extension', text='zeroed'))
        pp.append(xmlUtils.newNode('syncMethod', text='grid'))
        xml.find('Models').append(pp)
        # Add Syncing steps and modifying the compare step
        pps = xmlUtils.newNode('PostProcess', attrib={'name':'fixTimeExp'})
        pps.append(xmlUtils.newNode('Input', 
                                    attrib={'class':'DataObjects','type':'HistorySet'},
                                    text = 'expData'))
        pps.append(xmlUtils.newNode('Model', 
                                    attrib={'class':'Models','type':'PostProcessor'},
                                    text = 'sync'))
        pps.append(xmlUtils.newNode('Output', 
                                    attrib={'class':'DataObjects','type':'HistorySet'},
                                    text = 'expDataSync'))
        ppm = xmlUtils.newNode('PostProcess', 
                                attrib={'name':'fixTimeMod'})
        ppm.append(xmlUtils.newNode('Input', 
                                    attrib={'class':'DataObjects','type':'HistorySet'},
                                    text = 'modelResults'))
        ppm.append(xmlUtils.newNode('Model', 
                                    attrib={'class':'Models','type':'PostProcessor'},
                                    text = 'sync'))
        ppm.append(xmlUtils.newNode('Output', 
                                    attrib={'class':'DataObjects','type':'HistorySet'},
                                    text = 'modelResultsSync'))
        xml.find('Steps').append(pps)
        xml.find('Steps').append(ppm)
        compare = xml.find('Steps').find("PostProcess[@name='compare']")
        for inp in compare.findall('Input'):
            compare.remove(inp)
        compare.append(xmlUtils.newNode('Input', 
                                    attrib={'class':'DataObjects','type':'HistorySet'},
                                    text = 'modelResultsSync'))
        compare.append(xmlUtils.newNode('Input', 
                                    attrib={'class':'DataObjects','type':'HistorySet'},
                                    text = 'expDataSync'))
        # Dataobjects: add 2 history sets and modify the output pointset
        data = xml.find('DataObjects')
        dataexp= xmlUtils.newNode('HistorySet', attrib={'name':'expDataSync'})
        dataexp.append(xmlUtils.newNode('Input', text = 'InputPlaceHolder'))
        dataexp.append(xmlUtils.newNode('Output', text=''))
        options= xmlUtils.newNode('options')
        options.append(xmlUtils.newNode('pivotParameter', text='Time'))
        dataexp.append(options)
        data.append(dataexp)
        datac= xmlUtils.newNode('HistorySet', attrib={'name':'modelResultsSync'})
        datac.append(xmlUtils.newNode('Input', text = 'InputPlaceHolder'))
        datac.append(xmlUtils.newNode('Output', text = ''))
        datac.append(options)
        data.append(datac)
        # Sequence 
        self._updateCommaSeperatedList(xml.find('RunInfo').find('Sequence'), 'fixTimeExp', before='compare')
        self._updateCommaSeperatedList(xml.find('RunInfo').find('Sequence'), 'fixTimeMod', before='compare')
    
    def _addMetric(self, xml, metric):
        """
        Add a metric to the validation workflow and syncing post processing step 
        if the metric is anything other than DTW
            @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
            @ In, metric, str, name(RAVEN) of the metric used for the target comparison
            @ Out, None
        """
        pp_met = xml.find('Models').find('PostProcessor[@subType="Metric"]').find('Metric')     
        if metric == 'DTW':
            met =  xmlUtils.newNode('Metric',attrib={'name':metric, "subType":"DTW"})
            met.append(xmlUtils.newNode('order',text = '0'))
            met.append(xmlUtils.newNode('localDistance', text='euclidean'))
            #pp_met.attrib['type'] = 'DTW'
        else: 
            metric_id = self.metrics[metric][0]
            metric_cat = self.metrics[metric][1]
            met = xmlUtils.newNode("Metric", attrib={'name':metric,"subType":metric_id})
            met.append(xmlUtils.newNode('metricType', text=metric_cat+'|'+metric)) 
        pp_met.attrib['type'] = "Metric"
        pp_met.text = metric          
        xml.find('Metrics').append(met)
            
    
    def _addTarget(self, xml, targetExpName, targetCodeAlias, targetCodePath, metric, romTag):
        """
        Add the target everywhere needed in the validation workflow
            @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
            @ In, targetExpName, str, name of the target in the experiment dataset
            @ In, targetCodeAlias, str, alias for the target in the code
            @ In, targetCodePath, str, path of the target in the code
            @ In, metric, str, name (RAVEN) of the metric used for the target comparison
            @ In, romTag, bool, indicates whether or not a ROM is used for calibration
            @ Out, None
        """
        # Code
        if not romTag:
            code = xml.find('Models').find("Code[@subType='Dymola']")
            self._updateCommaSeperatedList(code.find('outputVariablesToLoad'), targetCodePath)
            aliasNode = xmlUtils.newNode('alias', attrib={'type':'output', 'variable':targetCodeAlias})
            aliasNode.text=targetCodePath
            code.append(aliasNode)
        pp = xml.find('Models').find("PostProcessor[@name='pp']")
        self._updateCommaSeperatedList(pp.find('Targets'), targetCodeAlias)
        data = xml.find('DataObjects')
        # Post Processor
        if metric !="DTW":
            self._updateCommaSeperatedList(pp.find('Features'), "expDataSync|Output|"+ targetExpName)
            output = '{}_{}_expDataSync_Output_{}'.format(metric, targetCodeAlias, targetExpName)
            self._updateCommaSeperatedList(data.find("PointSet[@name='ppOut']").find('Output'), output)
            #data.find("PointSet[@name='ppOut']").find('Output').text = metric+'_'+targetCodeAlias+'_expDataSync_Output_'+targetExpName
        else:
            self._updateCommaSeperatedList(pp.find('Features'), "expData|Output|"+ targetExpName)
            output = '{}_{}_expData_Output_{}'.format(metric, targetCodeAlias, targetExpName)
            print(output)
            self._updateCommaSeperatedList(data.find("PointSet[@name='ppOut']").find('Output'), output)
            #pp.find('Features').text = "expData|Output|"+ targetExpName
            #data.find("PointSet[@name='ppOut']").find('Output').text = metric+'_'+targetCodeAlias+'_expData_Output_'+targetExpName
        # DataObjects
        expDataSet = data.find("HistorySet[@name='expData']").find('Output')
        self._updateCommaSeperatedList(expDataSet, targetExpName)
        if not romTag:
            modelResultsSet = data.find("HistorySet[@name='modelResults']").find('Output')
            self._updateCommaSeperatedList(modelResultsSet, targetCodeAlias)
        else:
            modelResultsSet = data.find("HistorySet[@name='modelResults']").find('Output')
            self._updateCommaSeperatedList(modelResultsSet, targetCodeAlias)
        if metric !='DTW':
            outputExpSync = data.find("HistorySet[@name='expDataSync']").find('Output')
            self._updateCommaSeperatedList(outputExpSync, targetExpName)
            outputModSync = data.find("HistorySet[@name='modelResultsSync']").find('Output')
            self._updateCommaSeperatedList(outputModSync, targetCodeAlias)
        
        
    
    def _addInputVariableForCalibration(self, xml, varPath, romTag):
        """ 
        Add a sampled variable everywhere needed for a calibration workflow
            @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
            @ In, varPath, str, name of the variable corresponding to its path in Dymola
                ex: thermocline_Insulation.geometry.fs for the thermocline shape factor
            @ In, romTag, bool, indicates whether or not a ROM is used for calibration
            @ Out, None
        """
        # Adjust Samplers block
        newconstant = xmlUtils.newNode('constant',attrib={'name':varPath}, text='42')
        xml.find('Samplers').find('MonteCarlo').append(newconstant)
        if not romTag:
            # Add input variable to the code block
            code = xml.find('Models').find("Code[@subType='Dymola']")
            self._updateCommaSeperatedList(code.find('outputVariablesToLoad'), varPath)
        else:
            dummyIn = xml.find('DataObjects').find("PointSet[@name='dummyIn']")
            self._updateCommaSeperatedList(dummyIn.find('Input'),varPath)
            modelResults = xml.find('DataObjects').find("HistorySet[@name='modelResults']")
            self._updateCommaSeperatedList(modelResults.find('Input'),varPath)
            expData = xml.find('DataObjects').find("HistorySet[@name='expData']")
            self._updateCommaSeperatedList(expData.find("Input"), varPath)
    
    def _addInputVariableForValidation(self, xml, varName, varDict):
        """ 
        Add a sampled variable everywhere needed for a calibration workflow
            @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
            @ In, varName, name of the variable
            @ In, varDict, dict, variable dictionary with the following keys : 
                    - path, str: path of the variable in the model 
                    - distribution, str: probability distribution name 
                    - dist_params, list[float]: numerical parameters defining the PDF
                    - alias, str: alias of the variable in the RAVEN XML file
            @ Out, None
        """
        # Distribution 
        dist_node = xmlUtils.newNode(varDict['distribution'], attrib={'name':varName+'_dist'})
        p1, p2 = self.distributions[varDict['distribution']]
        dist_node = xmlUtils.newNode(varDict['distribution'], attrib={'name':varDict['alias']+'_dist'})
        dist_node.append(xmlUtils.newNode(p1, text = varDict['dist_params'][0]))
        dist_node.append(xmlUtils.newNode(p2, text = varDict['dist_params'][1]))
        xml.find('Distributions').append(dist_node)
        # Sampler
        sampler = xmlUtils.newNode('Stratified', attrib={'name':'stratifiedSampler'})
        var = xmlUtils.newNode('variable', attrib={'name':varName})
        var.append(xmlUtils.newNode('distribution', text=varName+'_dist'))
        grid = xmlUtils.newNode('grid', attrib={'construction':'equal', 'type':'CDF', 'steps':"100"}, text='0.05 0.95')
        var.append(grid)
        sampler.append(var)
        xml.find('Samplers').append(sampler)
        # Add input variable to Model in Code node
        code = xml.find('Models').find("Code[@subType='Dymola']")
        self._updateCommaSeperatedList(code.find('outputVariablesToLoad'), varDict['path'])
    
    
    def _addFile(self, xml, fileName, path, ftype=None):
        """
        Adds a file to the Files node in the template
            @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
            @ In, fileName, str, name of the file
            @ In, ftype, str, RAVEN type of the file if needed
            @ In, path, str, absolute path to the file
            @ Out, None
        """
        attribs = {'name':fileName}
        if ftype is not None: 
            attribs['type']=ftype
        newfile = xmlUtils.newNode('Input', attrib = attribs, text = path)
        xml.find('Files').append(newfile)
        