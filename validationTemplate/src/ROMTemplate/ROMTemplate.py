"""
Created on November 30th 2021
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



class ROMTemplate(Template):
	"""
	Template class to create the ROM training file for the RAVEN validation template
	"""
	#Template.addNamingTemplates({'step name': '{action}_{subject}', 'distribution': '{var}_dist', 'metric var': '{metric}_{var}'})

	def __init__(self, roms, samplers, distributions):
		""" 
			ROM Template Constructor 
			@ In, roms, dict, dictionary of Reduced Order Models implemented with information
			@ In, samplers, dict, dictionary of Samplers implemented with information
			@ In, distributions, dict, dictionary of Distributions implemented with information
			@ Out, None 
		"""
		super(ROMTemplate, self).__init__()
		self.roms = roms
		self.samplers = samplers
		self.distributions = distributions
	
	# =============================================================================
	#     API methods
	# =============================================================================
	
	def createWorkflow(self, model=None, variables=None, rom=None, **kwargs):
		"""
		Creates a new RAVEN workflow file based on the information in kwargs.
		Specific to individual templates. Must overload to be useful.
				@ In, model, dict, optional, information about the model
				@ In, variables, dict, optional,information about the variables, dictionary of dictionary 
						each variable dictionary has with the following keys : 
								- path, str: path of the variable in the model 
								- distribution, str: probability distribution name 
								- grid_size, int: number of bins in the sampling grid
								- dist_params, list[float]: numerical parameters defining the PDF
								- alias, str: alias of the variable in the RAVEN XML file
				@ In, rom, dict, optional, information about the ROMs
				@ In, kwargs, dict, other unused keyword arguments
				@ Out, xml.etree.ElementTree.Element, modified copy of template
		"""
		template = Template.createWorkflow(self, **kwargs)
		# Fill variables list
		allVars = list(variables.keys())
		# Adjust Files block: Dymola initialization and pickled ROM
		self._addFile(xml=template, fileName='dsin.txt', path= model['dymola_ini'], ftype='DymolaInitialisation')
		self._addFile(xml=template, fileName='romPk', path='romPk', ftype="")
		template.find("Steps").find("IOStep[@name='dumpPickledROM']").find("Output").text = "romPk"
		# ROM Model 
		type = rom['type']
		template.find('Models').find('ROM').attrib['name'] = type
		template.find('Models').find('ROM').attrib['subType'] = type
		self._updateCommaSeperatedList(template.find('Models').find('ROM').find('Target'), rom['pivotParameter'])            
		template.find('Models').find('ROM').find('pivotParameter').text = rom['pivotParameter']
		for key, val in rom[type].items():
				template.find('Models').find('ROM').append(xmlUtils.newNode(str(key), text = str(val)))
		# Add ROM name to steps
		template.find('Steps').find("RomTrainer").find("Output").text = type 
		template.find('Steps').find("IOStep[@name='printAccuracy']").find('Input').text = type 
		template.find('Steps').find("IOStep[@name='dumpPickledROM']").find("Input").text = type 
		# Code Dymola
		code = template.find('Models').find('Code[@subType="Dymola"]')
		self._updateCommaSeperatedList(code.find('outputVariablesToLoad'), rom['pivotParameter'])
		# Sampler 
		sampler = rom['sampler']
		samplerName = str.lower(sampler)+"Sampler"
		samplerNode = xmlUtils.newNode(sampler, attrib={'name':samplerName})
		template.find("Samplers").append(samplerNode)
		runDymola = template.find('Steps').find('MultiRun[@name="runDymola"]')
		runDymola.find("Sampler").text = samplerName
		runDymola.find("Sampler").attrib['type'] = sampler
		#Variables
		gridSize = rom['grid_size']
		for var in allVars:
				self._addInputVariable(xml=template, varName=var, varDict=variables[var], sampler=sampler, gridSize=gridSize)
		# Target 
		for alias, path in model['targets'].items(): #list of targets' alias
				self._addTarget(xml=template, targetCodeAlias=alias, targetCodePath=path)
		# Add executable to Code
		template.find('Models').find('Code').find('executable').text = model['dymola_exe']
		return template
	
	
	# =============================================================================
	#     Input construction shortcuts
	# =============================================================================        
	def _addTarget(self, xml, targetCodeAlias, targetCodePath):
		"""
			Add the target everywhere needed in the validation workflow
			@ In, xml, xml.etree.ElementTree.Element, Simulation node from template
			@ In, targetCodeAlias, str, alias for the target in the code
			@ In, targetCodePath, str, path of the target in the code
			@ Out, None
		"""
		# Code
		code = xml.find('Models').find("Code[@subType='Dymola']")
		self._updateCommaSeperatedList(code.find('outputVariablesToLoad'), targetCodePath)
		aliasNode = xmlUtils.newNode('alias', attrib={'type':'output', 'variable':targetCodeAlias})
		aliasNode.text=targetCodePath
		code.append(aliasNode)
		results = xml.find('DataObjects').find("HistorySet[@name='modelResults']").find('Output')
		self._updateCommaSeperatedList(results, targetCodeAlias)
		#ROM model
		self._updateCommaSeperatedList(xml.find('Models').find('ROM').find('Target'), targetCodeAlias)
			
			
	
	def _addInputVariable(self, xml, varName, varDict, sampler, gridSize):
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
		distNode = xmlUtils.newNode(varDict['distribution'], attrib={'name':varName+'_dist'})
		p1, p2 = self.distributions[varDict['distribution']]
		distNode = xmlUtils.newNode(varDict['distribution'], attrib={'name':varDict['alias']+'_dist'})
		distNode.append(xmlUtils.newNode(p1, text = varDict['dist_params'][0]))
		distNode.append(xmlUtils.newNode(p2, text = varDict['dist_params'][1]))
		xml.find('Distributions').append(distNode)
		# Sampler
		var = xmlUtils.newNode('variable', attrib={'name':varDict['path']})
		var.append(xmlUtils.newNode('distribution', text=varName+'_dist'))
		grid = xmlUtils.newNode('grid', attrib={'construction':'equal', 'type':'CDF', 'steps':gridSize}, text='0.05 0.95')
		var.append(grid)
		xml.find('Samplers').find(sampler).append(var)
		# Add input variable to Model in Code node
		code = xml.find('Models').find("Code[@subType='Dymola']")
		self._updateCommaSeperatedList(code.find('outputVariablesToLoad'), varDict['path'])
		aliasNode = xmlUtils.newNode('alias', attrib={'type':'input', 'variable':varDict['path']}, text=varDict['path'])
		code.append(aliasNode)
		# ROM block 
		self._updateCommaSeperatedList(xml.find('Models').find('ROM').find('Features'), varDict['path'])
		# DataObjects 
		inputNode = xml.find('DataObjects').find('HistorySet[@name="modelResults"]').find('Input')
		self._updateCommaSeperatedList(inputNode, varDict['path'])

	
	def _addFile(self, xml, fileName, path, ftype=None):
		"""
			Adds a file to the Files node in the template
			@ In, xml, xml.etree.ElementTree.Element, Simulation node from template
			@ In, fileName, str, name of the file
			@ In, path, str, absolute path to the file
			@ In, ftype, str, optional, RAVEN type of the file if needed
			@ Out, None
		"""
		attribs = {'name':fileName}
		if ftype is not None: 
				attribs['type']=ftype
		newfile = xmlUtils.newNode('Input', attrib = attribs, text = path)
		xml.find('Files').append(newfile)
			