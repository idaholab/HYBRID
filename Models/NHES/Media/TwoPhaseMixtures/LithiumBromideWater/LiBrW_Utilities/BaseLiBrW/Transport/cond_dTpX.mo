within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Transport;
function cond_dTpX
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input AbsolutePressure p;
  input MassFraction X[:];
  input Integer phase=0;
  output ThermalConductivity lambda;
protected
  constant Common.LiBrWData data(
    kx_po={X[1],1},
    kD12=((data.kx_po*data.K2 - data.kx_po*data.K1)*data.kT_F)*(T -
        data.kT_0),
    kD13=((data.kx_po*data.K3 - data.kx_po*data.K1)*data.kT_F)*(data.kT_0
         - T));
algorithm
  if X[1] > 0 and T >= data.kT_0 then
    lambda := data.kx_po*data.K1 + data.kD12;
  elseif X[1] > 0 and T < data.kT_0 then
    lambda := data.kx_po*data.K1 + data.kD13;
  else
    lambda := IFU.BaseIF97.Transport.cond_dTp(
                d,
                T,
                p,
                phase);
  end if;
  //lambda :=0.445;
end cond_dTpX;
