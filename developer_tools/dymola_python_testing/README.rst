This folder contains the automated test system for Modelica models, using  
the "buildingspy" system from Lawrence Berkeley National Laborary 
(http://simulationresearch.lbl.gov/modelica/buildingspy/).  Scott 
Greenwood from Oak Ridge National Laboratory provided modifications
to buildingspy that allows testing Modelica packages and storing the 
associated Resources folder (containing the scripts that specify what
model variables should be compared and their baseline test results).

ModelicaPy:
Folder containing original buildingspy code and modifications 
(mainly contained in file regressiontesttwo.py in ModelicaPy/buildingspy/development).  
Also contains a script UnitTest_RunMe.py that will run a test of this system.  
(Requires the command 'dymola' to be in the current PATH, and the Modelica 
ThermoPower library to be available to Dymola.  One way to do this is to add 
"AddModelicaPath(<path to ThermoPower>, erase=false);" to Dymola's startup script).

UnitTest: 
Folder containing a test Modelica model package (ModelicaPyUnitTest) and its corresponding
Resources folder.  These are used to test the testing system.  Run the test by using 
Python to execute ModelicaPy/UnitTest_RunMe.py 
