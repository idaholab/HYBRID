within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function p_props_dTX "Assume saturated if X[1] > 0"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output AbsolutePressure p "Pressure";
algorithm
  p := aux.p;
  annotation (Inline=false, LateInline=true);
end p_props_dTX;
