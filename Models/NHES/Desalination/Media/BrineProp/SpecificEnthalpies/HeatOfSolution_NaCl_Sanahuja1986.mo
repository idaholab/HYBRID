within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function HeatOfSolution_NaCl_Sanahuja1986
  "2nd degree polynomial fit from Sanahuja1986 http://dx.doi.org/10.1016/0021-9614(86)90063-7"
  input Modelica.Units.SI.Temperature T;
  output Types.PartialMolarEnthalpy h_sol = (-0.0022 * T ^ 2) + 1.22886 * T - 166.889
    "[J/mol_NaCl]";
algorithm

end HeatOfSolution_NaCl_Sanahuja1986;
