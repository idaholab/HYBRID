within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
function ThreeDTableRead
  "Reads a 3d table from a file, tables need to be labelled with \"tablename#\" where \"#\" goes from 1 to the number of tables in the file."
  input Integer n1, n2, n3;
  input String filename;
  input String tablename;
  output Real table[n1, n2, n3];

protected
  //Real table2d[n1, n2];
  String numstring;
algorithm
  /* table2d :=Modelica.Utilities.Streams.readRealMatrix(
    filename,
    tablename,
    n1,
    n2,
    false);*/
   for k in 1:n3 loop
     numstring :=String(k);
     table[:, :, k] :=Modelica.Utilities.Streams.readRealMatrix(filename, tablename + numstring, n1, n2, false);
   end for;


end ThreeDTableRead;
