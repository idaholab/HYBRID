within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function psat_der
  extends Modelica.Icons.Function;
  input Temperature T;
  input MassFraction X[:];
  input Real der_T(unit="K/s");
  input Real der_X[:](unit="1/s");
  output Real der_psat(unit="Pa/s");
protected
  constant Temperature dT=Common.TabDerAssums.dT;
  constant MassFraction dX=Common.TabDerAssums.dX;
  Real dpdt(unit="Pa/K");
  AbsolutePressure dpdX;
  AbsolutePressure p_Xminus;
  AbsolutePressure p_Xplus;
  AbsolutePressure p_Tminus;
  AbsolutePressure p_Tplus;
algorithm
  if (X[1] > 1) then
    p_Tminus := psat(T - 0.5*dT, X);
    p_Tplus := psat(T + 0.5*dT, X);

    p_Xminus := psat(T, {X[1] - 0.5*dX,1 - (X[1] - 0.5*dX)});
    p_Xplus := psat(T, {X[1] + 0.5*dX,1 - (X[1] + 0.5*dX)});

    dpdt := (p_Tplus - p_Tminus)/dT;
    dpdX := (p_Xplus - p_Xminus)/dX;

    der_psat := dpdt*der_T + dpdX*der_X[1];
  else
    der_psat := IFU.BaseIF97.Basic.psat_der(T, der_T);
  end if;
end psat_der;
