within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function ddhpX_props "Density derivative by specific enthalpy"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output DerDensityByEnthalpy ddhpX
    "Density derivative by specific enthalpy";
algorithm
  ddhpX := if aux.region > 5 then 0 else if aux.region == 3 then -aux.rho*
    aux.rho*aux.pt/(aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)
     else if aux.region == 4 then -aux.rho*aux.rho/(aux.dpT*aux.T) else -
    aux.rho*aux.rho*aux.vt/(aux.cp);

  annotation (Inline=false, LateInline=true);
end ddhpX_props;
