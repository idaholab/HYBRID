within NHES.SIunits.Conversions;
function to_kW "Power: [W] -> [kW]"
  extends TRANSFORM.Units.Conversions.Functions.Power_W.BaseClasses.to;
algorithm
  y := u/1000;
end to_kW;
