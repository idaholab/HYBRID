within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function T_props_phX
  "Temperature as function of pressure, specific enthalpy, and mass fractions"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output Temperature T "Temperature";
algorithm
  T := aux.T;
  annotation (
    derivative(noDerivative=aux) = T_phX_der,
    Inline=false,
    LateInline=true);
end T_props_phX;
