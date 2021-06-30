within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function ddphX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output DerDensityByPressure ddphX;
algorithm
  ddphX := ddphX_props(
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
end ddphX;
