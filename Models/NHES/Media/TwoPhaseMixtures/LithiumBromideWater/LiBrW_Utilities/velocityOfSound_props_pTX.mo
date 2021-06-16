within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function velocityOfSound_props_pTX
  "Speed of sound as function of pressure, temperature, and mass fraction"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output Velocity v_sound "Speed of sound";
algorithm
  // dp/drho at constant s
  v_sound := if aux.region > 5 then 1 else if aux.region == 3 then sqrt(
    max(0, (aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(aux.rho*
    aux.rho*aux.cv))) else sqrt(max(0, -aux.cp/(aux.rho*aux.rho*(aux.vp*
    aux.cp + aux.vt*aux.vt*aux.T))));
  annotation (Inline=false, LateInline=true);
end velocityOfSound_props_pTX;
