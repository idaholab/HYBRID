"""
Created on July 28th 2021
@author: garrm
Template interface for the RAVEN Validation template
"""
from __future__ import print_function, unicode_literals
import os
import shutil
import sys
import inspect
import configparser
import logging
import subprocess
from datetime import datetime
from collections import OrderedDict
from typing import Dict
from _utils import get_raven_loc
import _utils as hutils
from ModelValidationTemplate.ValidationTemplate import ValidationTemplate
from ModelCalibrationTemplate.CalibrationTemplate import CalibrationTemplate
from ROMTemplate.ROMTemplate import ROMTemplate

# Authorized values dictionary
# TODO Change the way input testing is done ask P. Talbot about how they do it in RAVEN
authorized = {'type': ['calibration', 'validation'],
                'metrics': {'DTW':'DTW', 
                            'mean_squared_error':['SKL', 'regression'],
                            'mean_absolute_error':['SKL', 'regression'],
                            'euclidean':['SKL', 'paired_distance']}, 
                'distributions' : {'Uniform':['lowerBound','upperBound'],
                                'Normal':['mean', 'sigma']},
                'metrics_sync' :{'DTW':False, 
                                'mean_squared_error':True, 
                                'mean_absolute_error':True, 
                                'euclidean':True}}
roms = {'DMD': {'required':['dmdType', 'rankSVD'],
                'optional':['optimized', 'exactModes','rankTLSQ','energyRankSVD']}, 
        'PolyExponential':{'required': ['numberExpTerms', 'tol', 'max_iter'], 
                            'optional':['coeffREgressor']}, 
        'SyntheticHistory':{'required': None, 
                            'optional': ['fourier', 'wavelet']} }
samplers = ['MonteCarlo', 'Stratified']
authorized['roms'] = roms
authorized['samplers'] = samplers




def readInputFile(inputFilePath, logger):
  """ 
  Read input file 
      @ In, inputFilePath, string, relative path to the input file
      @ In, logger, Logger, for formatted messages
      @ Out, calibration, bool, indicates whether calibration is performed or not
      @ Out, metric, string, metric for exp/model comparison
      @ Out, model, dict, information about the model to run 
      @ Out, target_list, dict, list of SRQ 
      @ Out, exp, dict, information about the experimental dataset 
      @ Out, variables, dict, information about the model's variables 
      @ Out, optimization, dict, information about the optimization if calibration is True
  """
  
  # Load input file
  logger.info('Loading input file.')
  config = configparser.ConfigParser()
  config.read(inputFilePath)
  logger.info('Input file loaded.')
  # configparser will print useful error if file is missing

  # Determine type 
  type = config.get('CASE','type')
  calibration = False
  try: 
      assert type in authorized['type']
  except AssertionError as e:
      logger.exception('A test failed : ')
      raise e 
  if type =='calibration': 
      calibration = True 

  # Check metric 
  metric = config.get('CASE', 'metric')
  try:
      assert metric in authorized['metrics'].keys()
  except AssertionError as e:
      logger.exception('A test failed : ')
      raise e
  
  # Dymola model 
  model = {'dymola_exe': config.get('MODEL', 'dymola_exe'),
          'dymola_ini': config.get('MODEL', 'dymola_ini')}
  targetList = list(x.strip() for x in config.get('MODEL', 'targets').split(','))
  model['targets'] = {}
  try: 
      it = iter(targetList)
      for x in it: 
          model['targets'][x] = next(it)
  except StopIteration as e:
      logger.exception("Targets should be listed as such: aliasSRQ_1, pathSRQ_1, aliasSRQ_2, pathSRQ_2...")
      raise e
  for srq, path in model['targets'].items():
      logger.info('SRQ for the validation/calibration : {} \n \t\tPath in Dymola model : {} '.format(str(srq),str(path)))
  try:
      assert len(model['targets'].keys())==1
  except AssertionError as e:
      logger.exception('Only one target allowed!')
      raise e

  # Experiment data
  exp = {'dataset': config.get('EXPERIMENT', 'dataset'), 
      'targets': list(x.strip() for x in config.get('EXPERIMENT', 'targets').split(',')),
      'pp': config.getboolean('EXPERIMENT','post_process', fallback=False)}
  for target in exp['targets']:
      logger.info('SRQ name in the experimental dataset : {} '.format(target))
  if exp['pp']: 
      logger.info('Launching the experimental data pre-processing script.')
      exp['pp_script'] = config.get('EXPERIMENT', 'post_process_script')
      postprocesssingScript = exp['pp_script']
      try: 
          assert os.path.exists(postprocesssingScript), "The post processing script passed does not exist !"
          code = exp['pp_script']
          data = exp['dataset']
          ppResults = subprocess.run(["python", code, data], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=True)
          logger.info(str(ppResults.stdout.decode('utf-8')))
          newPath = str(ppResults.stdout.decode('utf-8'))
          exp['clean_dataset'] = newPath
          logger.info('Experimental data is clean.')
      except Exception as e: 
          logger.exception('Problem with data post processing script : ')
          raise e

  # Variables
  variables = OrderedDict()
  for var in config['VARIABLES'].keys():
      distrib = list(x.strip() for x in config.get('VARIABLES', var).split(','))
      path = distrib[0]
      distribName = distrib[1].strip()    # name of the variable distribution
      try:
          assert distribName in authorized['distributions'].keys(), \
          "Use one of the following distribution for your variable: {}".format(authorized['distributions'].keys())
          distribParams = [float(k) for k in distrib[2:]] # list of numerical parameters of the chosen distribution
      except AssertionError as e:
          logger.exception('A test failed : ')
          raise e        
      variables[var] = {'path':path,
                      'distribution': distribName,
                      'dist_params': distribParams, 
                      'alias':var}

  # Optimization
  if calibration: 
      # Add initial values
      for var in variables.keys():
          try: 
              assert var in config['OPTIMIZATION'].keys(), "Initial values for "+str(var)+\
              " not given for optimization calibration"
          except AssertionError as e:
              logger.exception('A test failed : ')
              raise e
          initials = [float(elem) for elem in config.get('OPTIMIZATION', var).split(',')]
          variables[var]['initials'] = initials
      optimization = {'max_iterations': str(config.getint('OPTIMIZATION', 'max_iterations')), 
                      'nb_traj': str(config.getint('OPTIMIZATION', 'nb_traj'))}
  else: 
      optimization = None

  # Working directory and files' names
  workDirFallback = "workDir_"+datetime.now().strftime("%m_%d_%Y_%H_%M_%S")
  valFileFallback = "validation_"+datetime.now().strftime("%m_%d_%Y_%H_%M_%S")
  settings = {'work_dir': config.get('SETTINGS', 'work_dir', fallback=workDirFallback), 
              'validation_file': config.get('SETTINGS', 'validation_file', fallback=valFileFallback)+'.xml'}
  if calibration: 
      calFileFallback = "calibration_"+datetime.now().strftime("%m_%d_%Y_%H_%M_%S")+'.xml'
      settings['calibration_file'] = config.get('SETTINGS', 'calibration_file', fallback=calFileFallback)+'.xml'

  # ROM ? 
  romtag = False
  rom = {}
  if config.has_section('ROM'):
      romtag = True
      type = config.get('ROM', 'type')
      rom['type']= type
      if type == 'DMDc':
          pass
      elif type =='PolyExponential':
          rom['PolyExponential']['numberExpTerms'] = config.getint('ROM', 'numberExpTerms', fallback = 5)
          rom['PolyExponential']['coeffRegressor'] = config.get('ROM', 'coeffRegressor', fallback = 'nearest')
          rom['PolyExponential']['tol'] = config.getfloat('ROM', 'tol', fallback = 0.001)
          rom['PolyExponential']['max_iter'] = config.getint('ROM', 'max_iter', fallback = 1000)
          if rom['PolyExponential']['coeffRegressor']=='poly' and config.has_option('ROM', 'polyOrder'):
              rom['PolyExponential']['polyOrder'] = config.getint('ROM', 'polyOrder', fallback = 5)
      elif type =='SyntheticHistory':
          #rom['SyntheticHistory']
          pass
      elif type=='DMD':
          rom['DMD'] ={}
          rom['DMD']['dmdType'] = config.get('ROM', 'dmdType', fallback='dmd')
          rom['DMD']['rankSVD'] = config.getint('ROM', 'rankSVD', fallback=5)
          #rom['DMD']['optimized'] = config.getboolean('ROM', 'optimized', fallback=True) #Bug in RAVEN
          #TODO report it
          rom['DMD']['rankTLSQ'] = config.getint('ROM', 'rankTLSQ', fallback=7)
          rom['DMD']['exactModes'] = config.get('ROM', 'exactModes', fallback=True)
      else:
          # Type not recognized
          try:
              assert type in authorized['roms'].keys()
          except AssertionError as e:
              logger.exception('A test failed : ')
              raise e
      rom['pivotParameter'] = config.get('ROM', 'pivotParameter', fallback ='Time')
      rom['sampler'] = config.get('ROM', 'sampler', fallback='Stratified')
      rom['grid_size'] = str(config.getint('ROM', 'grid_size'))
      rom['Features'] = list(variables.keys())
      rom['workDir'] = config.get('SETTINGS', 'work_dir', fallback=workDirFallback)
      settings['rom_file'] = 'ROMtrain.xml'
  
  return romtag, calibration, metric, model, exp, variables, settings, optimization, rom

def writeXMLValidation(model, exp, variables, metric, validationFile, calibration, romTag): 
  """ 
  Write XML Validation input file
      @ In, model, dict, model information, executable, SRQ, initialization file 
      @ In, exp, dict, experimental dataset path, SRQ names, post-processing tag and script 
      @ In, variables, dict, variables model path, distribution 
      @ In, metric, string, metric for exp/model comparison
      @ In, validationFile, string, name of XML RAVEN validation input file 
      @ In, calibration, boolean, indicates whether calibration or validation is performed
      @ In, romTag, boolean, indicates whether a ROM is used to perform calibration
      @ Out, None
  """
  # Check inputs 
  try: 
      assert isinstance(model, dict)
      assert isinstance(exp, dict)
      assert isinstance(variables, dict)
      assert isinstance(metric, str)
      assert metric in authorized['metrics'].keys()
      assert isinstance(validationFile, str)
      assert isinstance(calibration, bool)
  except AssertionError as e:
      logger.exception('A test failed : ')
      raise e
  # Load template
  logger.info('Loading validation template.')
  valTemplate = ValidationTemplate(authorized['metrics'], authorized['distributions'], calibration)
  if calibration and romTag: 
      valTemplate.loadTemplate('validation_ROM_incomplete_XML.xml', os.path.dirname(inspect.getfile(ValidationTemplate)))
  elif calibration:
      valTemplate.loadTemplate('validation_incomplete_XML.xml', os.path.dirname(inspect.getfile(ValidationTemplate)))
  else: 
      valTemplate.loadTemplate('validation_incomplete_XML_valonly.xml', os.path.dirname(inspect.getfile(ValidationTemplate)))
  logger.info('Validation template loaded.')

  # Writing the validation MXL file without running it with RAVEN and get errors
  logger.info('Writing RAVEN validation input file.')
  valXMLToWrite = valTemplate.createWorkflow(model=model, exp=exp, variables=variables, metric=metric, romTag=romTag)
  errors = valTemplate.writeWorkflow(valXMLToWrite, validationFile, run=False)
  if errors == 0:
      logger.info('Successfully wrote input "{}".'.format(validationFile))


def writeXMLCalibration(model, exp, variables, metric, optimization, work_dir, calibrationFile, validationFile): 
  """ 
  Write XML Calibration input file 
      @ In, model, dict, model information, executable, SRQ, initialization file 
      @ In, exp, dict, experimental dataset path, SRQ names, post-processing tag and script 
      @ In, variables, dict, variables model path, distribution 
      @ In, metric, string, metric for exp/model comparison
      @ In, optimization, dict, optimization algorithm information 
      @ In, work_dir, string, name of working directory to store calibration files 
      @ In, calibrationFile, string, name of XML RAVEN calibration input file 
      @ in, validationFile, string, name of XML RAVEN validation input file 
      @ Out, None
  """
  # Check inputs 
  try:
      assert isinstance(model, dict)
      assert isinstance(exp, dict)
      assert isinstance(variables, dict)
      assert isinstance(metric, str)
      assert metric in authorized['metrics'].keys()
      assert isinstance(optimization, dict)
      assert isinstance(work_dir, str)
      assert isinstance(calibrationFile, str)
      assert isinstance(validationFile, str)
  except AssertionError as e:
      logger.exception('A test failed : ')
      raise e
  # Load Template 
  logger.info('Loading calibration template.')
  calTemplate = CalibrationTemplate(authorized['distributions'], authorized['metrics_sync'])
  calTemplate.loadTemplate('calibration_incomplete_XML.xml', os.path.dirname(inspect.getfile(CalibrationTemplate)))
  logger.info('Calibration template loaded.')

  # Writing the calibration MXL file without running it with RAVEN and get errors
  logger.info('Writing RAVEN calibration input file.')
  calXMLToWrite = calTemplate.createWorkflow(model, metric, exp, variables, optimization, work_dir, validationFile)
  errors = calTemplate.writeWorkflow(calXMLToWrite, calibrationFile, run=False)
  if errors == 0:
      logger.info('Successfully wrote input "{}".'.format(calibrationFile))

def writeXMLROM(model, rom, variables, romFile): 
  """ 
  Write XML Calibration input file 
      @ In, model, dict, model information, executable, SRQ, initialization file 
      @ In, rom, dict, ROM information, type, options for each ROM
      @ In, variables, dict, variables model path, distribution 
      @ In, romFile, string, name of pickled ROM file
      @ Out, None
  """
  # Check inputs 
  try:
      assert isinstance(model, dict)
      assert isinstance(rom, dict)
      assert isinstance(variables, dict)
      assert isinstance(romFile, str)
  except AssertionError as e:
      logger.exception('A test failed : ')
      raise e
  # Load Template 
  logger.info('Loading ROM template.')
  romTemplate = ROMTemplate(authorized['roms'], authorized['samplers'], authorized['distributions'])
  romTemplate.loadTemplate('trainROM_incomplete_XML.xml', os.path.dirname(inspect.getfile(ROMTemplate)))
  logger.info('ROM template loaded.')

  # Writing the ROM training MXL file without running it with RAVEN and get errors
  logger.info('Writing RAVEN ROM training input file.')
  romXMLToWrite = romTemplate.createWorkflow(model=model, variables=variables, rom=rom)
  errors = romTemplate.writeWorkflow(romXMLToWrite, romFile, run=False)

  if errors == 0:
      logger.info('Successfully wrote input "{}".'.format(romFile))
      
def createFolderTree(calTag, romTag, valFile, workDir, calFile=None, romFile=None): 
  """ 
  Create working directory (overwrite if already exists) and moves the XML validation file to it 
      @ In, calTag, bool, tag indicating whether calibration is performed or not 
      @ In, romTag, bool, tag indicating whether a ROM is used
      @ In, valFile, string, name of XML RAVEN validation input file 
      @ In, romFile, string, name of XML RAVEN rom training input file
      @ In, workDir, string, name of working directory to store calibration files 
      @ Out, None
  """
  logger.info('Creating the folder tree to run the RAVEN files.')
  try: 
      os.mkdir(os.path.join('./', workDir))
  except OSError:
      logger.warning('The working directory provided already exists, files will be erased or over-written')
      for root, dirs, files in os.walk(os.path.join('./', workDir)):
          for f in files:
              os.unlink(os.path.join(root, f))
          for d in dirs:
              shutil.rmtree(os.path.join(root, d))
  logger.info('Moving the validation file to the working directory.')
  dest = shutil.move(valFile, workDir)
  logger.info('Validation RAVEN file: {} moved to: {}'.format(valFile, workDir))
  if romTag:
      logger.info('Moving the ROM training file to the working directory')
      destROM = shutil.move(romFile, workDir)
      logger.info('ROM training RAVEN file: {} moved to: {}'.format(romFile, workDir))
  if calTag:
      logger.info("Moving the calibration file to the working directory.")
      destCal = shutil.move(calFile, workDir)
      logger.info('Calibration RAVEN file: {} moved to: {}'.format(calFile, workDir))
  try: #Make sure things have been moved
      assert os.path.exists('./'+workDir+'/'+valFile)
      if romTag:
          assert os.path.exists('./'+workDir+'/'+romFile)
      if calTag:
          assert os.path.exists('./'+workDir+'/'+calFile)
  except AssertionError as e: 
      logger.exception('A test failed : ')
      raise e


if __name__ == '__main__':
  level = logging.DEBUG
  fmt = "[%(levelname)s] %(asctime)s - %(message)s "
  logging.basicConfig(format=fmt, level=level)
  logger = logging.getLogger(__name__)
  try: 
      assert (len(sys.argv) >=2), "Give the path to the RAVEN Template input file" 
      inputFile = sys.argv[1]
      assert os.path.exists(inputFile), "Input file passed does not exist"
  except AssertionError as e: 
      logger.exception('A test failed : ')
      raise e
  romTag, calTag, metric, model, exp, variables, settings, optimization, rom = readInputFile(inputFile, logger)
  valFile = settings['validation_file']
  writeXMLValidation(model, exp, variables, metric, valFile, calTag, romTag)
  workDir = settings['work_dir']
  if calTag and romTag: 
      calFile = settings['calibration_file']
      writeXMLCalibration(model, exp, variables, metric, optimization, work_dir='.', calibrationFile=calFile, validationFile=valFile)
      romFile = settings['rom_file']
      writeXMLROM(model, rom, variables, romFile)
      createFolderTree(calTag, romTag, valFile, workDir, calFile, romFile)
      print('To train your ROM do : $ ./PATH_TO_RAVEN/raven/raven_framework ./{}/{}'.format(workDir, romFile))
      print('The, to run your calibration process do : $ ./PATH_TO_RAVEN/raven/raven_framework ./{}/{}'.format(workDir,calFile))
  elif calTag:
      calFile = settings['calibration_file']
      writeXMLCalibration(model, exp, variables, metric, optimization, work_dir='.', calibrationFile=calFile, validationFile=valFile)
      createFolderTree(calTag, romTag, valFile, workDir, calFile)
      print('To run your calibration process do : $ ./PATH_TO_RAVEN/raven/raven_framework ./{}/{}'.format(workDir,calFile))
  else:
      createFolderTree(calTag, romTag, valFile, workDir)
      print('To run your validation process do : $ ./PATH_TO_RAVEN/raven/raven_framework ./{}/{}'.format(workDir,valFile))






