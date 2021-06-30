within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function kappa_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output IsothermalCompressibility kappa;
algorithm
  kappa := kappa_props_phX(
          p,
          h,
          X,
          lithiumBromideWaterBaseProp_phX(
            p,
            h,
            X,
            phase,
            region));
  annotation (Inline=true);
end kappa_phX;
