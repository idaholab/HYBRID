within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_6bCS_upcs2a
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={151,-23})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-82,70},{-62,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{200,84},{220,104}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{158,-22},{178,-2}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT0(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-62,2},{-42,22}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                                    condenser(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V_total=5,
    V_liquid_start=0.01,
    set_m_flow=false,
    p=5000)
    annotation (Placement(transformation(extent={{207,-16},{227,4}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    p=100000,
    T=773.15,
    nPorts=1) annotation (Placement(transformation(extent={{-158,-30},{-138,-10}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{-122,62},{-96,80}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{-128,2},{-102,20}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_m_flow_in=true,
    T=973.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-124,30},{-104,50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(
      redeclare package Medium = Modelica.Media.Air.DryAirNasa, R=200)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-114,-20})));
  TRANSFORM.HeatExchangers.Simple_HX_A lmtd_HX1(
    redeclare package Medium_1 = Modelica.Media.Air.DryAirNasa,
    redeclare package Medium_2 = Modelica.Media.Water.StandardWater,
    nV=40,
    V_1=3,
    V_2=3,
    surfaceArea=4000,
    alpha_1=500,
    alpha_2=2500,
    p_a_start_1=100000,
    p_b_start_1=100000,
    T_a_start_1=623.15,
    T_b_start_1=623.15,
    m_flow_start_1=100,
    p_a_start_2=200000,
    p_b_start_2=200000,
    use_Ts_start_2=false,
    T_a_start_2=293.15,
    T_b_start_2=773.15,
    h_a_start_2=150000,
    h_b_start_2=200000,
    m_flow_start_2=40,
    R_1=100,
    R_2=100) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-80,26})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=100,
    duration=300,
    offset=150,
    startTime=500)
    annotation (Placement(transformation(extent={{-188,54},{-174,68}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.08,
    m_flow_nominal=50,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=3000000,
    T_nominal=823.15,
    p_a_start=400000,
    p_inlet_nominal=16000000)
    annotation (Placement(transformation(extent={{-30,54},{-10,74}})));

  Electrical.Generator      generator1(J=1e4, f_start=60)
    annotation (Placement(transformation(extent={{174,54},{194,74}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{144,74},{164,54}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.1,
    m_flow_nominal=40,
    use_NominalInlet=true,
    use_T_nominal=false,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=5000,
    T_nominal=433.15,
    p_a_start=400000,
    p_inlet_nominal=500000,
    d_nominal=9)
    annotation (Placement(transformation(extent={{96,54},{116,74}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT_ext(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{82,76},{102,96}})));
  TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=0.001,
    m_flow_small=1e-5,
    dp_nominal=200000,
    m_flow_nominal=2)  annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={138,4})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT_ext2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{110,14},{130,34}})));
  TRANSFORM.HeatExchangers.Simple_HX_A lmtd_HX2(
    redeclare package Medium_1 = Modelica.Media.Water.StandardWater,
    redeclare package Medium_2 = Modelica.Media.Water.StandardWater,
    nV=5,
    V_1=1,
    V_2=1,
    surfaceArea=500,
    alpha_1=2000,
    alpha_2=1500,
    p_a_start_1=100000,
    p_b_start_1=100000,
    T_a_start_1=423.15,
    T_b_start_1=293.15,
    m_flow_start_1=0.001,
    p_a_start_2=200000,
    p_b_start_2=200000,
    use_Ts_start_2=false,
    T_a_start_2=293.15,
    T_b_start_2=773.15,
    h_a_start_2=150000,
    h_b_start_2=200000,
    m_flow_start_2=0.08,
    R_1=50,
    R_2=50)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={110,-18})));
  replaceable ControlSystems.CS_SteamTSlidingP
                                    CS(
    Pump_Speed(
      k=-0.05,
      Ti=20,
      yMax=80,
      yMin=5,
      xi_start=50),
    valvedelay3(k=1000),
    const3(k=150 + 273.15))            constrainedby
    ControlSystems.CS_SteamTSlidingP   annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-20,150},{-4,166}})));
  replaceable ControlSystems.ED_Dummy
                                  ED annotation (choicesAllMatching=true,
      Placement(transformation(extent={{0,150},{16,166}})));
  BaseClasses.SignalSubBus_ActuatorInput
                             actuatorBus
    annotation (Placement(transformation(extent={{8,108},{48,148}}),
        iconTransformation(extent={{10,80},{50,120}})));
  BaseClasses.SignalSubBus_SensorOutput
                            sensorBus
    annotation (Placement(transformation(extent={{-52,108},{-12,148}}),
        iconTransformation(extent={{-50,80},{-10,120}})));
  Modelica.Blocks.Sources.RealExpression Tsat(y=
        sensor_pT1.Medium.saturationTemperature(sensor_pT1.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-86,88},{-74,100}})));
  Modelica.Blocks.Sources.RealExpression Tsat1(y=
        sensor_pT_ext.Medium.saturationTemperature(sensor_pT_ext.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{86,94},{98,106}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase MainFeedwaterHeater(
    NTU=2,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=0.5,
    V_Shell=0.5,
    p_start_tube=1500000,
    use_T_start_tube=true,
    T_start_tube_inlet=323.15,
    T_start_tube_outlet=333.15,
    p_start_shell=200000,
    use_T_start_shell=true,
    T_start_shell_inlet=423.15,
    T_start_shell_outlet=343.15,
    dp_init_tube=20000,
    dp_init_shell=20000,
    Q_init=1000,
    m_start_tube=1,
    m_start_shell=1)
    annotation (Placement(transformation(extent={{102,-70},{122,-90}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass1(R=10,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={184,-78})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=200000,
    m_flow_nominal=5)                             annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={222,-76})));
  Modelica.Blocks.Sources.Constant const3(k=0.5)
    annotation (Placement(transformation(extent={{194,-54},{208,-40}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=5,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{176,-142},{156,-122}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2500000,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{34,-146},{54,-126}})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=20000,
    m_flow_nominal=5)                             annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={90,-54})));
  Modelica.Blocks.Sources.Constant const1(k=0.07)
    annotation (Placement(transformation(extent={{58,-52},{72,-38}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.08,
    m_flow_nominal=50,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=1000000,
    T_nominal=579.15,
    p_a_start=400000,
    p_inlet_nominal=3000000)
    annotation (Placement(transformation(extent={{16,54},{36,74}})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=20000,
    m_flow_nominal=5)                             annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-46})));
  Modelica.Blocks.Sources.Constant const2(k=0.001)
    annotation (Placement(transformation(extent={{-32,-44},{-18,-30}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT6(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{68,-136},{88,-116}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.08,
    m_flow_nominal=50,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=200000,
    T_nominal=579.15,
    p_a_start=400000,
    p_inlet_nominal=1000000)
    annotation (Placement(transformation(extent={{52,54},{72,74}})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=20000,
    m_flow_nominal=5)                             annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={48,2})));
  Modelica.Blocks.Sources.Constant const4(k=0.002)
    annotation (Placement(transformation(extent={{16,4},{30,18}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass2(R=10,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={68,-78})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-160,74},{-140,94}})));
  Modelica.Blocks.Sources.Ramp ramp4(
    height=-100,
    duration=100,
    offset=0,
    startTime=2500)
    annotation (Placement(transformation(extent={{-288,58},{-274,72}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.08,
    duration=300,
    offset=0.08,
    startTime=3500)
    annotation (Placement(transformation(extent={{60,-24},{74,-10}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=0.1,
    duration=300,
    offset=0.001,
    startTime=4500)
    annotation (Placement(transformation(extent={{14,28},{28,42}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=0.008,
    duration=300,
    offset=0.0005,
    startTime=6500)
    annotation (Placement(transformation(extent={{-34,-14},{-20,0}})));
equation
  connect(sensor_pT3.port, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{168,-22},{168,-23},{162,-23}},
                                                        color={0,127,255}));
  connect(condenser.port_b, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{217,-14},{217,-23},{162,-23}},
                                                     color={0,127,255}));
  connect(sensor_pT2.port, condenser.port_a)
    annotation (Line(points={{210,84},{210,1}},color={0,127,255}));
  connect(sensor_pT4.port, boundary.ports[1]) annotation (Line(points={{-109,62},
          {-102,62},{-102,38},{-104,38},{-104,39.75}}, color={0,127,255}));
  connect(boundary1.ports[1], resistance2.port_a)
    annotation (Line(points={{-138,-20},{-121,-20}}, color={0,127,255}));
  connect(lmtd_HX1.port_a1, boundary.ports[2]) annotation (Line(points={{-84,36},
          {-84,40.25},{-104,40.25}}, color={0,127,255}));
  connect(lmtd_HX1.port_b1, resistance2.port_b) annotation (Line(points={{-84,
          16},{-84,-20},{-107,-20}}, color={0,127,255}));
  connect(sensor_pT5.port, resistance2.port_b) annotation (Line(points={{-115,2},
          {-116,2},{-116,-4},{-98,-4},{-98,-20},{-107,-20}}, color={0,127,255}));
  connect(steamTurbine.portHP, lmtd_HX1.port_b2) annotation (Line(points={{-30,70},
          {-76,70},{-76,36}},                   color={0,127,255}));
  connect(sensor_pT1.port, lmtd_HX1.port_b2) annotation (Line(points={{-72,70},
          {-76,70},{-76,36}},                                    color={0,127,255}));
  connect(powerSensor.flange_b, generator1.shaft_a)
    annotation (Line(points={{164,64},{174,64}},
                                               color={0,0,0}));
  connect(steamTurbine1.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{116,64},{144,64}},
                                               color={0,0,0}));
  connect(steamTurbine1.portLP, condenser.port_a) annotation (Line(points={{116,70},
          {136,70},{136,84},{204,84},{204,10},{210,10},{210,1}},
                                                 color={0,127,255}));
  connect(sensor_pT_ext.port, steamTurbine1.portHP)
    annotation (Line(points={{92,76},{92,70},{96,70}},
                                                     color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, lmtd_HX2.port_a2) annotation (Line(
        points={{140,-23},{130,-23},{130,-22},{120,-22}},
                                                      color={0,127,255}));
  connect(lmtd_HX2.port_b2, lmtd_HX1.port_a2)
    annotation (Line(points={{100,-22},{-52,-22},{-52,-4},{-76,-4},{-76,16}},
                                                          color={0,127,255}));
  connect(sensor_pT0.port, lmtd_HX1.port_a2) annotation (Line(points={{-52,2},{
          -52,-20},{-76,-20},{-76,16}}, color={0,127,255}));
  connect(lmtd_HX2.port_a1, steamTurbine1.portHP) annotation (Line(points={{100,-14},
          {90,-14},{90,70},{96,70}},    color={0,127,255}));
  connect(lmtd_HX2.port_b1, InternalBypass.port_a) annotation (Line(points={{120,-14},
          {122,-14},{122,4},{130,4}},   color={0,127,255}));
  connect(InternalBypass.port_b, condenser.port_a) annotation (Line(points={{146,4},
          {202,4},{202,10},{210,10},{210,1}},
                                       color={0,127,255}));
  connect(sensor_pT_ext2.port, InternalBypass.port_a) annotation (Line(points={{120,14},
          {124,14},{124,4},{130,4}},              color={0,127,255}));
  connect(sensorBus,ED. sensorBus) annotation (Line(
      points={{-32,128},{5.6,128},{5.6,150}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus,CS. sensorBus) annotation (Line(
      points={{-32,128},{-14.4,128},{-14.4,150}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,CS. actuatorBus) annotation (Line(
      points={{28,128},{-9.6,128},{-9.6,150}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,ED. actuatorBus) annotation (Line(
      points={{28,128},{10.4,128},{10.4,150}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, sensor_pT1.T) annotation (Line(
      points={{-32,128},{-58,128},{-58,77.8},{-66,77.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.Feed_Pump_mFlow, pump_SimpleMassFlow1.in_m_flow)
    annotation (Line(
      points={{28,128},{358,128},{358,-94},{151,-94},{151,-31.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Feedwater_Temp, sensor_pT0.T) annotation (Line(
      points={{-32,128},{-202,128},{-202,-94},{-44,-94},{-44,9.8},{-46,9.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(actuatorBus.FW_valve_opening, InternalBypass.opening) annotation (
      Line(
      points={{28,128},{138,128},{138,10.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(steamTurbine.portHP, sensor_pT1.port)
    annotation (Line(points={{-30,70},{-72,70}}, color={0,127,255}));
  connect(steamTurbine1.portLP, sensor_pT2.port) annotation (Line(points={{116,70},
          {116,84},{210,84}},            color={0,127,255}));
  connect(MainFeedwaterHeater.Shell_out, R_InternalBypass1.port_a)
    annotation (Line(points={{122,-78},{177,-78}}, color={0,127,255}));
  connect(R_InternalBypass1.port_b, LPT_Bypass.port_a) annotation (Line(points=
          {{191,-78},{194,-78},{194,-76},{212,-76}}, color={0,127,255}));
  connect(LPT_Bypass.port_b, condenser.port_a) annotation (Line(points={{232,
          -76},{238,-76},{238,12},{210,12},{210,1}}, color={0,127,255}));
  connect(const3.y, LPT_Bypass.opening) annotation (Line(points={{208.7,-47},{
          208.7,-48},{228,-48},{228,-60},{222,-60},{222,-68}}, color={0,0,127}));
  connect(condenser.port_b, sensor_pT3.port) annotation (Line(points={{217,-14},
          {217,-22},{168,-22}}, color={0,127,255}));
  connect(boundary2.ports[1], MainFeedwaterHeater.Tube_in) annotation (Line(
        points={{156,-132},{128,-132},{128,-84},{122,-84}}, color={0,127,255}));
  connect(MainFeedwaterHeater.Tube_out, boundary3.ports[1]) annotation (Line(
        points={{102,-84},{90,-84},{90,-136},{54,-136}}, color={0,127,255}));
  connect(MainFeedwaterHeater.Shell_in, LPT_Bypass1.port_b)
    annotation (Line(points={{102,-78},{90,-78},{90,-64}}, color={0,127,255}));
  connect(LPT_Bypass1.port_a, steamTurbine1.portHP)
    annotation (Line(points={{90,-44},{90,70},{96,70}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, steamTurbine2.shaft_a)
    annotation (Line(points={{-10,64},{16,64}}, color={0,0,0}));
  connect(steamTurbine.portLP, steamTurbine2.portHP)
    annotation (Line(points={{-10,70},{16,70}}, color={0,127,255}));
  connect(LPT_Bypass2.port_a, steamTurbine.portLP)
    annotation (Line(points={{0,-36},{0,70},{-10,70}}, color={0,127,255}));
  connect(MainFeedwaterHeater.Tube_out, sensor_pT6.port) annotation (Line(
        points={{102,-84},{90,-84},{90,-136},{78,-136}}, color={0,127,255}));
  connect(steamTurbine2.shaft_b, steamTurbine3.shaft_a)
    annotation (Line(points={{36,64},{52,64}}, color={0,0,0}));
  connect(steamTurbine3.shaft_b, steamTurbine1.shaft_a)
    annotation (Line(points={{72,64},{96,64}}, color={0,0,0}));
  connect(steamTurbine2.portLP, steamTurbine3.portHP)
    annotation (Line(points={{36,70},{52,70}}, color={0,127,255}));
  connect(steamTurbine3.portLP, steamTurbine1.portHP)
    annotation (Line(points={{72,70},{96,70}}, color={0,127,255}));
  connect(LPT_Bypass3.port_a, steamTurbine2.portLP) annotation (Line(points={{
          48,12},{48,48},{42,48},{42,70},{36,70}}, color={0,127,255}));
  connect(LPT_Bypass2.port_b, R_InternalBypass2.port_a) annotation (Line(points
        ={{-1.77636e-15,-56},{-1.77636e-15,-78},{61,-78}}, color={0,127,255}));
  connect(R_InternalBypass2.port_b, MainFeedwaterHeater.Shell_in)
    annotation (Line(points={{75,-78},{102,-78}}, color={0,127,255}));
  connect(LPT_Bypass3.port_b, R_InternalBypass2.port_a)
    annotation (Line(points={{48,-8},{48,-78},{61,-78}}, color={0,127,255}));
  connect(ramp.y, add2.u2) annotation (Line(points={{-173.3,61},{-172,61},{-172,
          78},{-162,78}}, color={0,0,127}));
  connect(add2.y, boundary.m_flow_in) annotation (Line(points={{-139,84},{-134,
          84},{-134,48},{-124,48}}, color={0,0,127}));
  connect(ramp4.y, add2.u1) annotation (Line(points={{-273.3,65},{-194,65},{
          -194,90},{-162,90}}, color={0,0,127}));
  connect(ramp1.y, LPT_Bypass1.opening) annotation (Line(points={{74.7,-17},{
          74.7,-18},{82,-18},{82,-54}}, color={0,0,127}));
  connect(ramp2.y, LPT_Bypass3.opening) annotation (Line(points={{28.7,35},{30,
          35},{30,20},{32,20},{32,-14},{40,-14},{40,2}}, color={0,0,127}));
  connect(ramp3.y, LPT_Bypass2.opening) annotation (Line(points={{-19.3,-7},{
          -12,-7},{-12,-24},{-38,-24},{-38,-62},{-8,-62},{-8,-46}}, color={0,0,
          127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=10000,
      Tolerance=0.005,
      __Dymola_Algorithm="Esdirk34a"));
end WaterCircTrial_6bCS_upcs2a;
