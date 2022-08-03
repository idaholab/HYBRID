within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl_PID_TESUC_1_intermediate
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
  Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
    annotation (Placement(transformation(extent={{-72,30},{-52,50}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=2.5e-5,
    Ti=20,
    Td=0.1,
    yMax=250,
    yMin=-67,
    wp=0,
    wd=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Constant const4(k=67)
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
  TRANSFORM.Controls.LimPID SHS_TCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-8,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.001,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{98,28},{78,8}})));
  Modelica.Blocks.Sources.Constant const11(k=1)
    annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{62,0},{42,20}})));
  Modelica.Blocks.Math.Add         add5
    annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
  TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-9,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=1 - 0.015,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
  Modelica.Blocks.Sources.Constant const10(k=0.015)
    annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
  Modelica.Blocks.Math.Add add6
    annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
  Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
    annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
  Modelica.Blocks.Sources.Constant const13(k=0)
    annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
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
    annotation (Line(points={{-51,40},{-42,40}}, color={0,0,127}));
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
  connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
          134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
  connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
          {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
          {-52,-12}}, color={0,0,127}));
  connect(add5.u1, Charge_OnOff_Throttle.y)
    annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
  connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
          -82},{73.6,-82}}, color={0,0,127}));
  connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
          {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
  connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
          -26},{146,-52},{136,-52}}, color={0,0,127}));
  connect(add6.u2, const12.y)
    annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
  connect(const13.y, Charge_OnOff_Throttle.u_m)
    annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
  connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
      points={{30,-100},{30,-66},{37,-66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
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
end CS_IntermediateControl_PID_TESUC_1_intermediate;
