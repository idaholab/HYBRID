within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl_PID_TESUC_ImpControl
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
  annotation(Dialog(tab="General"));

  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-4,
    Ti=5,
    Td=0.1,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
  TRANSFORM.Controls.LimPID TCV_Power(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-8,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.0001,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand)
    annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  Modelica.Blocks.Sources.Constant const8(k=0.015)
    annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
  Data.Intermediate_Rankine_Setpoints data(
    p_steam=3398000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=67.38e6,
    T_Feedwater=421.15)
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
  Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-7,
    Ti=20,
    yMax=250,
    yMin=-72,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Constant const4(k=72.1)
    annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{2,36},{22,56}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{2,74},{22,94}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
  TRANSFORM.Controls.LimPID SHS_Pump_MFR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2e-4,
    Ti=5,
    Td=0.1,
    yMax=100,
    yMin=-19.9,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_SHS_Return)
    annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
  Modelica.Blocks.Sources.Constant const6(k=20)
    annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
  TRANSFORM.Controls.LimPID TCV_Power1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-8,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.0001,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{98,28},{78,8}})));
  Modelica.Blocks.Sources.Constant const11(k=1)
    annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{62,0},{42,20}})));
equation
  connect(const5.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                     color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-50,-100},{-50,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                      color={0,0,127}));
  connect(TCV_Power.y, add1.u1)
    annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
  connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
          -48},{-36,-40},{-32.8,-40}},                               color={0,0,
          127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-46},{13,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-18},{13,-18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_BV, const2.y) annotation (Line(
      points={{30.1,-99.9},{30.1,84},{23,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const3.y, FWCP_Speed.u_s)
    annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
  connect(FWCP_Speed.y, add.u2)
    annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
  connect(const4.y, add.u1)
    annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,46},{23,46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.SHS_Return_T, SHS_Pump_MFR.u_m) annotation (Line(
      points={{-30,-100},{-40,-100},{-40,-81.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const1.y, SHS_Pump_MFR.u_s) annotation (Line(points={{-71,-78},{-56,-78},
          {-56,-74},{-47.2,-74}}, color={0,0,127}));
  connect(SHS_Pump_MFR.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
          {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
  connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
          -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
  connect(actuatorBus.condensor_pump, add3.y) annotation (Line(
      points={{30,-100},{30,-74},{19,-74}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Power, TCV_Power1.u_m) annotation (Line(
      points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TCV_Power1.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
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
  connect(realExpression.y, TCV_Power1.u_s) annotation (Line(points={{128.7,-26},
          {134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
  connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
          {132,-26},{132,-40},{54,-40},{54,-4},{20,-4},{20,2},{-60,2},{-60,-12},
          {-52,-12}}, color={0,0,127}));
end CS_IntermediateControl_PID_TESUC_ImpControl;
