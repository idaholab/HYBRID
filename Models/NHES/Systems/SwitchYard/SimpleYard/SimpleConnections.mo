within NHES.Systems.SwitchYard.SimpleYard;
model SimpleConnections
  extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable CS_Dummy CS, redeclare replaceable ED_Dummy ED,
    redeclare Data.SimpleBreakers data);

    input SI.Power W_balance_total = 0 "Total electrical power not accounted in electrical ports" annotation(Dialog(group="Inputs"));

  Electrical.PowerSensor sensorW_port_a[nPorts_a]
    annotation (Placement(transformation(extent={{-80,10},{-60,-10}})));
  Electrical.Breaker breaker_EG
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Electrical.PowerSensor sensorW_SY
    annotation (Placement(transformation(extent={{10,10},{30,-10}})));
  Electrical.PowerSensor sensorW_EG
    annotation (Placement(transformation(extent={{90,10},{70,-10}})));
  Modelica.Blocks.Sources.RealExpression W_balanceTotal
    annotation (Placement(transformation(extent={{-30,64},{-22,72}})));
  Electrical.Sources.PowerSource W_balance_load(use_W_in=true, W=0)
    annotation (Placement(transformation(extent={{-8,64},{0,72}})));
equation

  connect(breaker_EG.port_a, sensorW_SY.port_b)
    annotation (Line(points={{40,0},{30,0},{30,0.2}}, color={255,0,0}));

  connect(breaker_EG.port_b, sensorW_EG.port_b)
    annotation (Line(points={{60,0},{70,0},{70,0.2}}, color={255,0,0}));
  connect(sensorW_EG.port_a, port_Grid)
    annotation (Line(points={{90,0},{100,0},{100,0}}, color={255,0,0}));

  connect(actuatorBus.closed_EG, breaker_EG.closed) annotation (Line(
      points={{30.1,100.1},{50,100.1},{50,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_EG, sensorW_EG.W) annotation (Line(
      points={{-30,100},{-12,100},{-12,102},{80,102},{80,9.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_SY, sensorW_SY.W) annotation (Line(
      points={{-30,100},{-30,100},{-12,100},{-12,102},{80,102},{80,20},{20,20},{
          20,9.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_balance_load.portElec_a, sensorW_SY.port_a)
    annotation (Line(points={{0,68},{0,0},{10,0}}, color={255,0,0}));

  for i in 1:nPorts_a loop
    connect(sensorW_port_a[i].port_a, port_a[i]);
    connect(sensorW_port_a[i].port_b,sensorW_EG.port_a);
    connect(sensorBus.W_subsystems, sensorW_port_a.W)
      annotation (Line(
        points={{-29.9,100.1},{-70,100.1},{-70,9.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  end for;

  connect(W_balanceTotal.y, W_balance_load.W_in)
    annotation (Line(points={{-21.6,68},{-8.8,68}}, color={0,0,127}));
annotation(defaultComponentName="SY", Icon(graphics={
        Line(
          points={{-78,26}},
          color={255,0,0},
          thickness=0.5),
        Line(points={{54,2},{54,-2}}, color={0,0,0}),
        Line(
          points={{-78,0},{-46,0},{-20,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-20,0},{32,0},{52,8}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{54,0},{78,0}},
          color={255,0,0},
          thickness=0.5),
        Ellipse(
          extent={{34,2},{30,-2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Simple Breakers")}));
end SimpleConnections;
