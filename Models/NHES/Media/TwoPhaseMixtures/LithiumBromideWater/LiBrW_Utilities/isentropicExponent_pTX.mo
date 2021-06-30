within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function isentropicExponent_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output Real gamma;
algorithm
  gamma := isentropicExponent_props_pTX(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X,
            region));
  annotation (Inline=false, LateInline=true);
end isentropicExponent_pTX;
