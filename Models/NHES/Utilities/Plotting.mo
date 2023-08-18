within NHES.Utilities;
package Plotting "Contains Model scripts to export variables to plot in matlab"
  function simpleMAT_fileConverter
    "Function to import trajectory result files and write them as MatLab compatible .mat files. To use within Python use commands:
  import scipy.io
  mat = scipy.io.loadmat('file.mat')
  to import the .mat file in as a python dictionary
  "
  input String filename="SteamTurbine_L2_OpenFeedHeat_Test2.mat" "File to be converted" annotation (Dialog(__Dymola_loadSelector(filter="Matlab files (*.mat)",
  caption="Select the results trajectory file")));
  input String varOrigNames[:]={"Time","BOP.sensorW.W", "BOP.sensor_pT.T", "ramp.y", "pump_SimpleMassFlow1.m_flow", "BOP.deaerator.level"} "Variable names/headers in the file in modelica syntax";
    input String varReNames[:]={"Time","Power", "SGOutTemp", "Demand", "PumpMFlow","DLevel"} "Variable names which will appear in the MAT results file";
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
