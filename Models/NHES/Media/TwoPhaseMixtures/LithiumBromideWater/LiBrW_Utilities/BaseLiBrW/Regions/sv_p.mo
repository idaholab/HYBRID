within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function sv_p
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output SpecificEntropy s;
algorithm
  s := IFU.BaseIF97.Regions.sv_p(p);
  annotation (Inline=true);
end sv_p;
