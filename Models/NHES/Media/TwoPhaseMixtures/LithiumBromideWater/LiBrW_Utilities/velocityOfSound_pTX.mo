within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function velocityOfSound_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output Velocity v_sound;
algorithm
  v_sound := velocityOfSound_props_pTX(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X,
            region));
  annotation (Inline=true);
end velocityOfSound_pTX;
