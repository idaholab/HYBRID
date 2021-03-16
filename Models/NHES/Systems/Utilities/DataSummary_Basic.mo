within NHES.Systems.Utilities;
model DataSummary_Basic
  import NHES;

parameter SI.Time delayStart = 0 "Delay start of integrals of summary parameters";

  Modelica.Blocks.Math.Feedback dW_BOP
    annotation (Placement(transformation(extent={{-85,175},{-75,185}})));

  Modelica.Blocks.Math.Feedback dW_ES
    annotation (Placement(transformation(extent={{-85,155},{-75,165}})));
  Modelica.Blocks.Math.Feedback dW_SES
    annotation (Placement(transformation(extent={{-85,135},{-75,145}})));
  Modelica.Blocks.Math.Feedback dW_EG
    annotation (Placement(transformation(extent={{-85,115},{-75,125}})));
  Modelica.Blocks.Math.Sum Q_balance(nin=3)
    annotation (Placement(transformation(extent={{-86,-46},{-74,-34}})));
  Modelica.Blocks.Math.Sum W_balance(nin=3)
    annotation (Placement(transformation(extent={{-86,-66},{-74,-54}})));
  Modelica.Blocks.Math.Gain m_flow_PHSnuclear(k=1)
    annotation (Placement(transformation(extent={{-84,-124},{-76,-116}})));
  Modelica.Blocks.Sources.Constant delayIntegration(k=delayStart)
    annotation (Placement(transformation(extent={{-24,3},{-32,11}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-40,5},{-50,-5}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-24,-9},{-32,-1}})));
  Modelica.Blocks.Logical.Switch dW_BOP_delay
    annotation (Placement(transformation(extent={{-56,174},{-44,186}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-76,-4},{-68,4}})));
  Modelica.Blocks.Logical.Switch dW_ES_delay
    annotation (Placement(transformation(extent={{-56,154},{-44,166}})));
  Modelica.Blocks.Logical.Switch dW_SES_delay
    annotation (Placement(transformation(extent={{-56,134},{-44,146}})));
  Modelica.Blocks.Logical.Switch dW_EG_delay
    annotation (Placement(transformation(extent={{-56,114},{-44,126}})));
  Modelica.Blocks.Logical.Switch Q_balance_delay
    annotation (Placement(transformation(extent={{-56,-46},{-44,-34}})));
  Modelica.Blocks.Logical.Switch W_balance_delay
    annotation (Placement(transformation(extent={{-56,-66},{-44,-54}})));
  Modelica.Blocks.Logical.Switch m_flow_PHSnuclear_delay
    annotation (Placement(transformation(extent={{-56,-126},{-44,-114}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    "account for in/out power from SY is defined as pos/neg"
    annotation (Placement(transformation(extent={{-92,108},{-86,114}})));
  Modelica.Blocks.Logical.Switch W_IP_delay
    annotation (Placement(transformation(extent={{-56,-100},{-44,-88}})));
  NHES.Systems.BaseClasses.SignalBus_SensorOutput sensorBus annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,-140}), iconTransformation(extent={{-40,-118},{0,-78}})));
equation
  connect(greater.u2, delayIntegration.y) annotation (Line(points={{-39,4},{
          -36.5,4},{-36.5,7},{-32.4,7}},
                                   color={0,0,127}));
  connect(greater.u1, clock.y) annotation (Line(points={{-39,0},{-36.5,0},{
          -36.5,-5},{-32.4,-5}},
                           color={0,0,127}));
  connect(const.y, dW_EG_delay.u3) annotation (Line(points={{-67.6,0},{-64,0},{
          -64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(dW_SES_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,
          135.2},{-64,135.2},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(dW_ES_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,155.2},
          {-64,155.2},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(dW_BOP_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,
          175.2},{-64,175.2},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(greater.y, dW_EG_delay.u2) annotation (Line(points={{-50.5,0},{-62,0},
          {-62,120},{-57.2,120}}, color={255,0,255}));
  connect(dW_SES_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,140},
          {-62,140},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(dW_ES_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,160},
          {-62,160},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(dW_BOP_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,180},
          {-62,180},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(dW_BOP.y, dW_BOP_delay.u1) annotation (Line(points={{-75.5,180},{-66,
          180},{-66,184.8},{-57.2,184.8}}, color={0,0,127}));
  connect(dW_ES.y, dW_ES_delay.u1) annotation (Line(points={{-75.5,160},{-66,
          160},{-66,164.8},{-57.2,164.8}}, color={0,0,127}));
  connect(dW_SES.y, dW_SES_delay.u1) annotation (Line(points={{-75.5,140},{-66,
          140},{-66,144.8},{-57.2,144.8}}, color={0,0,127}));
  connect(dW_EG.y, dW_EG_delay.u1) annotation (Line(points={{-75.5,120},{-66,
          120},{-66,124.8},{-57.2,124.8}}, color={0,0,127}));
  connect(m_flow_PHSnuclear.y, m_flow_PHSnuclear_delay.u1) annotation (Line(
        points={{-75.6,-120},{-66,-120},{-66,-115.2},{-57.2,-115.2}}, color={0,
          0,127}));
  connect(Q_balance_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,-40},
          {-62,-40},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(W_balance_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,-60},
          {-62,-60},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(m_flow_PHSnuclear_delay.u2, dW_EG_delay.u2) annotation (Line(points={
          {-57.2,-120},{-62,-120},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(Q_balance_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,-44.8},
          {-64,-44.8},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(W_balance_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,-64.8},
          {-64,-64.8},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(m_flow_PHSnuclear_delay.u3, dW_EG_delay.u3) annotation (Line(points={
          {-57.2,-124.8},{-64,-124.8},{-64,115.2},{-57.2,115.2}}, color={0,0,
          127}));
  connect(W_balance.y, W_balance_delay.u1) annotation (Line(points={{-73.4,-60},
          {-66,-60},{-66,-55.2},{-57.2,-55.2}}, color={0,0,127}));
  connect(Q_balance.y, Q_balance_delay.u1) annotation (Line(points={{-73.4,-40},
          {-66,-40},{-66,-35.2},{-57.2,-35.2}}, color={0,0,127}));

  // __Dymola_selections={Selection(name="results", match={
  //       MatchVariable(name="dW*.y",newName="%path%")})},

  connect(gain.y, dW_EG.u2) annotation (Line(points={{-85.7,111},{-80,111},{-80,
          116}}, color={0,0,127}));
  connect(W_IP_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,-98.8},
          {-64,-98.8},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(W_IP_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,-94},{
          -62,-94},{-62,120},{-57.2,120}}, color={255,0,255}));

  connect(sensorBus.subBus_BOP.W_totalSetpoint, dW_BOP.u1) annotation (Line(
      points={{0.1,-139.9},{-48,-139.9},{-100,-139.9},{-100,180},{-84,180}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_BOP, dW_BOP.u2) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,170},{-80,170},{-80,
          176}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.subBus_ES.W_totalSetPoint, dW_ES.u1) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,160},{-84,160}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_ES, dW_ES.u2) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,150},{-80,150},{-80,
          156}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, dW_SES.u1) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,140},{-84,140}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_SES, dW_SES.u2) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,130},{-80,130},{-80,
          136}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.subBus_EG.W_totalSetpoint, dW_EG.u1) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,120},{-84,120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_EG, gain.u) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,111},{-92.6,111}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.subBus_PHS.m_flow_fuelConsumption, m_flow_PHSnuclear.u)
    annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-120},{-84.8,-120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.W_IP, W_IP_delay.u1) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-89.2},{-57.2,-89.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.subBus_PHS.Q_balance, Q_balance.u[1]) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-40.8},{-87.2,-40.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.subBus_EM.Q_balance, Q_balance.u[2]) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-40},{-87.2,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.subBus_BOP.Q_balance, Q_balance.u[3]) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-39.2},{-87.2,-39.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.subBus_PHS.W_balance, W_balance.u[1]) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-60.8},{-87.2,-60.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.subBus_EM.W_balance, W_balance.u[2]) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-60},{-87.2,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.subBus_BOP.W_balance, W_balance.u[3]) annotation (Line(
      points={{0.1,-139.9},{0.1,-139.9},{-100,-139.9},{-100,-59.2},{-87.2,-59.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  annotation (defaultComponentName="summary",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                    graphics={Line(points={{-80,
              60}}, color={28,108,200}), Bitmap(extent={{-100,-100},{100,100}},
            fileName="modelica://NHES/Resources/Images/Systems/recordSummary.jpg")}),
                                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{100,
            200}}),                                  graphics={
        Text(
          extent={{-94,198},{-66,190}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.UnderLine},
          textString="Electrical Power:
Setpoint - Measured"),
        Text(
          extent={{-96,-98},{-68,-106}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.UnderLine},
          textString="Fuel Consumption"),
        Text(
          extent={{-96,-26},{-64,-32}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.UnderLine},
          textString="Other Energy Loss/Gains"),
        Text(
          extent={{-44,198},{-16,190}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.UnderLine},
          textString="Net Energy balance 
above and below setpoint"),
        Text(
          extent={{-6,198},{22,190}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.UnderLine},
          textString="Total energy not
matching setpoint")}));
end DataSummary_Basic;
