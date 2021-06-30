within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function h_props_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificEnthalpy h "Specific enthalpy";
algorithm
  h := aux.h;
  annotation (
    derivative(noDerivative=aux) = h_pTX_der,
    Inline=false,
    LateInline=true);
end h_props_pTX;
