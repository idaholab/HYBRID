within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
function ThreeDTablefrom2D
  "Generates an enumerated 3D table from a file-read 2D matrix, equal in the 3rd dimension at every 2D index."
  input Integer n1, n2, n3;
  input String filename;
  input String tablename;
  output Real table[n1, n2, n3];

protected
  Real table2d[n1, n2];
algorithm
   table2d :=Modelica.Utilities.Streams.readRealMatrix(
    filename,
    tablename,
    n1,
    n2,
    false);
   for k in 1:n3 loop
     table[:, :, k] :=table2d;
   end for;

end ThreeDTablefrom2D;
