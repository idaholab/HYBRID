within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function velocityOfSound_dTX
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output Velocity v_sound;
algorithm
  v_sound := velocityOfSound_props_dTX(
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
end velocityOfSound_dTX;
