within NHES.Utilities;
package Plotting "Contains Model scripts to export variables to plot in matlab"
  function simpleMAT_fileConverter
    "Function to import trajectory result files and write them as MatLab compatible .mat files. To use within Python use commands:
  import scipy.io
  mat = scipy.io.loadmat('file.mat')
  to import the .mat file in as a python dictionary
  "
  input String filename="HTGR_Case_01_IndependentBOP_Uprated200MW_Wpumps.mat" "File to be converted" annotation (Dialog(__Dymola_loadSelector(filter="Matlab files (*.mat)",
  caption="Select the results trajectory file")));
  input String varOrigNames[:]={"Time","sensorW.W","demand_BOP2.y[1]",
    "intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.sensorW.y",
    "hTGR_PebbleBed_Primary_Loop_TESUC_AR1_1.Thermal_Power.y","two_Tank_SHS_System_NTU.hot_tank.level","two_Tank_SHS_System_NTU.cold_tank.level",
    "two_Tank_SHS_System_NTU.hot_tank.T","two_Tank_SHS_System_NTU.cold_tank.T","intermediate_Rankine_Cycle_TESUC.sensor_T1.T","intermediate_Rankine_Cycle_TESUC.sensor_T2.T"} "Variable names/headers in the file in modelica syntax";
    input String varReNames[:]={"Time","Power", "DemandedPower", "TESBOP", "ReactorPower","hotlevel","coldlevel","hotTemp","coldTemp","SGoutTemp","SGinTemp"} "Variable names which will appear in the MAT results file";
  input String outputFilename="MatConvertedFile.mat";



  protected
     Integer noRows "Number of rows in the trajectory being converted";
     Integer noColumn=12 "Number of columns in the trajectory being converted";
     Real data[:,:] "Data read in from trajectory file";
     Real dataDump[:,:] "Sacrificial dump variable for writeMatrix command";
     Integer i=2 "Loop counter";



  algorithm



     noRows := DymolaCommands.Trajectories.readTrajectorySize(filename);
     data := DymolaCommands.Trajectories.readTrajectory(
       filename,
       varOrigNames,
       noRows);
  data := transpose(data);
  noColumn := size(data, 2);
  while i <= noColumn loop
     dataDump := [data[:, 1],data[:, i]];
     if i == 2 then
       DymolaCommands.MatrixIO.writeMatrix(
         outputFilename,
         varReNames[i],
         dataDump);
     else
        DymolaCommands.MatrixIO.writeMatrix(
         outputFilename,
         varReNames[i],
         dataDump,
         true);
     end if;
  i := i + 1;
  end while;
  annotation (Documentation(info="<html>
<p></p>
</html>"),   uses(DymolaCommands(version="1.4")));
  end simpleMAT_fileConverter;
end Plotting;
