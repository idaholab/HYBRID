within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function specificEnthalpy_pTX_Driesner
  "enthalpy calculation according to Driesner 2007 et al: 0-1000degC; 0.1-500MPa (doi:10.1016/j.gca.2007.05.026)"
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Modelica.Units.SI.MassFraction X_NaCl "mass fraction m_NaCl/m_Sol";
  output Modelica.Units.SI.SpecificEnthalpy h;
  /**/
algorithm
  //  h := Modelica.Media.Water.WaterIF97_pT.specificEnthalpy_pT(p, SI.Conversions.from_degC(T_Scale_h));
  h := Modelica.Media.Water.WaterIF97_pT.specificEnthalpy_pT(p, T_Scale_h_Driesner(p, T, X_NaCl));
end specificEnthalpy_pTX_Driesner;
