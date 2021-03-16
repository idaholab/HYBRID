#Licensed under Apache 2.0 License.
#© 2020 Battelle Energy Alliance, LLC
#ALL RIGHTS RESERVED
#.
#Prepared by Battelle Energy Alliance, LLC
#Under Contract No. DE-AC07-05ID14517
#With the U. S. Department of Energy
#.
#NOTICE:  This computer software was prepared by Battelle Energy
#Alliance, LLC, hereinafter the Contractor, under Contract
#No. AC07-05ID14517 with the United States (U. S.) Department of
#Energy (DOE).  The Government is granted for itself and others acting on
#its behalf a nonexclusive, paid-up, irrevocable worldwide license in this
#data to reproduce, prepare derivative works, and perform publicly and
#display publicly, by or on behalf of the Government. There is provision for
#the possible extension of the term of this license.  Subsequent to that
#period or any extension granted, the Government is granted for itself and
#others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide
#license in this data to reproduce, prepare derivative works, distribute
#copies to the public, perform publicly and display publicly, and to permit
#others to do so.  The specific term of the license can be identified by
#inquiry made to Contractor or DOE.  NEITHER THE UNITED STATES NOR THE UNITED
#STATES DEPARTMENT OF ENERGY, NOR CONTRACTOR MAKES ANY WARRANTY, EXPRESS OR
#IMPLIED, OR ASSUMES ANY LIABILITY OR RESPONSIBILITY FOR THE USE, ACCURACY,
#COMPLETENESS, OR USEFULNESS OR ANY INFORMATION, APPARATUS, PRODUCT, OR
#PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY
#OWNED RIGHTS.
# -*- coding: utf-8 -*-
from __future__ import division

#!/usr/bin/env python
import sys, os, re, getopt, time, datetime

def getImmediateSubdirectories(a_dir):
  return [name for name in os.listdir(a_dir)
    if os.path.isdir(os.path.join(a_dir, name))]

# Get the name (without extension) of all files in the directory having extension .mos
def getMosFilesInDirectory(a_dir):
  return [os.path.splitext(f)[0] for f in os.listdir(a_dir) 
    if os.path.isfile(os.path.join(a_dir, f)) and f.endswith(".mos")]

def printLongHelp():
  print "#-----------------------------------------------------------------------------------------------"
  print "#"
  print "#  Hybrid Systems Test Script (run_tests)"
  print "#"
  print "#  Makes extensive use of 'buildingspy', part of the Modelica Buildings Library"
  print "#  (http://simulationresearch.lbl.gov/modelica/buildingspy/) as modified by Scott" 
  print "#  Greenwood of Oak Ridge National Laboratory (ORNL)."
  print "#"
  print "#  Command Format:"
  print "#"
  print "#    run_test [-h | --help] [-i | --interactive] [ -r | --re (regular expression)]"
  print "#"
  print "#  Where:"
  print "#    '-h' or '--help' shows this help text"
  print "#    '-i' or '--interactive' runs buildingpy tests in interactive mode.  In this mode deviations"
  print "#                            from expected test outputs will be shown using plots and the user"
  print "#                            is prompted to optionally set the test output as the new expected"
  print "#                            values." 
  print "#    '-g' or '--gui' will display the Dymola graphical user interface while test runs are in"
  print "#                    progress."
  print "#    '-r' or '--re' <regular expression> causes only those tests whose script file names" 
  print "#                                        match the provided regular expression to be run."  
  print "#    '-p' or '--proc' <number of processes> limits maximum number of processes (default is"
  print "#                                           to use all available)."
  print "#"
  print "#  Prerequisites:"
  print "#"
  print "#    - The command 'dymola' must be in your PATH"
  print "#    - Python, and Python packages 'matplotlib.pyplot' and 'scipy.io' need to be available"
  print "#        (Required by BuildingsPy)"
  print "#    - The Modelica package containing the models is contained in the NHES directory below"
  print "#        the one containing this script"
  print "#    - The .mos files specifying what to test are contained in the Resources directory below"
  print "#        the one containing this script"
  print "#"
  print "#  Script Steps:"
  print "#  1) Scan the Resources (right below this one) directory for .mos files. "
  print "#  2) Remove .mos file names not matching the regular expression (if provided)."
  print "#  3) Run the ModelicaPy tests on each of these, keeping track of return values."
  print "#  4) Return zero if all tests pass, non-zero if any test fails."
  print "#"
  print "#-----------------------------------------------------------------------------------------------"

def main_script():
  # Set the current working directory to the directory where this script is located
  myDir = os.path.abspath(os.path.dirname(sys.argv[0]))
  os.chdir(myDir)

  # See if a regular expression was provided or we're in interactive mode
  interactiveMode = False
  showDymolaGUI = False
  regularExpression = ''
  maxProcessors = 0	# Zero means use all
  try:
    opts, args = getopt.getopt(sys.argv[1:], "ghir:p:", ["gui", "help", "interactive", "re=", "proc="])
  except getopt.GetoptError:
    print 'run_test [-h | --help] [-g | --gui] [-i | --interactive] [ -r | --re (regular expression)] [-p | --proc <# procs>]'
    sys.exit(2)

  for opt, arg in opts:
    if opt in ("-h", "--help"):
      printLongHelp()
      sys.exit()
    elif opt in ("-g", "--gui"):
      showDymolaGUI = True
    elif opt in ("-i", "--interactive"):
      interactiveMode = True
    elif opt in ("-r", "--re"):
      regularExpression = arg
    elif opt in ("-p", "--proc"):
      # Argument should be an integer >= 0
      try:
        maxProcessors = int(arg)
      except ValueError:
        print 'run_test: Argument to [-p | -proc] must be an integer'
        sys.exit()
      if maxProcessors < 0:
        print 'run_test: Argument to [-p | -proc] must be >= 0'
        sys.exit()

  # OK, since we're not printing the help do the banner instead
  print "############################################################"
  print "#"  
  print "#  HYBRID SYSTEMS MODELICA TESTING"
  print "#  Run:", datetime.datetime.now()
  print "#"  
  print "#  Current Directory: ", myDir  
  if interactiveMode:
    print '#  Interactive Mode Selected'
  if maxProcessors == 0:
    print '#  Using all available processors'
  else:
    print '#  Using at most ' + str(maxProcessors) + ' processor(s)'
  print "#"  
  scriptPath = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), 
		'Models', 'Resources', 'Scripts', 'Dymola')
  print "#  Searching for .mos scripts in: ", scriptPath 
  print "#"

  # Get a list of .mos files in Resources
  scriptFiles = getMosFilesInDirectory(scriptPath)
  print "#  Script Files Found:", scriptFiles

  # If a regular expression is provided, filter on it
  if regularExpression != '':
    print '#  Regular Expression is:', regularExpression
    regex = re.compile(regularExpression)
    scriptFiles = [sf for sf in scriptFiles if regex.search(sf)]
    print "#  Filtered Script Files:", scriptFiles

  # Make sure we can find ModelicaPy
  MPPath = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), 'Testing', 'ModelicaPy')
  print "#"  
  print "#  Searching for ModelicaPy in:", MPPath
  sys.path.append(MPPath)
  try:
    import buildingspy.development.regressiontesttwo as regTest
  except ImportError:
    print "#"  
    print '#  Unable to find ModelicaPy library--Exiting'
    print "#"  
    print "############################################################"
    exit(1)
  print "#"  

  # Get the paths figured out for the tester
  modelPath = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), 
		'Models', 'NHES')
  resourceContainingPath = os.path.join(os.path.abspath(
		os.path.dirname(sys.argv[0])), 'Models')

  # Loop through the filtered list and call the tests in each subdirectory.  Total up
  #   the number of passes and fails:
  numPassed = 0
  numPassedWarn = 0
  numFailed = 0
  startTime = time.time()
  for sf in scriptFiles:
    print "############################################################"
    print "#  Running Test: ", sf
    # Create a new tester (without html matching)
    tester = regTest.Tester(check_html=False)
    tester.setLibraryRoot(modelPath, resourceContainingPath)    
    tester.showGUI(show = showDymolaGUI)
    if interactiveMode:
      tester.batchMode(False)
    else:
      tester.batchMode(True)
    tester.deleteTemporaryDirectories(True)
    #tester.setMosLocation(moslocation)
    #tester.useExistingResults(dirs)
    #tester.pendanticModelica(pendanticModelica=True)
    #tester.include_fmu_tests(fmu_export=False)
  
    # The buildingspy tester can use multiple processors.  The default is to use all available,
    #   but it may be limited also to keep the load down and reduce the need for Dymola licenses.
    if maxProcessors > 0: 
      tester.setNumberOfThreads(maxProcessors)

    tester.TestSinglePackage(sf, SinglePack=True)
    rv = tester.run()

    # The test will return zero if the run is clean, 1 if there are errors (with or without 
    #   warnings), 2 if there are warnings but no errors, and >2 for other problems. 
    # We will accept clean and warnings only
    if rv == 0:
      print "#  BuildingsPy Test Framework Returns: ", rv ," (PASSED)"
      numPassed = numPassed + 1
    elif rv == 2: 
      print "#  BuildingsPy Test Framework Returns: ", rv ," (PASSED WITH WARNINGS)"
      numPassedWarn = numPassedWarn + 1
    else:
      print "#  BuildingsPy Test Framework Returns: ", rv ," (FAILED)"
      numFailed = numFailed + 1
  stopTime = time.time()

  print "############################################################"
  print "#  Test Results: ", numPassed, " Passed, ", numPassedWarn, " Passed With Warnings, ", numFailed, " Failed " 
  print("#  %d Test(s) run in %.2f seconds" % (numPassed + numPassedWarn + numFailed, stopTime - startTime) )
  print "############################################################"

  # If any failed, return a non-zero code
  exit(numFailed)


# The code is structured this way because buildingspy uses multiprocessing, which was found to have problems
#   forking new processes on Windows when not set up as calling a separate function protected by 
#   "if __name__ == '__main__'. 
if __name__ == '__main__':
  main_script()
