within NHES.Electrolysis.Media.Electrolysis;
package AnodeGas_air "Air for HTSE anode stream (N2 and O2)"
extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
  mediumName="AnodeGas_air",
  data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.O2},
  fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.O2},
  substanceNames={"N2","O2"},
  reference_X=fill(1/nX, nX),
  referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C,
  excludeEnthalpyOfFormation=true
    "If true, enthalpy of formation Hf is not included in specific enthalpy h");




  annotation (Documentation(info="<html>

</html>"));

end AnodeGas_air;
