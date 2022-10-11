within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS;
model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
  annotation(Dialog(tab="General"));

  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand)
    annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
  Data.TES_Setpoints data(
    p_steam=1200000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=46.5e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-10e6,
    rising=720,
    width=7200,
    falling=720,
    period=18000,
    nperiod=-2,
    offset=45e6,
    startTime=20000)
    annotation (Placement(transformation(extent={{68,74},{82,88}})));
  TRANSFORM.Controls.LimPID SHS_TCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-8,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.005,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{98,28},{78,8}})));
  Modelica.Blocks.Sources.Constant const11(k=1)
    annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{62,0},{42,20}})));
  Modelica.Blocks.Math.Add         add7
    annotation (Placement(transformation(extent={{116,48},{96,68}})));
  TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.5e-9,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=1 - 0.01,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{152,74},{132,54}})));
  Modelica.Blocks.Sources.Constant const14(k=0)
    annotation (Placement(transformation(extent={{156,92},{148,100}})));
  Modelica.Blocks.Sources.Constant const15(k=0.01)
    annotation (Placement(transformation(extent={{140,38},{132,46}})));
  Modelica.Blocks.Math.Add add8(k1=-1)
    annotation (Placement(transformation(extent={{192,56},{172,76}})));
  Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{236,50},{216,70}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=electric_demand - data.Q_Nom)
    annotation (Placement(transformation(extent={{166,12},{152,24}})));
  Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
    annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-4,
    Ti=5,
    Td=0.1,
    yMax=2500,
    yMin=0,
    wd=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
  Modelica.Blocks.Sources.Constant const4(k=100)
    annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{-16,68},{4,88}})));
equation
  connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
      points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
          {64,16}}, color={0,0,127}));
  connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
          {64,4}}, color={0,0,127}));
  connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
      points={{30,-100},{30,10},{41,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add7.u1, Discharge_OnOff_Throttle.y)
    annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
  connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
          46},{131.6,46},{131.6,42}}, color={0,0,127}));
  connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
          64},{161,64},{161,66},{171,66}}, color={0,0,127}));
  connect(Discharge_OnOff_Throttle.u_m, const14.y)
    annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
  connect(add8.u2, const16.y)
    annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
  connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
          -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
  connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
      points={{30,-100},{30,58},{95,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(realExpression1.y, SHS_TCV.u_s)
    annotation (Line(points={{151.3,18},{100,18}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
      points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y,FWCP_Speed. u_s)
    annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
  connect(FWCP_Speed.y,add. u2)
    annotation (Line(points={{-37,72},{-18,72}},
                                               color={0,0,127}));
  connect(const4.y,add. u1)
    annotation (Line(points={{-23.6,84},{-18,84}},
                                                color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
      points={{30,-100},{30,78},{5,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
end CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle;
