within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function dynamicViscosity
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input AbsolutePressure p;
  input MassFraction X[:];
  input Integer phase=0;
  output DynamicViscosity eta;
algorithm
  eta := BaseLiBrW.Transport.visc_dTpX(
          d,
          T,
          p,
          X,
          phase);
  annotation (Inline=true);
end dynamicViscosity;
