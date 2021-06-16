within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function T_phX_der
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  input Real p_der "Derivative of pressure";
  input Real h_der "Derivative of specific enthalpy";
  input Real X_der[:] "Derivative of mass fraction";
  output Real T_der "Derivative of temperature";
algorithm
  T_der := aux.tp*p_der + aux.th*h_der + aux.tx*X_der[1];
end T_phX_der;
