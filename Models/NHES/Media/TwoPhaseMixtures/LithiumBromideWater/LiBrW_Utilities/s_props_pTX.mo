within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function s_props_pTX
  "Specific entropy as function of pressure, temperature, mass fraction"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificEntropy s "Specific entropy";
algorithm
  s := aux.s;
  //annotation (Inline=false, LateInline=true);
end s_props_pTX;
