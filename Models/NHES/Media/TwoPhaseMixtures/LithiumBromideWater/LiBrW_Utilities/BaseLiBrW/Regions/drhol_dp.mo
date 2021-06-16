within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function drhol_dp
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output Real drhol_dp;
algorithm
  drhol_dp := IFU.BaseIF97.Regions.drhol_dp(p);
end drhol_dp;
