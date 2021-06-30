within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function drhov_dp
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output Real drhov_dp;
algorithm
  drhov_dp := IFU.BaseIF97.Regions.drhov_dp(p);
end drhov_dp;
