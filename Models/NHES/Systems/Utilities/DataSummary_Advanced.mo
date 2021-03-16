within NHES.Systems.Utilities;
model DataSummary_Advanced
  import NHES;

parameter SI.Time delayStart = 0 "Delay start of integrals of summary parameters";

  NHES.Systems.BaseClasses.SignalBus signalBus annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));

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
  Modelica.Blocks.Continuous.Integrator dW_BOP_integral
    annotation (Placement(transformation(extent={{-36,174},{-24,186}})));
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
  Modelica.Blocks.Continuous.Integrator dW_ES_integral
    annotation (Placement(transformation(extent={{-36,154},{-24,166}})));
  Modelica.Blocks.Continuous.Integrator dW_SES_integral
    annotation (Placement(transformation(extent={{-36,134},{-24,146}})));
  Modelica.Blocks.Continuous.Integrator dW_EG_integral
    annotation (Placement(transformation(extent={{-36,114},{-24,126}})));
  Modelica.Blocks.Continuous.Integrator Q_balance_integral
    annotation (Placement(transformation(extent={{-36,-46},{-24,-34}})));
  Modelica.Blocks.Logical.Switch Q_balance_delay
    annotation (Placement(transformation(extent={{-56,-46},{-44,-34}})));
  Modelica.Blocks.Logical.Switch W_balance_delay
    annotation (Placement(transformation(extent={{-56,-66},{-44,-54}})));
  Modelica.Blocks.Continuous.Integrator W_balance_integral
    annotation (Placement(transformation(extent={{-36,-66},{-24,-54}})));
  Modelica.Blocks.Logical.Switch m_flow_PHSnuclear_delay
    annotation (Placement(transformation(extent={{-56,-126},{-44,-114}})));
  Modelica.Blocks.Continuous.Integrator m_flow_PHSnuclear_integral
    annotation (Placement(transformation(extent={{-36,-126},{-24,-114}})));
  Modelica.Blocks.Continuous.Integrator dW_BOP_integral_abs
    annotation (Placement(transformation(extent={{4,164},{16,176}})));
  Modelica.Blocks.Continuous.Integrator dW_ES_integral_abs
    annotation (Placement(transformation(extent={{4,144},{16,156}})));
  Modelica.Blocks.Continuous.Integrator dW_SES_integral_abs
    annotation (Placement(transformation(extent={{4,124},{16,136}})));
  Modelica.Blocks.Continuous.Integrator dW_EG_integral_abs
    annotation (Placement(transformation(extent={{4,104},{16,116}})));
  Modelica.Blocks.Math.Abs abs
    annotation (Placement(transformation(extent={{-16,164},{-4,176}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-16,144},{-4,156}})));
  Modelica.Blocks.Math.Abs abs2
    annotation (Placement(transformation(extent={{-16,124},{-4,136}})));
  Modelica.Blocks.Math.Abs abs3
    annotation (Placement(transformation(extent={{-16,104},{-4,116}})));
  Modelica.Blocks.Math.Feedback dWnet_EG
    annotation (Placement(transformation(extent={{-85,95},{-75,105}})));
  Modelica.Blocks.Continuous.Integrator dWnet_EG_integral_abs
    annotation (Placement(transformation(extent={{4,84},{16,96}})));
  Modelica.Blocks.Math.Abs abs4
    annotation (Placement(transformation(extent={{-16,84},{-4,96}})));
  Modelica.Blocks.Continuous.Integrator dWnet_EG_integral
    annotation (Placement(transformation(extent={{-36,94},{-24,106}})));
  Modelica.Blocks.Logical.Switch dWnet_EG_delay
    annotation (Placement(transformation(extent={{-56,94},{-44,106}})));
  Modelica.Blocks.Sources.RealExpression Wnet_EG_y(y=Wnet_EG.y)
    "Power to EG with power used in subsystems accounted"
    annotation (Placement(transformation(extent={{-94,84},{-84,94}})));
  Modelica.Blocks.Math.Feedback Wnet_EG
    "Power to EG with power used in subsystems accounted"
    annotation (Placement(transformation(extent={{-35,-85},{-25,-75}})));
  Modelica.Blocks.Math.Add Wnet_EG_IP(k2=-1)
    "Net electricity supplied to grid and industrial process"
    annotation (Placement(transformation(extent={{-16,-86},{-4,-74}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    "account for in/out power from SY is defined as pos/neg"
    annotation (Placement(transformation(extent={{-92,108},{-86,114}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    "account for in/out power from SY is defined as pos/neg"
    annotation (Placement(transformation(extent={{-84,-84},{-76,-76}})));
  Modelica.Blocks.Logical.Switch W_EG_delay
    annotation (Placement(transformation(extent={{-56,-86},{-44,-74}})));
  Modelica.Blocks.Logical.Switch W_IP_delay
    annotation (Placement(transformation(extent={{-56,-100},{-44,-88}})));
equation
  connect(signalBus.Signals_BOP.s_Q_totalSetpoint, dW_BOP.u1) annotation (Line(
      points={{-100,0},{-100,180},{-84,180}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_ES.s_SVC_pSetPoint, dW_ES.u1) annotation (Line(
      points={{-100,0},{-100,160},{-84,160}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_SES.s_Q_totalSetpoint, dW_SES.u1) annotation (Line(
      points={{-100,0},{-100,140},{-84,140}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_EG.s_Q_totalSetpoint, dW_EG.u1) annotation (Line(
      points={{-100,0},{-100,0},{-100,120},{-84,120}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_SY.s_BOP_power, dW_BOP.u2) annotation (Line(
      points={{-100,0},{-100,170},{-80,170},{-80,176}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_SY.s_ES_power, dW_ES.u2) annotation (Line(
      points={{-100,0},{-100,150},{-80,150},{-80,156}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_SY.s_SES_power, dW_SES.u2) annotation (Line(
      points={{-100,0},{-100,130},{-80,130},{-80,136}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_PHS.s_Q_balance, Q_balance.u[1]) annotation (Line(
      points={{-100,0},{-100,-40.8},{-87.2,-40.8}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_EM.s_Q_balance, Q_balance.u[2]) annotation (Line(
      points={{-100,0},{-100,-40},{-87.2,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_BOP.s_Q_balance, Q_balance.u[3]) annotation (Line(
      points={{-100,0},{-100,-39.2},{-87.2,-39.2}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_PHS.s_W_balance, W_balance.u[1]) annotation (Line(
      points={{-100,0},{-100,-60.8},{-87.2,-60.8}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_EM.s_W_balance, W_balance.u[2]) annotation (Line(
      points={{-100,0},{-100,-60},{-87.2,-60}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_BOP.s_W_balance, W_balance.u[3]) annotation (Line(
      points={{-100,0},{-100,-59.2},{-87.2,-59.2}},
      color={255,204,51},
      thickness=0.5));
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
  connect(dW_BOP_delay.y, dW_BOP_integral.u)
    annotation (Line(points={{-43.4,180},{-37.2,180}}, color={0,0,127}));
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
  connect(dW_EG_delay.y, dW_EG_integral.u)
    annotation (Line(points={{-43.4,120},{-37.2,120}}, color={0,0,127}));
  connect(dW_SES_delay.y, dW_SES_integral.u)
    annotation (Line(points={{-43.4,140},{-37.2,140}}, color={0,0,127}));
  connect(dW_ES_delay.y, dW_ES_integral.u)
    annotation (Line(points={{-43.4,160},{-37.2,160}}, color={0,0,127}));
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
  connect(Q_balance_delay.y, Q_balance_integral.u)
    annotation (Line(points={{-43.4,-40},{-37.2,-40}}, color={0,0,127}));
  connect(W_balance_delay.y, W_balance_integral.u)
    annotation (Line(points={{-43.4,-60},{-37.2,-60}}, color={0,0,127}));
  connect(m_flow_PHSnuclear_delay.y, m_flow_PHSnuclear_integral.u)
    annotation (Line(points={{-43.4,-120},{-37.2,-120}}, color={0,0,127}));
  connect(signalBus.Signals_PHS.s_m_flow_fuelConsumption, m_flow_PHSnuclear.u)
    annotation (Line(
      points={{-100,0},{-100,-120},{-84.8,-120}},
      color={255,204,51},
      thickness=0.5));

  // __Dymola_selections={Selection(name="results", match={
  //       MatchVariable(name="dW*.y",newName="%path%")})},

  connect(abs.u, dW_BOP_integral.u) annotation (Line(points={{-17.2,170},{-20,
          170},{-40,170},{-40,180},{-37.2,180}},
                                         color={0,0,127}));
  connect(abs1.u, dW_ES_integral.u) annotation (Line(points={{-17.2,150},{-20,
          150},{-40,150},{-40,160},{-37.2,160}},
                                         color={0,0,127}));
  connect(abs2.u, dW_SES_integral.u) annotation (Line(points={{-17.2,130},{-20,
          130},{-40,130},{-40,140},{-37.2,140}},
                                         color={0,0,127}));
  connect(abs3.u, dW_EG_integral.u) annotation (Line(points={{-17.2,110},{-20,
          110},{-40,110},{-40,120},{-37.2,120}},
                                         color={0,0,127}));
  connect(abs.y, dW_BOP_integral_abs.u)
    annotation (Line(points={{-3.4,170},{2.8,170}},
                                                  color={0,0,127}));
  connect(abs1.y, dW_ES_integral_abs.u)
    annotation (Line(points={{-3.4,150},{2.8,150}},
                                                  color={0,0,127}));
  connect(abs2.y, dW_SES_integral_abs.u)
    annotation (Line(points={{-3.4,130},{2.8,130}},
                                                  color={0,0,127}));
  connect(abs3.y, dW_EG_integral_abs.u)
    annotation (Line(points={{-3.4,110},{-3.4,110},{2.8,110}},
                                                  color={0,0,127}));
  connect(Wnet_EG_y.y, dWnet_EG.u2)
    annotation (Line(points={{-83.5,89},{-80,89},{-80,96}}, color={0,0,127}));
  connect(dWnet_EG.y, dWnet_EG_delay.u1) annotation (Line(points={{-75.5,100},{
          -66,100},{-66,104.8},{-57.2,104.8}}, color={0,0,127}));
  connect(dWnet_EG_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,
          100},{-62,100},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(dWnet_EG_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,
          95.2},{-64,95.2},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(dWnet_EG_delay.y, dWnet_EG_integral.u)
    annotation (Line(points={{-43.4,100},{-37.2,100}}, color={0,0,127}));
  connect(abs4.u, dWnet_EG_integral.u) annotation (Line(points={{-17.2,90},{-40,
          90},{-40,100},{-37.2,100}}, color={0,0,127}));
  connect(dWnet_EG_integral_abs.u, abs4.y)
    annotation (Line(points={{2.8,90},{-3.4,90}}, color={0,0,127}));
  connect(gain.y, dW_EG.u2) annotation (Line(points={{-85.7,111},{-80,111},{-80,
          116}}, color={0,0,127}));
  connect(signalBus.Signals_SY.s_EG_power, gain.u) annotation (Line(
      points={{-100,0},{-100,0},{-100,34},{-100,111},{-92.6,111}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_EG.s_Q_totalSetpoint, dWnet_EG.u1) annotation (Line(
      points={{-100,0},{-100,0},{-100,100},{-84,100}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_SY.s_EG_power, gain1.u) annotation (Line(
      points={{-100,0},{-100,0},{-100,-80},{-84.8,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(Wnet_EG.y, Wnet_EG_IP.u1) annotation (Line(points={{-25.5,-80},{-22,
          -80},{-22,-76},{-20,-76},{-18,-76},{-18,-76.4},{-17.2,-76.4}}, color=
          {0,0,127}));
  connect(Wnet_EG.u2, W_balance_integral.u) annotation (Line(points={{-30,-84},
          {-30,-86},{-40,-86},{-40,-60},{-37.2,-60}}, color={0,0,127}));
  connect(W_EG_delay.y, Wnet_EG.u1) annotation (Line(points={{-43.4,-80},{-38.7,
          -80},{-34,-80}}, color={0,0,127}));
  connect(W_EG_delay.u1, gain1.y) annotation (Line(points={{-57.2,-75.2},{-66,-75.2},
          {-66,-80},{-75.6,-80}}, color={0,0,127}));
  connect(W_EG_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,-84.8},
          {-64,-84.8},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(W_EG_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,-80},{
          -62,-80},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(W_IP_delay.y, Wnet_EG_IP.u2) annotation (Line(points={{-43.4,-94},{-22,
          -94},{-22,-83.6},{-17.2,-83.6}}, color={0,0,127}));
  connect(W_IP_delay.u3, dW_EG_delay.u3) annotation (Line(points={{-57.2,-98.8},
          {-64,-98.8},{-64,115.2},{-57.2,115.2}}, color={0,0,127}));
  connect(W_IP_delay.u2, dW_EG_delay.u2) annotation (Line(points={{-57.2,-94},{
          -62,-94},{-62,120},{-57.2,120}}, color={255,0,255}));
  connect(signalBus.Signals_SY.s_IP_power, W_IP_delay.u1) annotation (Line(
      points={{-100,0},{-100,0},{-100,-90},{-100,-89.2},{-57.2,-89.2}},
      color={255,204,51},
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
end DataSummary_Advanced;
