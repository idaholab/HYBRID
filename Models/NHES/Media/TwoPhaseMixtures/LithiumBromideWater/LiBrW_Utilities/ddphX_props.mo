within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function ddphX_props "Density derivative by pressure"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output DerDensityByPressure ddphX
    "Density derivative by pressure";
algorithm
  ddphX := if aux.region > 5 then 0 else if aux.region == 3 then ((aux.rho
    *(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*aux.cv + aux.T*
    aux.pt*aux.pt)) else if aux.region == 4 then (aux.rho*(aux.rho*aux.cv/
    aux.dpT + 1.0)/(aux.dpT*aux.T)) else (-aux.rho*aux.rho*(aux.vp*aux.cp -
    aux.vt/aux.rho + aux.T*aux.vt*aux.vt)/aux.cp);
  annotation (Inline=false, LateInline=true);
end ddphX_props;
