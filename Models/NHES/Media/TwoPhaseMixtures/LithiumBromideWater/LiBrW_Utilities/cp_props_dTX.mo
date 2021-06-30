within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function cp_props_dTX "Specific heat capacity at constant pressure as function of density, 
    temperature, and mass fraction"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificHeatCapacity cp
    "Specific heat capacity";
algorithm
  cp := aux.cp;
  annotation (Inline=false, LateInline=true);
end cp_props_dTX;
