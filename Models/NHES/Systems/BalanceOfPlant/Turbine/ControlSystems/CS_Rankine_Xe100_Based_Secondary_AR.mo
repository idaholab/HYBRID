within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_Rankine_Xe100_Based_Secondary_AR

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-72,16},{-52,36}})));
  Modelica.Blocks.Sources.Constant const4(k=1200)
    annotation (Placement(transformation(extent={{42,72},{50,80}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{64,60},{84,80}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-56,-18},{-36,-38}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-86,-38},{-66,-18}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-28,-44},{-20,-36}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{-34,-78},{-26,-70}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-34,-66},{-26,-58}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-80,52},{-60,72}})));
  Data.HTGR_Rankine
                  data(p_steam_vent=15000000, Q_Nom=44e6)
    annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{44,-44},{64,-24}})));
  Modelica.Blocks.Sources.Constant valvedelay(k=1e6)
    annotation (Placement(transformation(extent={{48,-8},{68,12}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{88,-8},{108,-28}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
    annotation (Placement(transformation(extent={{128,-28},{148,-8}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-0.00740122,
    rising=780,
    width=1020,
    falling=780,
    period=3600,
    nperiod=1,
    offset=0.0098683,
    startTime=1e6 + 900)
    annotation (Placement(transformation(extent={{88,16},{108,36}})));
  Modelica.Blocks.Sources.ContinuousClock clock2(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-174,104},{-154,124}})));
  Modelica.Blocks.Sources.Constant valvedelay2(k=6e5)
    annotation (Placement(transformation(extent={{-170,140},{-150,160}})));
  Modelica.Blocks.Logical.Greater greater2
    annotation (Placement(transformation(extent={{-130,140},{-110,120}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV1
    annotation (Placement(transformation(extent={{-90,120},{-70,140}})));
  Modelica.Blocks.Sources.Constant const1(k=-280)
    annotation (Placement(transformation(extent={{-122,150},{-114,158}})));
  Modelica.Blocks.Sources.Constant const2(k=-150)
    annotation (Placement(transformation(extent={{-124,96},{-116,104}})));
  Modelica.Blocks.Sources.Constant const10(k=5000)
    annotation (Placement(transformation(extent={{-64,154},{-56,162}})));
  PrimaryHeatSystem.HTGR.LimPID_AR PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=true,
    k=-5e-1,
    Ti=30) annotation (Placement(transformation(extent={{-4,16},{16,36}})));
  Modelica.Blocks.Sources.Constant const11(k=-1e-1)
    annotation (Placement(transformation(extent={{-120,182},{-112,190}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-170,188},{-150,208}})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=8.5e5)
    annotation (Placement(transformation(extent={{-166,224},{-146,244}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-126,224},{-106,204}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV2
    annotation (Placement(transformation(extent={{-86,204},{-66,224}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-0.5e-1,
    duration=1e5,
    offset=-1e-1,
    startTime=8.7e5)
    annotation (Placement(transformation(extent={{-124,244},{-104,264}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=-280,
    rising=780,
    width=1020,
    falling=780,
    period=3600,
    nperiod=1,
    offset=0,
    startTime=1e6 + 900)
    annotation (Placement(transformation(extent={{-150,20},{-130,40}})));
equation

  connect(const4.y, add.u1) annotation (Line(points={{50.4,76},{62,76}},
                                   color={0,0,127}));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{-73,-62},{-66,-62}},   color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-54,-100},{-54,-74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{-65,-28},{-58,-28}},   color={0,0,127}));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-8},{-46,-8},{-46,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, add1.u2) annotation (Line(points={{-19.6,-40},{-12,-40}},
                                      color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{-35,-28},{-12,-28}},
                                                  color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-68},{11,-68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{-12,-74},{-25.6,-74}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1, timer.y) annotation (Line(points={{-12,-62},{-25.44,-62}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-43,-62},{-34.8,
          -62}},                                                     color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-59,62},{-42,62}},   color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,44},{-30,44},{-30,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,62},{-19,62}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(clock.y, greater5.u1) annotation (Line(points={{65,-34},{80,-34},{80,
          -18},{86,-18}}, color={0,0,127}));
  connect(valvedelay.y, greater5.u2) annotation (Line(points={{69,2},{80,2},{80,
          -10},{86,-10}}, color={0,0,127}));
  connect(greater5.y, switch_P_setpoint_TCV.u2)
    annotation (Line(points={{109,-18},{126,-18}}, color={255,0,255}));
  connect(add1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{11,-34},{
          18,-34},{18,-56},{122,-56},{122,-26},{126,-26}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, switch_P_setpoint_TCV.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-62},{158,-62},{158,-18},{149,-18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(trapezoid.y, switch_P_setpoint_TCV.u1) annotation (Line(points={{109,
          26},{118,26},{118,-10},{126,-10}}, color={0,0,127}));
  connect(clock2.y, greater2.u1) annotation (Line(points={{-153,114},{-138,114},
          {-138,130},{-132,130}}, color={0,0,127}));
  connect(valvedelay2.y, greater2.u2) annotation (Line(points={{-149,150},{-138,
          150},{-138,138},{-132,138}}, color={0,0,127}));
  connect(greater2.y, switch_P_setpoint_TCV1.u2)
    annotation (Line(points={{-109,130},{-92,130}}, color={255,0,255}));
  connect(const2.y, switch_P_setpoint_TCV1.u3) annotation (Line(points={{-115.6,
          100},{-110,100},{-110,118},{-92,118},{-92,122}}, color={0,0,127}));
  connect(const1.y, switch_P_setpoint_TCV1.u1) annotation (Line(points={{-113.6,
          154},{-98,154},{-98,138},{-92,138}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,50},{92,50},{92,70},{85,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const10.y, PID.upperlim) annotation (Line(points={{-55.6,158},{-24,
          158},{-24,140},{-12,140},{-12,39.6},{-6,39.6}}, color={0,0,127}));
  connect(switch_P_setpoint_TCV1.y, PID.lowerlim) annotation (Line(points={{-69,
          130},{-36,130},{-36,124},{-6,124},{-6,50},{-14,50},{-14,11},{-6.4,11}},
        color={0,0,127}));
  connect(sensorBus.Steam_Temperature, PID.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-8},{6,-8},{6,14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y, PID.u_s)
    annotation (Line(points={{-51,26},{-6,26}}, color={0,0,127}));
  connect(PID.y, add.u2) annotation (Line(points={{17,26},{34,26},{34,34},{48,
          34},{48,64},{62,64}}, color={0,0,127}));
  connect(clock1.y, greater1.u1) annotation (Line(points={{-149,198},{-134,198},
          {-134,214},{-128,214}}, color={0,0,127}));
  connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-145,234},{-134,
          234},{-134,222},{-128,222}}, color={0,0,127}));
  connect(greater1.y, switch_P_setpoint_TCV2.u2)
    annotation (Line(points={{-105,214},{-88,214}}, color={255,0,255}));
  connect(const11.y, switch_P_setpoint_TCV2.u3) annotation (Line(points={{
          -111.6,186},{-104,186},{-104,188},{-98,188},{-98,206},{-88,206}},
        color={0,0,127}));
  connect(switch_P_setpoint_TCV2.y, PID.prop_k) annotation (Line(points={{-65,
          214},{-48,214},{-48,212},{-16,212},{-16,44.8},{-6,44.8}}, color={0,0,
          127}));
  connect(ramp.y, switch_P_setpoint_TCV2.u1) annotation (Line(points={{-103,254},
          {-96,254},{-96,222},{-88,222}}, color={0,0,127}));
  connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{-129,30},{-78,30},{
          -78,40},{-12,40},{-12,34},{-6,34}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Xe100_Based_Secondary_AR;
