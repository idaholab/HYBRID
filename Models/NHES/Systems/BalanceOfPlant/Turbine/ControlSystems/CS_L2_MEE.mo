within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L2_MEE

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression Power_set(y=3e6)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Controls.LimOffsetPID     FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-2,
    Ti=30,
    yMax=2*data.mdot_hpt,
    yMin=data.mdot_hpt*0.1,
    offset=data.mdot_hpt,
    delayTime=6000,
    init_output=data.mdot_hpt)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  TRANSFORM.Controls.LimPID TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=3e-5,
    Ti=200,
    yMax=0,
    yMin=-1)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  TRANSFORM.Controls.LimPID FeedHeating_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression MEE_Dis_mflow(y=0)
    annotation (Placement(transformation(extent={{-100,-160},{-80,-140}})));
  Modelica.Blocks.Sources.RealExpression Plpt_in_set(y=data.LPT1_p_in)
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Controls.LimOffsetPID     ECV_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=360,
    yMax=1,
    yMin=0,
    offset=0.5)
            annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  TRANSFORM.Controls.LimPID pArc_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=150,
    yMax=0,
    yMin=-1)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=data.HPT_p_in)
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{52,-48},{72,-28}})));
  Modelica.Blocks.Sources.RealExpression TBV1(y=1)
    annotation (Placement(transformation(extent={{72,-20},{52,0}})));
  Modelica.Blocks.Sources.Ramp           Dis_mflow_set
    annotation (Placement(transformation(extent={{-100,-140},{-80,-120}})));
  Controls.LimOffsetPID     MEE_CVs(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=3e-3,
    Ti=15,
    yMax=1,
    yMin=0,
    offset=0.1)
    annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{56,8},{76,28}})));
equation

  connect(T_feed_set.y, FeedHeating_PID.u_s)
    annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
  connect(actuatorBus.LPT2_BV, FeedHeating_PID.y) annotation (Line(
      points={{30,-100},{30,50},{11,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, FeedHeating_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,30},{0,30},{0,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_in_set.y, FeedPump_PID.u_s)
    annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
  connect(Plpt_in_set.y, ECV_PID.u_s)
    annotation (Line(points={{-79,-26},{-12,-26}}, color={0,0,127}));
  connect(actuatorBus.ECV, ECV_PID.y) annotation (Line(
      points={{30,-100},{30,-26},{11,-26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.I_pressure, ECV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-38},{0,-38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(P_in_set.y, pArc_PID.u_s)
    annotation (Line(points={{-79,-60},{-12,-60}}, color={0,0,127}));
  connect(sensorBus.Imp_pressure,pArc_PID. u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-8,-74},{-8,-80},{0,-80},{0,-72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.HPT_pArc, add.y) annotation (Line(
      points={{30,-100},{30,-62},{73,-62},{73,-38}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pArc_PID.y, add.u2) annotation (Line(points={{11,-60},{42,-60},{42,
          -44},{50,-44}}, color={0,0,127}));
  connect(TBV1.y, add.u1) annotation (Line(points={{51,-10},{42,-10},{42,-32},{
          50,-32}}, color={0,0,127}));
  connect(Dis_mflow_set.y, MEE_CVs.u_s)
    annotation (Line(points={{-79,-130},{-62,-130}}, color={0,0,127}));
  connect(MEE_Dis_mflow.y, MEE_CVs.u_m) annotation (Line(points={{-79,-150},{
          -50,-150},{-50,-142}}, color={0,0,127}));
  connect(Power_set.y, TCV_PID.u_s)
    annotation (Line(points={{-79,10},{-12,10}}, color={0,0,127}));
  connect(sensorBus.W_total, TCV_PID.u_m) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-12},{0,-12},{0,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TCV_PID.y, add1.u1) annotation (Line(points={{11,10},{44,10},{44,24},
          {54,24}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,4},{77,4},{77,18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TBV1.y, add1.u2) annotation (Line(points={{51,-10},{48,-10},{48,6},{
          46,6},{46,12},{54,12}}, color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position, MEE_CVs.y) annotation (Line(
      points={{30,-100},{30,-130},{-39,-130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.powerset, Power_set.y) annotation (Line(
      points={{30,-100},{30,24},{-28,24},{-28,10},{-79,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Temperature, FeedPump_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,68},{0,68},{0,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_Speed, FeedPump_PID.y) annotation (Line(
      points={{30,-100},{30,90},{11,90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L2_MEE;
