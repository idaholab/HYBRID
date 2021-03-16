within NHES.Desalination.Utilities;
function Density_TS
  // Calculate the fluid density as a function of salinity
  input Modelica.Units.SI.Temperature T "Absolute temperature";
  input Salinity S "Salinity [ppm]";
  output Modelica.Units.SI.Density rho "density [kg/m3]";
algorithm
  rho := 0.000751002145411799 * S + 23795.9145554065 / T + 916.823130831987;
end Density_TS;
