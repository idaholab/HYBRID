within NHES.Systems.EnergyStorage.SensibleHeatStorage.ControlSystems;
model CS_TextRead

  extends BaseClasses.Partial_ControlSystem;

  //parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";
  input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{78,-10},{98,10}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_ES(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));
  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
equation

  connect(actuatorBus.Demand, gain.y) annotation (
     Line(
      points={{30.1,-99.9},{30.1,-98},{120,-98},{120,0},{99,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_totalSetpoint_ES.y, gain.u)
    annotation (Line(points={{49,0},{76,0}},   color={0,0,127}));
  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-30,-100},{-30,-98},{-32,-98},{-32,-100},{-120,-100},{-120,40},
          {-102.4,40}},
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
end CS_TextRead;
