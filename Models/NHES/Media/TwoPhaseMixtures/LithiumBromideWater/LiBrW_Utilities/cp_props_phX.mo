within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function cp_props_phX "Specific heat capacity at constant pressure as function of pressure, 
    specific enthalpy, and mass fraction"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificHeatCapacity cp
    "Specific heat capacity";
algorithm
  cp := aux.cp;
  //  annotation (Inline=false, LateInline=true);
end cp_props_phX;
