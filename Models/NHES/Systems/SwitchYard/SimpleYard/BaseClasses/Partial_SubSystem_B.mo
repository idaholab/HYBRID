within NHES.Systems.SwitchYard.SimpleYard.BaseClasses;
partial model Partial_SubSystem_B

  extends Partial_SubSystem;
  extends Record_SubSystem_B;

  Electrical.Interfaces.ElectricalPowerPort_a port_a[nPorts_a] annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

  Electrical.Interfaces.ElectricalPowerPort_b port_Grid annotation (Placement(
        transformation(extent={{88,-12},{112,12}}), iconTransformation(extent={
            {90,-10},{110,10}})));

  annotation (defaultComponentName="SY");
end Partial_SubSystem_B;
