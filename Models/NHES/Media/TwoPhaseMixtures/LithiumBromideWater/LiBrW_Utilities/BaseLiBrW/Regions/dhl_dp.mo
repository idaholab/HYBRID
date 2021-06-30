within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function dhl_dp
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output Real dhl_dp;
algorithm
  dhl_dp := IFU.BaseIF97.Regions.dhl_dp(p);
end dhl_dp;
