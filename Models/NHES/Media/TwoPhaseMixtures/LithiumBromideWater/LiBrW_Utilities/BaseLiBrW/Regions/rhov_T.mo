within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function rhov_T
  extends Modelica.Icons.Function;
  input Temperature T;
  output Density rho;
algorithm
  rho := IFU.BaseIF97.Regions.rhov_T(T);
  annotation (Inline=true);
end rhov_T;
