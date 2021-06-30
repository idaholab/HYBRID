within NHES.Media.TwoPhaseMixtures;
package LithiumBromideWater
  extends Modelica.Icons.VariantsPackage;



  constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants
waterConstants(
chemicalFormula="H2O",
structureFormula="H2O",
casRegistryNumber="7732-18-5",
iupacName="oxidane",
molarMass=0.018015268,
criticalTemperature=647.096,
criticalPressure=22064.0e3,
criticalMolarVolume=1/322.0*0.018015268,
normalBoilingPoint=373.124,
meltingPoint=273.15,
triplePointTemperature=273.16,
triplePointPressure=611.657,
acentricFactor=0.344,
dipoleMoment=1.8,
hasCriticalData=true);

  constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants
lithiumBromideConstants(
chemicalFormula="LiBr",
structureFormula="LiBr",
casRegistryNumber="7550-35-8",
iupacName="lithium bromide",
molarMass=0.086845,
criticalTemperature=647.096,
criticalPressure=22064.0e3,
criticalMolarVolume=1/322.0*0.018015268,
normalBoilingPoint=373.124,
meltingPoint=273.15,
triplePointTemperature=273.16,
triplePointPressure=611.657,
acentricFactor=0.344,
dipoleMoment=1.8,
hasCriticalData=false);
  // The following data is for water save for hasCriticalData is marked false


end LithiumBromideWater;
