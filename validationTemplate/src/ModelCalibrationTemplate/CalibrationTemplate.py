# -*- coding: utf-8 -*-
"""
Created on Wed Aug  4 09:33:34 2021

@author: GARRM
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


class CalibrationTemplate(Template):
  """
  Template class to create the calibration workflow for the RAVEN validation template
  """
  #Template.addNamingTemplates({'step name': '{action}_{subject}', 'distribution': '{var}_dist', 'metric var': '{metric}_{var}'})
  
  def __init__(self, distributions, metricsSync): 
      """ 
        Constructor for Calibration Template 
            @ In, distributions, dict, dictionary of distributions implemented with information
            @ In, metricsSync, dict, dictionary of metrics and tags for syncing
            @ Out, None 
      """
      super(CalibrationTemplate, self).__init__()
      self.distributions = distributions
      self.metricsSync = metricsSync

  # =============================================================================
  #     API methods
  # =============================================================================
  def createWorkflow(self, model=None, metric=None, exp=None, variables=None, optimization=None, 
                      workDir=None, valFile=None, **kwargs):
      """
        Creates a new RAVEN calibration workflow file 
            @ In, model, dict, optional, information about the model
            @ In, metric, string, optional, metric for exp/model comparison
            @ In, exp, dict, optional, information about the experimental data
            @ In, variables, dict, optional, information about the variables
            @ In, optimization, dict, optional, information about the parameters's optimization
            @ In, workDir, str, optional, working directory
            @ In, valFile, str, optional, name (+extension) of the validation RAVEN file
            @ In, kwargs, dict, optional, other unused keyword arguments
            @ Out, xml.etree.ElementTree.Element, modified copy of template
      """
      template = Template.createWorkflow(self, **kwargs)
      # Working directory
      self._updateCommaSeperatedList(template.find('RunInfo').find('WorkingDir'), workDir)
      # Files: inner loop 
      template.find('Files').find('Input').text = valFile 
      # VAriables
      allVars = list(variables.keys())
      for var in allVars:
          self._addInputVariable(xml=template, varName=var, varDict=variables[var])
      # Optimizer
      # Optimizer limit iterations
      template.find('Optimizers').find('GradientDescent').find('samplerInit').find('limit').text = optimization['max_iterations']
      # Optimizer targets
      for targetCodeAlias, targetExpName in zip(model['targets'].keys(), exp['targets']):
          distTarget = metric+'_'+targetCodeAlias
          if self.metricsSync[metric]:
              distTarget += '_expDataSync_Output_'+targetExpName
          else:
              distTarget += '_expData_Output_'+targetExpName
          objective = template.find('Optimizers').find('GradientDescent').find('objective')
          self._updateCommaSeperatedList(objective, distTarget)
          # DataObjects
          output = template.find('DataObjects').find('PointSet[@name="optOut"]').find('Output')
          self._updateCommaSeperatedList(output, distTarget)
          out_node = template.find('DataObjects').find('PointSet[@name="optExport"]').find('Output')   
          self._updateCommaSeperatedList(out_node, distTarget, before='stepSize')
      return template
          
  def _addInputVariable(self, xml, varName, varDict):
      """ 
      Add a sampled variable everywhere needed in the calibration workflow
          @ In, xml, xml.etree.ElementTree.Element, Simulation node from template
          @ In, varName, name of the variable
          @ In, varDict, dict, variable dictionary with the following keys : 
                  - path, str, path of the variable in the model 
                  - distribution, str, probability distribution name 
                  - dist_params, list[float], numerical parameters defining the PDF
                  - alias, str, alias of the variable in the RAVEN XML file
                  - initials, list[float], list of initial values for optimization restart
          @ Out, None
      """
      # Adjust Models Code raven block
      varPath = 'Samplers|MonteCarlo@name:MC|constant@name:'+varDict['path']
      newAlias = xmlUtils.newNode('alias',attrib={'variable':varDict['path'], 'type':'input'}, text=varPath)
      xml.find('Models').find('Code[@name="raven"]').append(newAlias)
      # Add corresponding distributions
      p1, p2 = self.distributions[varDict['distribution']]
      dist_node = xmlUtils.newNode(varDict['distribution'], attrib={'name':varDict['alias']+'_dist'})
      dist_node.append(xmlUtils.newNode(p1, text = varDict['dist_params'][0]))
      dist_node.append(xmlUtils.newNode(p2, text = varDict['dist_params'][1]))
      xml.find('Distributions').append(dist_node)
      # Optimizer
      var_node = xmlUtils.newNode('variable', attrib={'name':varDict['path']})
      var_node.append(xmlUtils.newNode('distribution', text=varDict['alias']+'_dist'))
      if varDict['initials'] is not None:
          init = ','.join([str(ee) for ee in varDict['initials']])
          var_node.append(xmlUtils.newNode('initial', text=init))
      xml.find('Optimizers').find('GradientDescent').append(var_node)
      # optOut PointSet
      out_node = xml.find('DataObjects').find('PointSet[@name="optOut"]').find('Input')
      self._updateCommaSeperatedList(out_node, varDict['path'], position=0)
      # Export PointSet
      pt_node = xml.find('DataObjects').find('PointSet[@name="optExport"]').find('Output')
      self._updateCommaSeperatedList(pt_node, varDict['path'], position=0)
      
  
  