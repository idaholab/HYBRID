within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function cp_props_pTX "Specific heat capacity at constant pressure as function of pressure, 
    temperature, mass fraction"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output SpecificHeatCapacity cp
    "Specific heat capacity";
algorithm
  cp := if aux.region == 3 then (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*
    aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd) else aux.cp;
  // annotation (Inline=false, LateInline=true);
end cp_props_pTX;
