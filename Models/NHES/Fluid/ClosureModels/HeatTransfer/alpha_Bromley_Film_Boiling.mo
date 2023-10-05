within NHES.Fluid.ClosureModels.HeatTransfer;
function alpha_Bromley_Film_Boiling

  input Modelica.Units.SI.Temperature Tw "Wall Temperature";
  input Modelica.Units.SI.Temperature Tsat "Fluid Saturation Temperature";
  input Modelica.Units.SI.SpecificEnthalpy h_g "Saturated Vapor Enthaply";
  input Modelica.Units.SI.SpecificEnthalpy h_f "Saturated Liquid Enthaply";
  input Modelica.Units.SI.Density rho_g "Saturated Vapor Density";
  input Modelica.Units.SI.Density rho_f "Saturated Liquid Density";
  input Modelica.Units.SI.ThermalConductivity kv "Saturated Vapour Thermal Conductivity";
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp "Cp of Saturated Vapor";
  input Real Pr "Prandtl Number of Saturated Vapor";
  input Modelica.Units.SI.Diameter D;
  output Modelica.Units.SI.CoefficientOfHeatTransfer alpha;
protected
  Modelica.Units.SI.TemperatureDifference dTS;
  Modelica.Units.SI.SpecificEnthalpy lambda;
  Modelica.Units.SI.SpecificEnthalpy lambdamod;
  Real imv;
algorithm
  dTS:=Tw - Tsat;
  lambda:=h_g-h_f;
  lambdamod:=lambda*(1 + ((0.34*Cp*dTS)/lambda));
  imv:=abs((kv^2)*rho_g*(rho_f - rho_g)*9.81 .* lambdamod*Cp/(D*dTS*Pr));
  alpha:=0.62*(imv)^0.25;
  annotation ();
end alpha_Bromley_Film_Boiling;
