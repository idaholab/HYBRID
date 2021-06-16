within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function rhol_p
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output Density rho;
algorithm
  rho := IFU.BaseIF97.Regions.rhol_p(max(p, 612));
  annotation (Inline=true);
end rhol_p;
