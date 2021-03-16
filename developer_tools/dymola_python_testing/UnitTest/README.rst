Folder containing a test Modelica model package (ModelicaPyUnitTest) and its corresponding
Resources folder.  These are used to test the testing system.  Run the test by using 
Python to execute ModelicaPy/UnitTest_RunMe.py 

ModelicaPyUnitTest:
Folder containing a test Modelica model package used to test the testing system.  
                     
Resources:
Folder that contains the files needed for buildingspy to test the model contained 
in the ModelicaPyUnitTest folder.  The file specifying the model output variables 
to examine is contained in file Resources/Scripts/Dymola/EmptyTanks.mos.  The reference 
results are found in Resources/ReferenceResults/Dymola/ModelicaPyUnitTest_EmptyTanks.txt.  
A file with some results that deviate from expected results is provided in 
ModelicaPyUnitTest_EmptyTanks.txt.fails (copy this to ModelicaPyUnitTest_EmptyTanks.txt to 
test the behavior of the test system when a result deviates from expedted).  
