within NHES.Systems.ElectricalGrid.InfiniteGrid.BaseClasses;
partial model Partial_SubSystem
  import NHES;

  extends NHES.Systems.ElectricalGrid.BaseClasses.Partial_SubSystem;

  extends Record_SubSystem;

  replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-18,122},{-2,138}})));
  replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
      Placement(transformation(extent={{2,122},{18,138}})));
  replaceable Record_Data data
    annotation (Placement(transformation(extent={{42,122},{58,138}})));

  SignalSubBus_ActuatorInput actuatorBus
    annotation (Placement(transformation(extent={{10,80},{50,120}}),
        iconTransformation(extent={{10,80},{50,120}})));
  SignalSubBus_SensorOutput sensorBus
    annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
        iconTransformation(extent={{-50,80},{-10,120}})));

  Modelica.Blocks.Sources.RealExpression Q_balance
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-96,128},{-84,140}})));
  Modelica.Blocks.Sources.RealExpression W_balance
    "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
    annotation (Placement(transformation(extent={{-96,118},{-84,130}})));

equation
  connect(sensorBus, ED.sensorBus) annotation (Line(
      points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus, CS.sensorBus) annotation (Line(
      points={{-30,100},{-12.4,100},{-12.4,122}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus, CS.actuatorBus) annotation (Line(
      points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus, ED.actuatorBus) annotation (Line(
      points={{30,100},{20,100},{12.4,100},{12.4,122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.Q_balance, Q_balance.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,134},{-83.4,134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_balance, W_balance.y) annotation (Line(
      points={{-30,100},{-30,100},{-80,100},{-80,124},{-83.4,124}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  annotation (
    defaultComponentName="EG",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}})));
end Partial_SubSystem;
