within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model Control_System_B
  BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-62,-122},{-14,-76}})));
  BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
equation
  connect(actuatorSubBus.Valve1, gain.u) annotation (Line(
      points={{-38,-99},{-100,-99},{-100,-20},{8,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_1_Opening, gain.y) annotation (Line(
      points={{40,-99},{100,-99},{100,-20},{31,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,160}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{160,160}})));
end Control_System_B;
