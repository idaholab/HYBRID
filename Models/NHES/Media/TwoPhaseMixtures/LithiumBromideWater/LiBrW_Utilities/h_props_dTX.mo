within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function h_props_dTX "Assume saturated if X[1] > 0"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificEnthalpy h "Specific enthalpy";
algorithm
  h := aux.h;
  annotation (Inline=false, LateInline=true);
end h_props_dTX;
