within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function HeatOfSolution_KCl_Sanahuja1986
  "2nd degree polynomial fit from Sanahuja1986 http://dx.doi.org/10.1016/0021-9614(86)90063-7"
  input Modelica.Units.SI.Temperature T;
  output Types.PartialMolarEnthalpy h_sol = (-0.0102 * T ^ 2) + 6.12926 * T - 904.206
    "[J/mol_NaCl]";
algorithm

end HeatOfSolution_KCl_Sanahuja1986;
