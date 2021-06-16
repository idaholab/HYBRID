within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function s_props_phX
  "Specific entropy as function of pressure, specific enthalpy, and mass fraction"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificEntropy s "Specific entropy";
algorithm
  s := aux.s;
  //annotation (Inline=false, LateInline=true);
end s_props_phX;
