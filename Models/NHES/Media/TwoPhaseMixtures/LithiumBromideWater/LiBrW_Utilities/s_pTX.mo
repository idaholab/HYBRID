within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function s_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output SpecificEntropy s;
algorithm
  s := s_props_pTX(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X,
            region));
  annotation (Inline=true, smoothOrder=2);
end s_pTX;
