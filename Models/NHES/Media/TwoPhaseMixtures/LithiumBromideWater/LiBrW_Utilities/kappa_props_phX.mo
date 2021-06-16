within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function kappa_props_phX "Isothermal compressibility factor as function of pressure, specific enthalpy,
    and mass fraction"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output IsothermalCompressibility kappa
    "Isothermal compressibility factor";
algorithm
  kappa := if aux.region > 5 then 1 else if aux.region == 3 or aux.region ==
    4 then 1/(aux.rho*aux.pd) else -aux.vp*aux.rho;
  annotation (Inline=false, LateInline=true);
end kappa_props_phX;
