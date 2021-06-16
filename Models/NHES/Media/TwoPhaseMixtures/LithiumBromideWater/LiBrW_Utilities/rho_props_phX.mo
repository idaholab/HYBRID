within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function rho_props_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:];
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output Density rho "Density";
algorithm
  rho := aux.rho;
  annotation (
    derivative(noDerivative=aux),
    Inline=false,
    LateInline=true);
end rho_props_phX;
