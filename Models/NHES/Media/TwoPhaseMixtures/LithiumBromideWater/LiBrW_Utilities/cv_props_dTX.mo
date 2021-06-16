within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function cv_props_dTX "Specific heat capacity at constant volume as function of density,
    temperature, and mass fraction"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificHeatCapacity cv
    "Specific heat capacity";
algorithm
  cv := aux.cv;
  annotation (Inline=false, LateInline=true);
end cv_props_dTX;
