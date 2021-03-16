within NHES.Desalination.Media.BrineProp.GasData;
partial function partial_solutionEnthalpy
  "template for calculation of solution enthalpy"
  input Modelica.Units.SI.Temperature T;
  output Modelica.Units.SI.SpecificEnthalpy Delta_h_solution;
protected
  Modelica.Units.SI.Pressure p_H2O;
end partial_solutionEnthalpy;
