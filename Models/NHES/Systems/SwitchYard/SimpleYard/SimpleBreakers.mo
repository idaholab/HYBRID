within NHES.Systems.SwitchYard.SimpleYard;
model SimpleBreakers
  extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS, redeclare replaceable ED_Dummy ED,
    redeclare Data.SimpleBreakers data);

    input SI.Power W_balance_total = 0 "Total electrical power not accounted in electrical ports" annotation(Dialog(group="Inputs"));

  Electrical.PowerSensor sensorW_BOP
    annotation (Placement(transformation(extent={{-80,50},{-60,30}})));
  Electrical.PowerSensor sensorW_ES
    annotation (Placement(transformation(extent={{-80,10},{-60,-10}})));
  Electrical.PowerSensor sensorW_SES
    annotation (Placement(transformation(extent={{-80,-30},{-60,-50}})));
  Electrical.PowerSensor sensorW_IP annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-70})));
  Electrical.Breaker breaker_BOP
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Electrical.Breaker breaker_ES
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Electrical.Breaker breaker_SES
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Electrical.Breaker breaker_EG
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Electrical.PowerSensor sensorW_SY
    annotation (Placement(transformation(extent={{10,10},{30,-10}})));
  Electrical.PowerSensor sensorW_EG
    annotation (Placement(transformation(extent={{90,10},{70,-10}})));
  Modelica.Blocks.Sources.RealExpression
                           W_balanceTotal(y=W_balance_total)
    annotation (Placement(transformation(extent={{-30,64},{-22,72}})));
  Electrical.Sources.PowerSource W_balance_load(use_W_in=true, W=0)
    annotation (Placement(transformation(extent={{-8,64},{0,72}})));
equation

  connect(sensorW_SES.port_b, breaker_SES.port_a) annotation (Line(points={{-60,
          -39.8},{-50,-39.8},{-50,-40},{-40,-40}}, color={255,0,0}));
  connect(sensorW_ES.port_b, breaker_ES.port_a) annotation (Line(points={{-60,
          0.2},{-50,0.2},{-50,0},{-40,0}}, color={255,0,0}));
  connect(breaker_BOP.port_a, sensorW_BOP.port_b)
    annotation (Line(points={{-40,40},{-60,40},{-60,40.2}}, color={255,0,0}));
  connect(breaker_EG.port_a, sensorW_SY.port_b)
    annotation (Line(points={{40,0},{30,0},{30,0.2}}, color={255,0,0}));
  connect(breaker_BOP.port_b, sensorW_SY.port_a) annotation (Line(points={{-20,
          40},{-10,40},{0,40},{0,0},{10,0}}, color={255,0,0}));
  connect(breaker_ES.port_b, sensorW_SY.port_a)
    annotation (Line(points={{-20,0},{-5,0},{10,0}}, color={255,0,0}));
  connect(breaker_SES.port_b, sensorW_SY.port_a) annotation (Line(points={{-20,
          -40},{0,-40},{0,0},{10,0}}, color={255,0,0}));

  connect(breaker_EG.port_b, sensorW_EG.port_b)
    annotation (Line(points={{60,0},{70,0},{70,0.2}}, color={255,0,0}));
  connect(sensorW_EG.port_a, portElec_Grid)
    annotation (Line(points={{90,0},{100,0},{100,0}}, color={255,0,0}));

  connect(actuatorBus.closed_SES, breaker_SES.closed) annotation (
      Line(
      points={{30.1,100.1},{-10,100.1},{-10,-20},{-30,-20},{-30,-32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.closed_ES, breaker_ES.closed) annotation (Line(
      points={{30.1,100.1},{30.1,100.1},{-10,100.1},{-10,20},{-30,20},{-30,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.closed_BOP, breaker_BOP.closed) annotation (
      Line(
      points={{30.1,100.1},{30.1,100.1},{-10,100.1},{-10,60},{-30,60},{-30,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.closed_EG, breaker_EG.closed) annotation (Line(
      points={{30.1,100.1},{50,100.1},{50,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorW_IP.port_b, sensorW_SY.port_a) annotation (Line(points={{-0.2,
          -60},{0,-60},{0,0},{10,0}}, color={255,0,0}));
  connect(portElec_a3, sensorW_SES.port_a) annotation (Line(points={{-100,-40},{
          -90,-40},{-80,-40}}, color={255,0,0}));
  connect(portElec_a2, sensorW_ES.port_a)
    annotation (Line(points={{-100,0},{-90,0},{-80,0}}, color={255,0,0}));
  connect(portElec_a1, sensorW_BOP.port_a)
    annotation (Line(points={{-100,40},{-90,40},{-80,40}}, color={255,0,0}));
  connect(portElec_b1, sensorW_IP.port_a)
    annotation (Line(points={{0,-100},{0,-90},{0,-80}}, color={255,0,0}));

  connect(W_balance_load.portElec_a, sensorW_SY.port_a)
    annotation (Line(points={{0,68},{0,0},{10,0}}, color={255,0,0}));

  connect(W_balanceTotal.y, W_balance_load.W_in)
    annotation (Line(points={{-21.6,68},{-8.8,68}}, color={0,0,127}));
annotation(defaultComponentName="SY", Icon(graphics={
        Line(
          points={{-20,26},{0,26},{0,0},{0,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-20,-26},{0,-26},{0,0},{-20,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{0,-40},{0,-26}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-78,26}},
          color={255,0,0},
          thickness=0.5),
        Line(points={{-20,28},{-20,24}}, color={0,0,0}),
        Line(points={{-20,2},{-20,-2}}, color={0,0,0}),
        Line(points={{-20,-24},{-20,-28}}, color={0,0,0}),
        Line(points={{54,2},{54,-2}}, color={0,0,0}),
        Line(
          points={{0,2},{0,-2}},
          color={0,0,0},
          origin={0,-40},
          rotation=90),
        Line(
          points={{-78,0},{-46,0},{-20,8}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-78,-26},{-46,-26},{-20,-18}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-78,26},{-46,26},{-20,34}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{0,0},{32,0},{58,8}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{54,0},{78,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{0,-70},{0,-60},{-8,-40}},
          color={255,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-44,28},{-48,24}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-44,2},{-48,-2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-44,-24},{-48,-28}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,-58},{-2,-62}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
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
end SimpleBreakers;
