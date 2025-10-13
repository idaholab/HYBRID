within NHES.Systems.PrimaryHeatSystem.MSR.BaseClasses;
partial model Partial_SubSystem

  extends NHES.Systems.BaseClasses.Partial_SubSystem;

  extends Record_SubSystem;

  replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-18,188},{-2,204}})));
  replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
      Placement(transformation(extent={{2,188},{18,204}})));
  replaceable Record_Data data
    annotation (Placement(transformation(extent={{42,188},{58,204}})));

  SignalSubBus_ActuatorInput actuatorBus
    annotation (Placement(transformation(extent={{10,146},{50,186}}),
        iconTransformation(extent={{10,146},{50,186}})));
  SignalSubBus_SensorOutput sensorBus
    annotation (Placement(transformation(extent={{-50,146},{-10,186}}),
        iconTransformation(extent={{-50,146},{-10,186}})));

equation
  connect(sensorBus, ED.sensorBus) annotation (Line(
      points={{-30,166},{7.6,166},{7.6,188}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus, CS.sensorBus) annotation (Line(
      points={{-30,166},{-12.4,166},{-12.4,188}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus, CS.actuatorBus) annotation (Line(
      points={{30,166},{-7.6,166},{-7.6,188}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus, ED.actuatorBus) annotation (Line(
      points={{30,166},{12.4,166},{12.4,188}},
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
