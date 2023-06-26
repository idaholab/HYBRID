within NHES.SIunits.Conversions;
function to_MW "Power: [W] -> [MW]"
  extends TRANSFORM.Units.Conversions.Functions.Power_W.BaseClasses.to;
algorithm
  y := u/1000000;
end to_MW;
