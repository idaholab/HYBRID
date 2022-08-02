within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
  annotation(Dialog(tab="General"));

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
  TRANSFORM.Controls.LimPID SHS_Pump_MFR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-3,
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
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=electric_demand - data.Q_Nom)
    annotation (Placement(transformation(extent={{166,12},{152,24}})));
equation
  connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                      color={0,0,127}));
  connect(TCV_Power.y, add1.u1)
    annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-18},{13,-18}},
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
  connect(realExpression1.y, SHS_TCV.u_s)
    annotation (Line(points={{151.3,18},{100,18}}, color={0,0,127}));
  connect(TCV_Power.u_s, add6.u1) annotation (Line(points={{-52,-12},{-62,-12},
          {-62,-32},{72,-32},{72,-16},{146,-16},{146,-52},{136,-52}}, color={0,
          0,127}));
end CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle;
