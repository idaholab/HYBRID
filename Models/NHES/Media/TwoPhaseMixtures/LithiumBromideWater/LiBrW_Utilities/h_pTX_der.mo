within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function h_pTX_der "Derivative function of h_pTX"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  input Real p_der "Derivative of pressure";
  input Real T_der "Derivative of temperature";
  input Real X_der[:] "Derivative of mass fraction";
  output Real h_der "Derivative of specific enthalpy";
algorithm
  h_der := aux.hp*p_der + (aux.cp*T_der) + aux.hx*X_der[1];
end h_pTX_der;
