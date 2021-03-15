within NHES.Desalination.Media.BrineProp.Viscosities;
function dynamicViscosity_Jong_TX
  input Modelica.Units.SI.Temperature T "Absolute temperature";
  input Modelica.Units.SI.MassFraction X[:] "mass fraction m_NaCl/m_Sol";
  output Modelica.Units.SI.DynamicViscosity eta;
protected
  Modelica.Units.NonSI.Temperature_degC T_C;
  Real A, B;
  Modelica.Units.SI.DynamicViscosity eta_pureWater;
  Modelica.Units.SI.MassFraction S "Salinity [kg/kg]";
algorithm
  T_C :=Modelica.Units.Conversions.to_degC(T)    "Celsius";
  eta_pureWater :=
    Desalination.Media.BrineProp.Viscosities.PureWater_dynamicViscosity_Jong_T(
    T);
  A := 1.541 + 1.998 * 1e-2 * T_C - 9.52 * 1e-5 * T_C ^ 2;
  B := 7.974 - 7.561 * 1e-2 * T_C + 4.724 * 1e-4 * T_C ^ 2;
  S := X[1];
  eta := eta_pureWater * (1 + A * S + B * S ^ 2);
end dynamicViscosity_Jong_TX;
