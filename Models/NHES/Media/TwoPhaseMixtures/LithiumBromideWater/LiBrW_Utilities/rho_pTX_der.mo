within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function rho_pTX_der "Derivative function of rho_pTX"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  input Real p_der "Derivative of pressure";
  input Real T_der "Derivative of temperature";
  input Real X_der[:] "Derivative of mass fraction";
  output Real rho_der "Derivative of density";
protected
  constant Common.LiBrWData d;
algorithm
  rho_der := (-(d.V[4] + 2*T*d.V[7] + 100*d.V[5]*X[1] + 10000*d.V[6]*X[1]^
    2 + 200*T*d.V[8]*X[1])/(100*d.V[8]*T^2*X[1] + d.V[7]*T^2 + 10000*d.V[6]
    *T*X[1]^2 + 100*d.V[5]*T*X[1] + d.V[4]*T + 10000*d.V[3]*X[1]^2 + 100*
    d.V[2]*X[1] + d.V[1])^2)*T_der + (-(100*d.V[2] + 100*T*d.V[5] + 20000*
    d.V[3]*X[1] + 100*T^2*d.V[8] + 20000*T*d.V[6]*X[1])/(100*d.V[8]*T^2*X[
    1] + d.V[7]*T^2 + 10000*d.V[6]*T*X[1]^2 + 100*d.V[5]*T*X[1] + d.V[4]*
    T + 10000*d.V[3]*X[1]^2 + 100*d.V[2]*X[1] + d.V[1])^2)*X_der[1];
  // rho_der := -(aux.rho*aux.rho)*(aux.vt*T_der + aux.vx*X_der[1]);
end rho_pTX_der;
