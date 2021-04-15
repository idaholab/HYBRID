within NHES.Media;
package CombustionGas "Mixture of O2, H2O, CO2, N2, CH4"
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="TestGas",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2,
          Modelica.Media.IdealGases.Common.SingleGasesData.CH4},
    fluidConstants={
          Modelica.Media.IdealGases.Common.FluidData.O2,
          Modelica.Media.IdealGases.Common.FluidData.H2O,
          Modelica.Media.IdealGases.Common.FluidData.CO2,
          Modelica.Media.IdealGases.Common.FluidData.N2,
          Modelica.Media.IdealGases.Common.FluidData.CH4},
    substanceNames={"Oxygen","Water","Carbondioxide","Nitrogen","Methane"},
    reference_X={0.23,0.03,0.04,0.5,0.2},
    referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C);
  annotation (Documentation(info="<html>
This Medium is a mixture of O2, H2O, CO2, N2, CH4. It has its reference composition, defined as <tt>Medium.reference_X</tt>, but only changing it, it can be reused as Air, just leading to zero the mass fraction of CH4, and as Fuel keeping only the mass fraction of CH4, as the unique gas.
</html>"));
end CombustionGas;
