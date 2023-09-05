within NHES.Systems.EnergyStorage.SensibleHeatStorage.ControlSystems;
model CS_Default

  extends BaseClasses.Partial_ControlSystem;

  input Real u = 100 annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.RealExpression Demand(y=u)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
equation

  connect(actuatorBus.Demand, Demand.y)
    annotation (Line(
      points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_balance, W_balance.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="ES_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Default;
