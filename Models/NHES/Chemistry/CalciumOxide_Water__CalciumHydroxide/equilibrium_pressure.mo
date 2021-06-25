within NHES.Chemistry.CalciumOxide_Water__CalciumHydroxide;
function equilibrium_pressure
  input Temperature T "Bed temperature";
  output AbsolutePressure p "Vapor pressure";
protected
  AbsolutePressure A=10^5;
  Temperature B=12845;
algorithm
  p := A*Modelica.Math.exp(16.508 - (B/T));
end equilibrium_pressure;
