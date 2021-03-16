within NHES.Desalination.Media.BrineProp.Viscosities;
function dynamicViscosity_Jong_T
  input Modelica.Units.SI.Temperature T;
  output Modelica.Units.SI.DynamicViscosity eta;
algorithm
  eta := 2.414 * 0.00001 * 10 ^ (247.8 / (T - 140));
end dynamicViscosity_Jong_T;
