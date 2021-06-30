within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function isentropicEnthalpy_psX_der
  "Derivative of isentropic specific enthalpy from p,s,X"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  input Real p_der "Pressure derivative";
  input Real s_der "Entropy derivative";
  input Real X_der[:] "Mass fraction derivative";
  output Real h_der "Specific enthalpy derivative";
algorithm
  h_der := if aux.region > 5 then 0 else 1/aux.rho*p_der + aux.T*s_der;
  annotation (Inline=true);
end isentropicEnthalpy_psX_der;
