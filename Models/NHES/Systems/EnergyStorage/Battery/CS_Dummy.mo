within NHES.Systems.EnergyStorage.Battery;
model CS_Dummy
  extends BaseClasses.Partial_ControlSystem;

  extends Icons.DummyIcon;

public
  Modelica.Blocks.Sources.Constant W_setPoint(k=20e6)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
equation

  connect(actuatorBus.W_setPoint, W_setPoint.y) annotation (
      Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-50},{11,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="ES_CS");
end CS_Dummy;
