within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function T_props_psX
  "Temperature as function of pressure, specific enthalpy, and mass fractions"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output Temperature T "Temperature";
algorithm
  T := aux.T;
  annotation (Inline=false, LateInline=true);
end T_props_psX;
