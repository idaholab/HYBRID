within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L2_CEtest

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.RealExpression Power_set(y=10e6)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-1,
    Ti=30,
    yMax=2*data.mdot_hpt,
    yMin=data.mdot_hpt*0.1)
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  TRANSFORM.Controls.LimPID TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=360,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  TRANSFORM.Controls.LimPID LPT2_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Sources.RealExpression T_in_set1(y=data.mdot_total)
    annotation (Placement(transformation(extent={{0,54},{20,74}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=4000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Sources.RealExpression T_DH_set(y=60 + 273.15)
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Sources.RealExpression Zero(y=0)
    annotation (Placement(transformation(extent={{-60,-62},{-40,-42}})));
  Modelica.Blocks.Sources.RealExpression One(y=1)
    annotation (Placement(transformation(extent={{-60,-48},{-40,-28}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=data.HPT_p_in)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  TRANSFORM.Controls.LimPID Parc_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=360,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  TRANSFORM.Controls.LimPID EPCV_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=360,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Modelica.Blocks.Sources.RealExpression P_in_set1(y=data.LPT1_p_in)
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
equation

  connect(T_feed_set.y, LPT2_BV_PID.u_s)
    annotation (Line(points={{-79,40},{-12,40}}, color={0,0,127}));
  connect(actuatorBus.LPT2_BV, LPT2_BV_PID.y) annotation (Line(
      points={{30,-100},{30,40},{11,40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, LPT2_BV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,26},{0,26},{0,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Power_set.y, TCV_PID.u_s)
    annotation (Line(points={{-79,-20},{-12,-20}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, TCV_PID.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-20},{11,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_in_set.y, FeedPump_PID.u_s)
    annotation (Line(points={{-79,60},{-28,60},{-28,90},{-2,90}},
                                                 color={0,0,127}));
  connect(FeedPump_PID.y, switch2.u1)
    annotation (Line(points={{21,90},{38,90},{38,78}},
                                               color={0,0,127}));
  connect(switch2.u3, T_in_set1.y)
    annotation (Line(points={{38,62},{38,64},{21,64}},
                                               color={0,0,127}));
  connect(booleanStep.y, switch2.u2) annotation (Line(points={{-79,90},{-30,90},
          {-30,106},{32,106},{32,70},{38,70}},
                         color={255,0,255}));
  connect(actuatorBus.Feed_Pump_Speed, switch2.y) annotation (Line(
      points={{30,-100},{30,56},{68,56},{68,70},{61,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanStep.y, switch3.u2) annotation (Line(points={{-79,90},{-34,90},
          {-34,70},{-22,70}},
        color={255,0,255}));
  connect(switch3.y, FeedPump_PID.u_m) annotation (Line(points={{1,70},{1,74},{
          10,74},{10,78}},          color={0,0,127}));
  connect(sensorBus.Steam_Temperature, switch3.u1) annotation (Line(
      points={{-30,-100},{-30,78},{-22,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_in_set.y, switch3.u3) annotation (Line(points={{-79,60},{-28,60},{
          -28,62},{-22,62}},  color={0,0,127}));
  connect(sensorBus.W_total, TCV_PID.u_m) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-66},{-30,-66},{-30,-34},{0,-34},{0,-32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Parc_PID.u_s, P_in_set.y)
    annotation (Line(points={{-12,10},{-79,10}}, color={0,0,127}));
  connect(actuatorBus.HPT_pArc, Parc_PID.y) annotation (Line(
      points={{30,-100},{30,10},{11,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Imp_pressure, Parc_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-4},{0,-4},{0,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(EPCV_PID.u_s, P_in_set1.y)
    annotation (Line(points={{-12,-110},{-79,-110}}, color={0,0,127}));
  connect(sensorBus.I_pressure, EPCV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-130},{0,-130},{0,-122}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.ECV, EPCV_PID.y) annotation (Line(
      points={{30,-100},{30,-110},{11,-110}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.TBV, Zero.y) annotation (Line(
      points={{30,-100},{30,-36},{-34,-36},{-34,-52},{-39,-52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.LPT1_BV, Zero.y) annotation (Line(
      points={{30,-100},{30,-36},{-34,-36},{-34,-52},{-39,-52}},
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
end CS_L2_CEtest;
