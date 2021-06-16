within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function beta_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output RelativePressureCoefficient beta;
algorithm
  beta := beta_props_pTX(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X,
            region));
  annotation (Inline=true);
end beta_pTX;
