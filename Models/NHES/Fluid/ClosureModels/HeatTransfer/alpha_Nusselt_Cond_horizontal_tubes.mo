within NHES.Fluid.ClosureModels.HeatTransfer;
function alpha_Nusselt_Cond_horizontal_tubes

  input Modelica.Units.SI.Temperature Tw "Wall Temperature";
  input Modelica.Units.SI.Temperature Tsat "Fluid Saturation Temperature";
  input Modelica.Units.SI.SpecificEnthalpy h_g "Saturated Vapor Enthaply";
  input Modelica.Units.SI.SpecificEnthalpy h_f "Saturated Liquid Enthaply";
  input Modelica.Units.SI.Density rho_g "Saturated Vapor Density";
  input Modelica.Units.SI.Density rho_f "Saturated Liquid Density";
  input Modelica.Units.SI.ThermalConductivity kv "Saturated liquid Thermal Conductivity";
  input Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp "Cp of Saturated Liquid";
  input Real Pr "Prandtl Number of Saturated Liquid";
  input Modelica.Units.SI.Diameter D;
  output Modelica.Units.SI.CoefficientOfHeatTransfer alpha;
protected
  Modelica.Units.SI.TemperatureDifference dTS;
  Modelica.Units.SI.SpecificEnthalpy lambda;
  Modelica.Units.SI.SpecificEnthalpy lambdamod;
  Real imv;
algorithm
  dTS:= Tsat- Tw;
  lambda:=h_g-h_f;
  imv:=abs((kv^2)*rho_f*(rho_f - rho_g)*9.81 .* lambda*Cp/(D*dTS*Pr));
  alpha:=0.555*(imv)^0.25;
  annotation ();
end alpha_Nusselt_Cond_horizontal_tubes;
