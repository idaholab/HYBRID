within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function rho_props_pTX
  "Density as function of pressure, specific entropy, and mass fractions"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output Density rho "Density";
algorithm
  rho := aux.rho;
  annotation (
    derivative(noDerivative=aux) = rho_pTX_der,
    Inline=false,
    LateInline=true);
end rho_props_pTX;
