within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_6bCS
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={91,-21})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-82,70},{-62,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{140,84},{160,104}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{126,-48},{146,-28}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT0(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-62,2},{-42,22}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                                    condenser(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V_total=1,
    V_liquid_start=0.01,
    set_m_flow=false,
    p=5000)
    annotation (Placement(transformation(extent={{147,-14},{167,6}})));
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
    T=873.15,
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
    V_1=0.1,
    V_2=0.1,
    surfaceArea=10,
    alpha_1=500,
    alpha_2=2500,
    p_a_start_1=100000,
    p_b_start_1=100000,
    T_a_start_1=623.15,
    T_b_start_1=623.15,
    m_flow_start_1=0.5,
    p_a_start_2=200000,
    p_b_start_2=200000,
    use_Ts_start_2=false,
    T_a_start_2=293.15,
    T_b_start_2=773.15,
    h_a_start_2=150000,
    h_b_start_2=400000,
    m_flow_start_2=0.08,
    R_1=100,
    R_2=100) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-80,26})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0,
    duration=300,
    offset=0.5,
    startTime=2000)
    annotation (Placement(transformation(extent={{-158,66},{-144,80}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.08,
    m_flow_nominal=0.08,
    use_T_nominal=false,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=200000,
    d_nominal=30,
    p_a_start=400000,
    p_inlet_nominal=5000000)
    annotation (Placement(transformation(extent={{-30,54},{-10,74}})));

  Electrical.Generator      generator1(J=1e4, f_start=60)
    annotation (Placement(transformation(extent={{114,54},{134,74}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{84,74},{104,54}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.1,
    m_flow_nominal=0.08,
    use_T_nominal=false,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=5000,
    d_nominal=10,
    p_a_start=400000,
    p_inlet_nominal=200000)
    annotation (Placement(transformation(extent={{10,54},{30,74}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT_ext(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-4,82},{16,102}})));
  TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=0.001,
    m_flow_small=1e-5,
    dp_nominal=200000,
    m_flow_nominal=0.008)
                       annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={42,6})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT_ext2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{14,16},{34,36}})));
  TRANSFORM.HeatExchangers.Simple_HX_A lmtd_HX2(
    redeclare package Medium_1 = Modelica.Media.Water.StandardWater,
    redeclare package Medium_2 = Modelica.Media.Water.StandardWater,
    nV=5,
    V_1=0.02,
    V_2=0.02,
    surfaceArea=1,
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
        origin={14,-16})));
  replaceable ControlSystems.CS_SteamTSlidingP
                                    CS constrainedby
    ControlSystems.CS_SteamTSlidingP   annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-20,134},{-4,150}})));
  replaceable ControlSystems.ED_Dummy
                                  ED annotation (choicesAllMatching=true,
      Placement(transformation(extent={{0,134},{16,150}})));
  BaseClasses.SignalSubBus_ActuatorInput
                             actuatorBus
    annotation (Placement(transformation(extent={{8,92},{48,132}}),
        iconTransformation(extent={{10,80},{50,120}})));
  BaseClasses.SignalSubBus_SensorOutput
                            sensorBus
    annotation (Placement(transformation(extent={{-52,92},{-12,132}}),
        iconTransformation(extent={{-50,80},{-10,120}})));
equation
  connect(sensor_pT3.port, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{136,-48},{136,-54},{114,-54},{114,-21},{102,-21}},
                                                        color={0,127,255}));
  connect(condenser.port_b, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{157,-12},{157,-21},{102,-21}},
                                                     color={0,127,255}));
  connect(sensor_pT2.port, condenser.port_a)
    annotation (Line(points={{150,84},{150,3}},color={0,127,255}));
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
  connect(ramp.y, boundary.m_flow_in) annotation (Line(points={{-143.3,73},{-132,
          73},{-132,48},{-124,48}}, color={0,0,127}));
  connect(steamTurbine.portHP, lmtd_HX1.port_b2) annotation (Line(points={{-30,70},
          {-76,70},{-76,36}},                   color={0,127,255}));
  connect(sensor_pT1.port, lmtd_HX1.port_b2) annotation (Line(points={{-72,70},
          {-76,70},{-76,36}},                                    color={0,127,255}));
  connect(powerSensor.flange_b, generator1.shaft_a)
    annotation (Line(points={{104,64},{114,64}},
                                               color={0,0,0}));
  connect(steamTurbine.shaft_b, steamTurbine1.shaft_a)
    annotation (Line(points={{-10,64},{10,64}}, color={0,0,0}));
  connect(steamTurbine1.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{30,64},{84,64}}, color={0,0,0}));
  connect(steamTurbine.portLP, steamTurbine1.portHP)
    annotation (Line(points={{-10,70},{10,70}}, color={0,127,255}));
  connect(steamTurbine1.portLP, condenser.port_a) annotation (Line(points={{30,
          70},{76,70},{76,84},{150,84},{150,3}}, color={0,127,255}));
  connect(sensor_pT_ext.port, steamTurbine1.portHP)
    annotation (Line(points={{6,82},{6,70},{10,70}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, lmtd_HX2.port_a2) annotation (Line(
        points={{80,-21},{52,-21},{52,-20},{24,-20}}, color={0,127,255}));
  connect(lmtd_HX2.port_b2, lmtd_HX1.port_a2)
    annotation (Line(points={{4,-20},{-76,-20},{-76,16}}, color={0,127,255}));
  connect(sensor_pT0.port, lmtd_HX1.port_a2) annotation (Line(points={{-52,2},{
          -52,-20},{-76,-20},{-76,16}}, color={0,127,255}));
  connect(lmtd_HX2.port_a1, steamTurbine1.portHP) annotation (Line(points={{4,
          -12},{2,-12},{2,70},{10,70}}, color={0,127,255}));
  connect(lmtd_HX2.port_b1, InternalBypass.port_a) annotation (Line(points={{24,
          -12},{26,-12},{26,6},{34,6}}, color={0,127,255}));
  connect(InternalBypass.port_b, condenser.port_a) annotation (Line(points={{50,6},{
          150,6},{150,3}},             color={0,127,255}));
  connect(sensor_pT_ext2.port, InternalBypass.port_a) annotation (Line(points={{24,16},
          {26,16},{26,6},{34,6}},                 color={0,127,255}));
  connect(sensorBus,ED. sensorBus) annotation (Line(
      points={{-32,112},{5.6,112},{5.6,134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus,CS. sensorBus) annotation (Line(
      points={{-32,112},{-14.4,112},{-14.4,134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,CS. actuatorBus) annotation (Line(
      points={{28,112},{-9.6,112},{-9.6,134}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,ED. actuatorBus) annotation (Line(
      points={{28,112},{10.4,112},{10.4,134}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, sensor_pT1.T) annotation (Line(
      points={{-32,112},{-58,112},{-58,77.8},{-66,77.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.Feed_Pump_mFlow, pump_SimpleMassFlow1.in_m_flow)
    annotation (Line(
      points={{28,112},{172,112},{172,-108},{91,-108},{91,-29.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Feedwater_Temp, sensor_pT0.T) annotation (Line(
      points={{-32,112},{-202,112},{-202,-110},{-44,-110},{-44,9.8},{-46,9.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(actuatorBus.FW_valve_opening, InternalBypass.opening) annotation (
      Line(
      points={{28,112},{42,112},{42,12.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(steamTurbine.portHP, sensor_pT1.port)
    annotation (Line(points={{-30,70},{-72,70}}, color={0,127,255}));
  connect(steamTurbine1.portLP, sensor_pT2.port) annotation (Line(points={{30,
          70},{76,70},{76,84},{150,84}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=10000,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk34a"));
end WaterCircTrial_6bCS;
