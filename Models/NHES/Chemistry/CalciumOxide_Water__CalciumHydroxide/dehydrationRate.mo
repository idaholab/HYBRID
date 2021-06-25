within NHES.Chemistry.CalciumOxide_Water__CalciumHydroxide;
function dehydrationRate "Schaube et al 2012"
  input Temperature T "Bed temperature";
  input AbsolutePressure p "Vapor pressure";
  input DimensionlessRatio x_d "Conversion";
  output Real dxdt(unit="1/s") "Conversion rate";
protected
  AbsolutePressure p_eq=equilibrium_pressure(T);
  MolarHeatCapacity R_u=Modelica.Constants.R;
  Real A_lo_x(unit="1/s") = 1.9425e12;
  Real E_lo_x(unit="J/mol") = -187.88e3;
  Real A_hi_x(unit="1/s") = 8.9588e9;
  Real E_hi_x(unit="J/mol") = -162.62e3;
  Real x_dc=if x_d < 0 then 0.0 else if x_d > 1 then 1.0 else x_d;
algorithm
  dxdt := if (x_dc >= 0 and x_dc <= 0.2) then A_lo_x*Modelica.Math.exp(
    E_lo_x/(R_u*T))*((1 - (p/p_eq))^3)*(1 - x_dc) else if (x_dc > 0.2 and
    x_dc <= 1) then A_hi_x*Modelica.Math.exp(E_hi_x/(R_u*T))*((1 - (p/p_eq))
    ^3)*2*(1 - x_dc)^0.5 else 0.0;
  annotation (smoothOrder=2);
end dehydrationRate;
