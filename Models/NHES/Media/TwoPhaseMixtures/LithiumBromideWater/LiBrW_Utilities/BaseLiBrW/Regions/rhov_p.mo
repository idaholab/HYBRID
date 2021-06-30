within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function rhov_p
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  output Density rho;
algorithm
  rho := IFU.BaseIF97.Regions.rhov_p(max(p, 612));

  annotation (Inline=true);
end rhov_p;
