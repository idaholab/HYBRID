within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function rhol_T
  extends Modelica.Icons.Function;
  input Temperature T;
  output Density rho;
algorithm
  rho := IFU.BaseIF97.Regions.rhol_T(T);
  annotation (Inline=true);
end rhol_T;
