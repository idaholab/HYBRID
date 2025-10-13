within NHES.Media.HITEC;
package ConstantPropertyLiquidHITEC
  "HITEC Package"
  /* 
  ****************Updated 09-04-2025 to match projected experimental values, using values from HITEC package at 270C.
Properties have been calculated based on a weighted average basis between T_min and T_max
*/
  constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
    HITECConstants(
    each chemicalFormula="NaNO3KNO3",
    each structureFormula="NaNO3KNO3",
    each casRegistryNumber="7647-14-5",
    each iupacName="HITEC",
    each molarMass=0.072948);

  extends Modelica.Media.Interfaces.PartialSimpleMedium(
    mediumName="SimpleHITEC",
    cp_const=1495,
    cv_const=1495,
    d_const=1558,
    eta_const=0.004,
    lambda_const=0.6,
    a_const=3300,
    T_min=1,
    T_max=1835,
    T0=298.15,
    MM_const=0.072948,
    fluidConstants=HITECConstants);

  annotation (Documentation(info="<html>

</html>"));
end ConstantPropertyLiquidHITEC;
