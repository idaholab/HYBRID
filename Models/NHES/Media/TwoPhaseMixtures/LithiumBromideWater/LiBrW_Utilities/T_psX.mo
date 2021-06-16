within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function T_psX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEntropy s;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output Temperature T;
algorithm
  T := T_props_psX(
          p,
          s,
          X,
          lithiumBromideWaterBaseProp_psX(
            p,
            s,
            X,
            phase,
            region));
  annotation (Inline=true, smoothOrder=2);
end T_psX;
