within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function tsat_der
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input MassFraction X[:];
  input Real der_p(unit="Pa/s");
  input Real der_X[:](unit="1/s");
  output Real der_tsat(unit="K/s");
protected
  constant MassFraction dX=Common.TabDerAssums.dX;
  Temperature dtdX;
  Temperature T_Xminus;
  Temperature T_Xplus;
algorithm
  if (X[1] > 0) then
    T_Xminus := tsat(p, {X[1] - 0.5*dX,1 - (X[1] - 0.5*dX)});
    T_Xplus := tsat(p, {X[1] + 0.5*dX,1 - (X[1] + 0.5*dX)});
    dtdX := (T_Xplus - T_Xminus)/dX;

    der_tsat := dtsatofp(p, X)*der_p + dtdX*der_X[1];
  else
    der_tsat := IFU.BaseIF97.Basic.tsat_der(p, der_p);
  end if;
end tsat_der;
