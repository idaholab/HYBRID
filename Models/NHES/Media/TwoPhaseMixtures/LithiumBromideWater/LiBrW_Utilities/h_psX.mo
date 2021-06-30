within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function h_psX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEntropy s;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output SpecificEnthalpy h;
algorithm
  h := h_props_psX(
          p,
          s,
          X,
          lithiumBromideWaterBaseProp_psX(
            p,
            s,
            X,
            phase,
            region));
  annotation (Inline=true);
end h_psX;
