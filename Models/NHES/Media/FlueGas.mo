within NHES.Media;
package FlueGas "flue gas"
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="FlueGas",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2},
    fluidConstants={
          Modelica.Media.IdealGases.Common.FluidData.O2,
          Modelica.Media.IdealGases.Common.FluidData.Ar,
          Modelica.Media.IdealGases.Common.FluidData.H2O,
          Modelica.Media.IdealGases.Common.FluidData.CO2,
          Modelica.Media.IdealGases.Common.FluidData.N2},
    substanceNames={"Oxygen","Argon","Water","Carbondioxide","Nitrogen"},
    reference_X={0.23,0.02,0.01,0.04,0.7},
    referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C);

end FlueGas;
