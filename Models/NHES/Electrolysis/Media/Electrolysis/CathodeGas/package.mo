within NHES.Electrolysis.Media.Electrolysis;
package CathodeGas "Gas mixture for HTSE cathode stream (H2 and H2O)"
extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
  mediumName="CathodeGas",
  data={Modelica.Media.IdealGases.Common.SingleGasesData.H2,Modelica.Media.IdealGases.Common.SingleGasesData.H2O},
  fluidConstants={Modelica.Media.IdealGases.Common.FluidData.H2,Modelica.Media.IdealGases.Common.FluidData.H2O},
  substanceNames={"H2","H2O"},
  reference_X=fill(1/nX, nX),
  referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C,
  excludeEnthalpyOfFormation=true
    "If true, enthalpy of formation Hf is not included in specific enthalpy h");




 annotation (Documentation(info="<html>

</html>"));
end CathodeGas;
