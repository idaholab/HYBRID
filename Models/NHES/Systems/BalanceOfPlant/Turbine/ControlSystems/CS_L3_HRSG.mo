within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L3_HRSG

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=data.HPT_p_in)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-1,
    Ti=30,
    yMax=2*data.mdot_hpt,
    yMin=data.mdot_hpt*0.1)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  TRANSFORM.Controls.LimPID TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-7e-9,
    Ti=360,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=data.HPT_p_in, uHigh=
        data.p_dump)
    annotation (Placement(transformation(extent={{-20,-140},{0,-160}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open0(y=0)
    annotation (Placement(transformation(extent={{-20,-184},{0,-164}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open1(y=1)
    annotation (Placement(transformation(extent={{-20,-146},{0,-126}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=4000,
    offset=0,
    startTime=8000)
    annotation (Placement(transformation(extent={{-66,-210},{-46,-190}})));
  Modelica.Blocks.Math.Product
                           product1
    annotation (Placement(transformation(extent={{96,-172},{116,-152}})));
equation

  connect(P_in_set.y, TCV_PID.u_s)
    annotation (Line(points={{-79,10},{-14,10}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, TCV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-10},{-2,-10},{-2,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_TCV, TCV_PID.y) annotation (Line(
      points={{30.1,-99.9},{30,-99.9},{30,10},{9,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_in_set.y, FeedPump_PID.u_s)
    annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{1,-150},{18,-150}}, color={255,0,255}));
  connect(sensorBus.Steam_Pressure, hysteresis.u) annotation (Line(
      points={{-30,-100},{-30,-150},{-22,-150}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(P_dump_open0.y, switch1.u3) annotation (Line(points={{1,-174},{10,
          -174},{10,-158},{18,-158}}, color={0,0,127}));
  connect(switch1.u1, P_dump_open1.y) annotation (Line(points={{18,-142},{6,
          -142},{6,-136},{1,-136}}, color={0,0,127}));
  connect(ramp.y, product1.u2) annotation (Line(points={{-45,-200},{86,-200},{
          86,-168},{94,-168}}, color={0,0,127}));
  connect(actuatorBus.TBV, product1.y) annotation (Line(
      points={{30,-100},{30,-136},{117,-136},{117,-162}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, product1.u1) annotation (Line(points={{41,-150},{84,-150},
          {84,-156},{94,-156}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FeedPump_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,72},{0,72},{0,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
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
end CS_L3_HRSG;
