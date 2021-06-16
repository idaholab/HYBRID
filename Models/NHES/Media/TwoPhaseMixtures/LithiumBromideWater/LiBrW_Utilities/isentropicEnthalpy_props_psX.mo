within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function isentropicEnthalpy_props_psX
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificEnthalpy h "Isentropic enthalpy";
algorithm
  h := aux.h;
  annotation (
    derivative(noDerivative=aux) = isentropicEnthalpy_psX_der,
    Inline=false,
    LateInline=true);
end isentropicEnthalpy_props_psX;
