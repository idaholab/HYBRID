within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Transport;
function visc_dTpX
  extends Modelica.Icons.Function;
  input Density d;
  input SI.Temperature T;
  input SI.AbsolutePressure p;
  input SI.MassFraction X[:];
  input Integer phase=0;
  output DynamicViscosity eta;
protected
  constant Common.LiBrWData data(mux_po={1,100*X[1],(100*X[1])^2},
      muB=(data.muA1*data.mux_po) + ((data.muA2*data.mux_po)/T) + (
        data.muA3*data.mux_po)*Modelica.Math.log(T/data.T_norm));
  //constant SI.DynamicViscosity eta_c = 0.007;
  //constant Real r_eta = 0.975;
algorithm
  if X[1] > 0 then
    eta := (Modelica.Math.exp(data.muB)*data.muC);
  elseif (p < IFU.BaseIF97.triple.ptriple) or (d < IFU.BaseIF97.triple.dvtriple) then
    eta := (IGW.Functions.dynamicViscosityLowPressure(
                T,
                waterConstants.criticalTemperature,
                waterConstants.molarMass,
                waterConstants.criticalMolarVolume,
                waterConstants.acentricFactor,
                waterConstants.dipoleMoment,
                0));
  else
    eta := (IFU.BaseIF97.Transport.visc_dTp(
                d,
                T,
                p,
                phase));
  end if;
  //eta :=0.007;
  annotation (smoothOrder=2);
end visc_dTpX;
