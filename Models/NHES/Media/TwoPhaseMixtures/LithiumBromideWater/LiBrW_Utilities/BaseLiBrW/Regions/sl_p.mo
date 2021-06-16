within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function sl_p
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output SpecificEntropy s;
algorithm
  s := IFU.BaseIF97.Regions.sl_p(p);
  annotation (Inline=true);
end sl_p;
