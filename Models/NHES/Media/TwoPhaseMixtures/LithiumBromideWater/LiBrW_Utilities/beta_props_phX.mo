within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function beta_props_phX "Isobaric expansion coefficient as function of pressure, specific enthalpy,
    and mass fraction"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  output RelativePressureCoefficient beta
    "Isobaric expansion coefficient";
algorithm
  beta := if aux.region > 5 then 1 else if aux.region == 3 or aux.region ==
    4 then aux.pt/(aux.rho*aux.pd) else aux.vt*aux.rho;
  annotation (Inline=false, LateInline=true);
end beta_props_phX;
