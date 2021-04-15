within NHES.Systems.EnergyStorage.Battery.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;
  extends Record_SubSystem;

  NHES.Electrical.Interfaces.ElectricalPowerPort_b portElec_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  annotation (
    defaultComponentName="ES",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}})));
end Partial_SubSystem_A;
