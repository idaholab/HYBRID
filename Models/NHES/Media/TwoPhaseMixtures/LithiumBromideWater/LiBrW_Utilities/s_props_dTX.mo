within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function s_props_dTX "Assume saturated if X[1] > 0"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificEntropy s "Specific entropy";
algorithm
  s := aux.s;
  annotation (Inline=false, LateInline=true);
end s_props_dTX;
