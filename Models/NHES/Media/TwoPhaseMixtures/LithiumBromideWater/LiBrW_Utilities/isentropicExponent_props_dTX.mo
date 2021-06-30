within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function isentropicExponent_props_dTX
  "Isentropic exponent as function of density, temperature, and mass fraction"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output Real gamma "Isentropic exponent";
algorithm
  gamma := if aux.region > 5 then 1 else if aux.region == 3 then 1/(aux.rho
    *aux.p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt*aux.T)/(aux.cv))
     else if aux.region == 4 then 1/(aux.rho*aux.p)*aux.dpT*aux.dpT*aux.T/
    aux.cv else -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*
    aux.T);
  annotation (Inline=false, LateInline=true);
end isentropicExponent_props_dTX;
