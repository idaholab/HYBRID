within NHES.Media;
package Air "Air as mixture of O2, N2, Ar and H2O"
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="Air",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2},
    fluidConstants={
          Modelica.Media.IdealGases.Common.FluidData.O2,
          Modelica.Media.IdealGases.Common.FluidData.H2O,
          Modelica.Media.IdealGases.Common.FluidData.Ar,
          Modelica.Media.IdealGases.Common.FluidData.N2},
    substanceNames={"Oxygen","Water","Argon","Nitrogen"},
    reference_X={0.23,0.015,0.005,0.75},
    referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C);
end Air;
