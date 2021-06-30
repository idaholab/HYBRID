within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function hv_p
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output SpecificEnthalpy h;
algorithm
  h := IFU.BaseIF97.Regions.hv_p(max(p, 612));
  annotation (Inline=true);
end hv_p;
