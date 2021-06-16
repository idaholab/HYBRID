within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function hl_p
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output SpecificEnthalpy h;
algorithm
  h := IFU.BaseIF97.Regions.hl_p(max(p, 612));
  annotation (Inline=true);
end hl_p;
