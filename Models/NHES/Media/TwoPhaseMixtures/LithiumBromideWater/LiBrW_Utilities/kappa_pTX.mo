within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function kappa_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output IsothermalCompressibility kappa;
algorithm
  kappa := kappa_props_pTX(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X,
            region));
  annotation (Inline=true);
end kappa_pTX;
