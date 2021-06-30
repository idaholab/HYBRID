within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function isentropicExponent_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output Real gamma;
algorithm
  gamma := isentropicExponent_props_phX(
          p,
          h,
          X,
          lithiumBromideWaterBaseProp_phX(
            p,
            h,
            X,
            phase,
            region));
  annotation (Inline=false, LateInline=true);
end isentropicExponent_phX;
