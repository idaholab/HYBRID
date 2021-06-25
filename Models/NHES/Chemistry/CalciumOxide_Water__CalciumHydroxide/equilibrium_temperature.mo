within NHES.Chemistry.CalciumOxide_Water__CalciumHydroxide;
function equilibrium_temperature
  input AbsolutePressure p "Vapor pressure";
  output Temperature T "Bed temperature";
protected
  AbsolutePressure A=10^5;
  Temperature B=12845;
algorithm
  T := -B/(Modelica.Math.log(max(p, 1)/A) - 16.508);
end equilibrium_temperature;
