within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function dhv_dp
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output Real dhv_dp;
algorithm
  dhv_dp := IFU.BaseIF97.Regions.dhv_dp(p);
end dhv_dp;
