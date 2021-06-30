within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function thermalConductivity
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input AbsolutePressure p;
  input MassFraction X[:];
  input Integer phase=0;
  output ThermalConductivity lambda;
algorithm
  lambda := BaseLiBrW.Transport.cond_dTpX(
          d,
          T,
          p,
          X,
          phase);
  annotation (Inline=true);
end thermalConductivity;
