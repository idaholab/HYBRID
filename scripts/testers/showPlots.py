import os
import pandas as pd
from plotInterface import MainWindow
from PyQt5.QtWidgets import QApplication
import differPlots

def getTestDirs():
  '''
    Gets the test directories. Works whether script is called from location
    of script from main hybrid folder.
    @ In, None
    @ Out, testDirs, list of strings, directory of tests
    @ Out, hybridPath, string, path of main hybrid folder
  '''
  testDirs = [] 
  if os.path.basename(os.getcwd()) == 'testers':
    hybridPath = os.path.dirname(os.path.dirname(os.getcwd()))
    folders = os.listdir(os.path.join(hybridPath, 'tests', 'dymola_tests'))
    folders = list(filter(lambda x: '.' not in x, folders))
    folders = list(filter(lambda x: 'README' not in x, folders))
    folders = list(filter(lambda x: 'pycache' not in x, folders))
    testDirs = []
    for folder in folders:
      testDirs.append(os.path.join(hybridPath, 'tests', 'dymola_tests', folder))
  else:
    hybridPath = os.getcwd()
    testReport = pd.read_csv(os.path.join(hybridPath, 'test_report.csv'))
    for index, row in testReport.iterrows():
      if 'dymola_tests' in row['name'] and not row['passed']:
        testDirs.append(row['name'])
  return testDirs, hybridPath


def getOutputTimeInfo(files, testDir):
  '''
    Reads the .mos file to get info about the timesteps
    @ In, files, list of strings, all file in the test directory
    @ In, testDir, string, the test directory
    @ Out, outputstep, float, the output step of simulation
    @ Out, float, the end time of the simulation
  '''
  mosFile = list(filter(lambda x: '.mos' in x, files))[0]
  numberOfIntervals, outputInterval, stopTime, outputStep = None, None, None, None
  with open(os.path.join(testDir, mosFile)) as mosObj:
    for line in mosObj.readlines():
      if line.lower().startswith("simulatemodel"):
        for el in line.split(","):
          if el.strip().lower().startswith("stoptime"):
            stopTime = float(el.strip().split("=")[-1])
          elif el.strip().lower().startswith("numberofintervals"):
            numberOfIntervals = int(el.strip().split("=")[-1])
          elif el.strip().lower().startswith("outputinterval"):
            outputInterval = float(el.strip().split("=")[-1])
        break
  outputStep = outputInterval if outputInterval else stopTime/ numberOfIntervals
  return outputStep, stopTime

def getRelErr(testDir):
  '''
    Finds the relative error from the test file. If not provided, uses default
    @ In, testDir, the test directory
    @ Out, relErr, float, the relative error to use for comparisons,
  '''
  relErr = 1e-3
  with open(os.path.join(testDir, 'tests')) as testParams:
    for line in testParams.readlines():
      if 'rel_err'in line:
        relErr = float((line.replace('=', '')).split()[1])
        break
  return relErr

def showPlots(tests, otherTests):
  '''
    Calls the plot interface to show the plots
    @ In, tests, list of DifferPlots objects that holds test and reference info
    @ Out, None
  '''
  if len(tests) or len(otherTests['diffVars']) or len(otherTests['diffTimes']):
    app = QApplication([])
    app.setStyle('Fusion')
    window = MainWindow(tests, otherTests)
    window.show()
    app.exec_()
  else:
    print('No differences to show')
  
if __name__ == "__main__":
  testDirs, hybridPath = getTestDirs()
  tests = {}
  otherTests = {}
  otherTests['diffVars'] = []
  otherTests['diffTimes'] = []
  for testDir in testDirs:
    testDir = os.path.join(hybridPath, testDir)
    testFolder = os.path.basename(os.path.normpath(testDir))
    files = os.listdir(testDir)
    outputFile = list(filter(lambda x: 'mat' in x, files))
    if len(outputFile):
      outputFile = outputFile[0]
      outputStep, stopTime = getOutputTimeInfo(files, testDir)
      relErr = getRelErr(testDir)
      test = differPlots.DifferPlots(testDir, outputFile, outputStep = outputStep, stopTime = stopTime, rel_tol=relErr)
      (same, message) = test.diff()
      if len(test.differVars):
        tests[testFolder] = test
      elif test._same == False and test.loaded:
        if test.timeLoaded:
          otherTests['diffVars'].append(testFolder)
        else:
          otherTests['diffTimes'].append(testFolder)
  showPlots(tests, otherTests)