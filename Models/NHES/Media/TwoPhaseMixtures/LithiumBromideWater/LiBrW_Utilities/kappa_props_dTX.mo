within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function kappa_props_dTX
  "Isothermal compressibility factor as function of density and temperature"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output IsothermalCompressibility kappa
    "Isothermal compressibility factor";
algorithm
  kappa := if aux.region > 5 then 1 else if aux.region == 3 or aux.region ==
    4 then 1/(aux.rho*aux.pd) else -aux.vp*aux.rho;
  annotation (Inline=false, LateInline=true);
end kappa_props_dTX;
