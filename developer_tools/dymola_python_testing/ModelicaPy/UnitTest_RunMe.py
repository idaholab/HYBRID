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
"""
Created on Thu Jun 09 14:13:04 2016

@author: wn9
"""
print """
****************Unit Testing for ModelicaPy v1.1****************
---- This is a unit test for any Modelica Library that
---- utilizes a modified version of the BuildingsPy library.
---- This script was designed to run regression tests when
---- the resources folder is not in the same directory as
---- the top level package.mo file (the origional BuildingsPy
---- assumes Resources and top level package.mo are in the
---- same direcroty).
----
---- To run properly Dymola must be on the system path.
----
---- :param libHome: directory that contains top level package.mo
---- :param rootDir: directory that contains Resources folder.
----
---- This script assumes it is within ModelicaPy itself.
---- However, it can be modified to:
---- *Assume Buildingspy is on system path
----         -Comment out line 55
---- *Hardcode in a custom path to BuildingsPy
----         -Comment out line 55
----         -Uncomment line 57 and enter path manually
----
---- This script will run simulations, gather output, and
---- compare to existing results issuing a pass or fail.
---- If there are no stored results or results differ you
---- can accept or reject simulation results.
----
---- For more documentation on BuildingsPy please visit
---- http://simulationresearch.lbl.gov/modelica/buildingspy/
************************************************************
"""

import sys, os

def run_unit_tests(libHome, rootDir):
    """
    function run_unit_tests takes inputs that are the absolute path to the
    resources folder and top level package.mo
    This is important since BuildingsPy was written in a way that the resources
    folder and package.mo must be in the same directory. This script is capable
    of running unit tests on single packages. By Default it tests all .mos 
    scripts found in rootDir. Calling with one parameter will run unit tests on
    the sing package specified e.g. python our_test.py Turbine will test only 
    the Turbine.mos script.

    """
    
    # User Input Section
    
    # Go to bottom of script and set variables "hom" and "res".
    
    # Single Test:
    # Set runSingleTest = 1 to simulate a single test with specified name 
    # else command line name else run all examples in package "hom". 
    #runSingleTest = 1
    runSingleTest = 0
    runSingleTestName = "EmptyTanks"
    
    # End User Input
    
    # Path to buildingspy (relative to this file)
    BPDir = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), 'buildingspy')

    print "Looking for BuildingsPy in" , BPDir
    
    sys.path.append(BPDir)
      
    # ensure log files are written to the working directory
    os.chdir(rootDir)
    try:
        import buildingspy.development.regressiontesttwo as regTest
    except ImportError as e:
        print "Could not find BuildingsPy in %s" % BPDir
        raise(e)
    tester=regTest.Tester(check_html=False)
     
        
    """
    Use this section to set parameters for testing
    """    
    tester.setLibraryRoot(libHome, rootDir)    
    #tester.showGUI(show=False) # show IDE (i.e., Dymola window) on simulation
    tester.showGUI(show=True) # show IDE (i.e., Dymola window) on simulation
    tester.setNumberOfThreads(4) # Set max number of processes. Comment out to default to as many as available/needed.
    tester.batchMode(batchMode=False) #=true then runs without interactive input to the console (i.e., no prompt for file creation)
    tester.deleteTemporaryDirectories(True)
    #tester.setMosLocation(moslocation)
    #tester.useExistingResults(dirs)
    #tester.pendanticModelica(pendanticModelica=True)
    #tester.include_fmu_tests(fmu_export=False)

    if len(sys.argv) > 1:
        command = sys.argv[1]
        tester.TestSinglePackage(r"%s" % command, SinglePack=True)
    elif runSingleTest == 1:
        command = runSingleTestName
        tester.TestSinglePackage(r"%s" % command, SinglePack=True)
		
    numPassed = 0
    numPassedWarn = 0
    numFailed = 0
    rv=tester.run()
    if rv == 0:
      print "#  BuildingsPy Test Framework Returns: ", rv ," (PASSED)"
      numPassed = numPassed + 1
    elif rv == 2:
      print "#  BuildingsPy Test Framework Returns: ", rv ," (PASSED WITH WARNINGS)"
      numPassedWarn = numPassedWarn + 1
    else:
      print "#  BuildingsPy Test Framework Returns: ", rv ," (FAILED)"
      numFailed = numFailed + 1

if __name__ == '__main__':
       
    # Set the directory with the package.mo file of interest ("hom")
    # "r" prevents escape characters in path 
    hom = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), '..', 'UnitTest', 'ModelicaPyUnitTest')
    res = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), '..', 'UnitTest')

    run_unit_tests(hom,res)
