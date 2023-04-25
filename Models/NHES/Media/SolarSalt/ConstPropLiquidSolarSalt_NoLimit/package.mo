within NHES.Media.SolarSalt;
package ConstPropLiquidSolarSalt_NoLimit "Solar Salt Extended Range"
  /*
Properties have been calculated based on a weighted average basis between T_min and T_max
*/
  constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
    SolarSaltConstants(
    each chemicalFormula="NaNO3KNO3",
    each structureFormula="NaNO3KNO3",
    each casRegistryNumber="7647-14-5",
    each iupacName="SolarSalt",
    each molarMass=0.072948);

  extends Modelica.Media.Interfaces.PartialSimpleMedium(
    mediumName="SimpleSolarSalt",
    cp_const=1559,
    cv_const=1559,
    d_const=1660,
    eta_const=0.0008,
    lambda_const=0.5,
    a_const=3300,
    T_min=373,
    T_max=4150,
    T0=298.15,
    MM_const=0.072948,
    fluidConstants=SolarSaltConstants);

  annotation (Documentation(info="<html>

</html>"));
end ConstPropLiquidSolarSalt_NoLimit;
