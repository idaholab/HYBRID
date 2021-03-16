within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
partial function PartialCpRatio_KCl_White
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  //  input SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input BrineProp.Types.Molality mola "n_KCl/m_H2O";
  //  output SI.SpecificHeatCapacity cp=1 "=cp_by_cpWater*cp_Water";
  //Parameters of MATLAB 2D-Fit
protected
  Real a = 0.8966;
  Real b = -0.08691;
  Real c = -0.03493;
  Real d = 0.01326;
  Real e = -0.03115;
  Real f = -0.0365;
  Real g = 0.01272;
  Real h = -0.01054;
  Real i = -0.0132;
  BrineProp.Types.Molality b_mean = 1.188;
  BrineProp.Types.Molality b_std = 1.103;
  Modelica.Units.SI.Temperature T_mean=475.1;
  Modelica.Units.SI.Temperature T_std=103.5;
  Real bn = (mola - b_mean) / b_std "normalized & centered";
  Real Tn = (T - T_mean) / T_std "normalized & centered";
  //  SI.SpecificHeatCapacity cp_Water =  Modelica.Media.Water.IF97_Utilities.cp_pT(p, T);
end PartialCpRatio_KCl_White;
