within NHES.Media;
package IdealSteam
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="IdealSteam",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.H2O},
    fluidConstants={Modelica.Media.IdealGases.Common.FluidData.H2O},
    substanceNames={"Steam"},
    reference_X={1},
    referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C,
    excludeEnthalpyOfFormation=true);
end IdealSteam;
