within NHES.Media;
package NaturalGas "Mixture of N2, CO2, and CH4"
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="NaturalGas",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
          Modelica.Media.IdealGases.Common.SingleGasesData.CH4},
    fluidConstants={
          Modelica.Media.IdealGases.Common.FluidData.N2,
          Modelica.Media.IdealGases.Common.FluidData.CO2,
          Modelica.Media.IdealGases.Common.FluidData.CH4},
    substanceNames={"Nitrogen","Carbondioxide","Methane"},
    reference_X={0.02,0.012,0.968},
    referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C);

end NaturalGas;
