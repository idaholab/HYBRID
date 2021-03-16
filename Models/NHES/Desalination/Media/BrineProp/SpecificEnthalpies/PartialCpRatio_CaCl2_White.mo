within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
partial function PartialCpRatio_CaCl2_White
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  //  input SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input BrineProp.Types.Molality mola "n_KCl/m_H2O";
  //  output SI.SpecificHeatCapacity cp=1 "=cp_by_cpWater*cp_Water";
  //Parameters of MATLAB 2D-Fit
protected
  Real a = 0.8729;
  Real b = -0.1118;
  Real c = -0.01051;
  Real d = 0.0244;
  Real e = -0.01634;
  Real f = -0.01823;
  Real g = 0.008315;
  Real h = -0.01568;
  Real i = -0.01057;
  BrineProp.Types.Molality b_mean = 0.9803;
  BrineProp.Types.Molality b_std = 1.047;
  Modelica.Units.SI.Temperature T_mean=437.7;
  Modelica.Units.SI.Temperature T_std=104.5;
  Real bn = (mola - b_mean) / b_std "normalized & centered";
  Real Tn = (T - T_mean) / T_std "normalized & centered";
  //  SI.SpecificHeatCapacity cp_Water =  Modelica.Media.Water.IF97_Utilities.cp_pT(p, T);
end PartialCpRatio_CaCl2_White;
