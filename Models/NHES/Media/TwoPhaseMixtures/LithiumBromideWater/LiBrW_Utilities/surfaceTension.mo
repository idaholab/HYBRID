within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function surfaceTension
  extends Modelica.Icons.Function;
  input Temperature T;
  output SurfaceTension sigma;
algorithm
  sigma := IFU.BaseIF97.Transport.surfaceTension(T);
  annotation (Inline=true);
end surfaceTension;
