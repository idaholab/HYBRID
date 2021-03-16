within NHES.Media;
package Hydrogen "Mixture of N2, CO2, H2"
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="NaturalGas",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2},
    fluidConstants={
          Modelica.Media.IdealGases.Common.FluidData.N2,
          Modelica.Media.IdealGases.Common.FluidData.CO2,
          Modelica.Media.IdealGases.Common.FluidData.H2},
    substanceNames={"Nitrogen","Carbondioxide","Hydrogen"},
    reference_X={0.02,0.0,0.98},
    referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C);

end Hydrogen;
