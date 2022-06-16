import os
import pandas as pd
from plotInterface import MainWindow
from PyQt5.QtWidgets import QApplication
import differplots
from time import perf_counter

if __name__ == "__main__":
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
  # print('######################')
  # print('Running Comparisons')
  # print('######################')
  # print()
  skipped = 0
  success = 0
  fail = 0
  tests = {}
  startTime = perf_counter()
  for testDir in testDirs:
    testDir = os.path.join(hybridPath, testDir)
    testFolder = os.path.basename(os.path.normpath(testDir))
    files = os.listdir(testDir)
    outputFile = list(filter(lambda x: 'mat' in x, files))
    if len(outputFile)==0:
      skipped +=1
    else:
      # print('Testing ' + testFolder + '...')
      outputFile = outputFile[0]
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
        # check which info have been found
      outputStep = outputInterval if outputInterval else stopTime/ numberOfIntervals
      relErr = 1e-3
      with open(os.path.join(testDir, 'tests')) as testParams:
        for line in testParams.readlines():
          if 'rel_err'in line:
            relErr = float((line.replace('=', '')).split()[1])
            break
      test = differplots.DifferPlots(testDir, outputFile, outputStep = outputStep, stopTime = stopTime, rel_tol=relErr)
      (same, message) = test.diff()
      if len(test.differVars):
        tests[testFolder] = test
      if same:
        # print('Success!')
        success +=1
      else:  
        # print(message)
        fail +=1
       #print()
  # print('##############################')
  # print('Comparison Results Summary:')
  # print('##############################')
  # print('Skipped = ' + str(skipped))
  # print('Success = ' + str(success))
  # print('Failed = ' + str(fail))
  stopTime = perf_counter()
  # print(stopTime - startTime)
  if len(tests):
    app = QApplication([])
    app.setStyle('Fusion')
    window = MainWindow(tests)
    window.show()
    app.exec_()