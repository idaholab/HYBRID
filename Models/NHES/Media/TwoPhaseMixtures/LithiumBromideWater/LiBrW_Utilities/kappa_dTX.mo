within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function kappa_dTX
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output IsothermalCompressibility kappa;
algorithm
  kappa := kappa_props_dTX(
          d,
          T,
          X,
          lithiumBromideWaterBaseProp_dTX(
            d,
            T,
            X,
            phase,
            region));
  annotation (Inline=true);
end kappa_dTX;
