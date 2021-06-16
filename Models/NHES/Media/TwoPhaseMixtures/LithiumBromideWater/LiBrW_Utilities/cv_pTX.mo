within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function cv_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output SpecificHeatCapacity cv;
algorithm
  cv := cv_props_pTX(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X,
            region));
  annotation (Inline=true);
end cv_pTX;
