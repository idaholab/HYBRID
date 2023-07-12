within NHES.ExperimentalSystems.TEDS_New.BaseClasses;
partial model Partial_SubSystem

  extends NHES.Systems.BaseClasses.Partial_SubSystem;

  extends Record_SubSystem;

  replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-8,122},{8,138}})));
  replaceable Record_Data data
    annotation (Placement(transformation(extent={{42,122},{58,138}})));

  SignalSubBus_ActuatorInput actuatorBus
    annotation (Placement(transformation(extent={{10,80},{50,120}}),
        iconTransformation(extent={{10,80},{50,120}})));
  SignalSubBus_SensorOutput sensorBus
    annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
        iconTransformation(extent={{-50,80},{-10,120}})));

equation
  connect(sensorBus, CS.sensorBus) annotation (Line(
      points={{-30,100},{-2.4,100},{-2.4,122}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus, CS.actuatorBus) annotation (Line(
      points={{30,100},{2.4,100},{2.4,122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  annotation (
    defaultComponentName="changeMe",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}})));
end Partial_SubSystem;
