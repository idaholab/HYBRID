within NHES.Desalination.Media.BrineProp.Viscosities;
function PureWater_dynamicViscosity_Jong_T
  input Modelica.Units.SI.Temperature T;
  output Modelica.Units.SI.DynamicViscosity eta;
protected
  Modelica.Units.NonSI.Temperature_degC T_C;
algorithm
  T_C :=Modelica.Units.Conversions.to_degC(T);
  eta := 4.2844 * 1e-5 + 1 / (0.157 * (T_C + 64.993) ^ 2 - 91.296);
end PureWater_dynamicViscosity_Jong_T;
