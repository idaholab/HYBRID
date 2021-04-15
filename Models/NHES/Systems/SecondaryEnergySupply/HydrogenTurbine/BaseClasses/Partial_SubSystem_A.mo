within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;
  extends Record_SubSystem_A;

  NHES.Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (
      Placement(transformation(extent={{110,-10},{130,10}}), iconTransformation(
          extent={{90,-10},{110,10}})));

  annotation (
    defaultComponentName="SES",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,
            140}})));

end Partial_SubSystem_A;
