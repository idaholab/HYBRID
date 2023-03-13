within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_3
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={-11,-9})));

  Modelica.Blocks.Sources.Constant const(k=0.5)
    annotation (Placement(transformation(extent={{-156,40},{-142,54}})));
  Modelica.Blocks.Sources.Constant const1(k=500 + 273)
    annotation (Placement(transformation(extent={{-154,-76},{-140,-62}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-80,68},{-60,88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{26,70},{46,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{86,-8},{106,12}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT0(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-62,2},{-42,22}})));
  TRANSFORM.Controls.LimPID Pump_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.005,
    Ti=100,
    yb=0.01,
    yMax=1,
    yMin=0.01,
    wp=0.8,
    Ni=0.1,
    xi_start=0,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-112,-88},{-98,-74}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                                    condenser(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V_total=0.1,
    V_liquid_start=0.01,
    set_m_flow=false,
    p=5000)
    annotation (Placement(transformation(extent={{33,16},{53,36}})));
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
  Modelica.Blocks.Sources.Constant const2(k=0.09)
    annotation (Placement(transformation(extent={{-100,-50},{-86,-36}})));
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
    height=-0.2,
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
    m_flow_start=0.1,
    m_flow_nominal=0.08,
    use_T_nominal=false,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=5000,
    d_nominal=30,
    p_a_start=400000,
    p_inlet_nominal=5000000)
    annotation (Placement(transformation(extent={{-30,54},{-10,74}})));

  Electrical.Generator      generator1(J=1e4)
    annotation (Placement(transformation(extent={{28,54},{48,74}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{-2,74},{18,54}})));
equation
  connect(sensor_pT3.port, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{96,-8},{96,-9},{0,-9}},   color={0,127,255}));
  connect(const1.y,Pump_Speed. u_s) annotation (Line(points={{-139.3,-69},{
          -139.3,-70},{-120,-70},{-120,-81},{-113.4,-81}}, color={0,0,127}));
  connect(condenser.port_b, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{43,18},{0,18},{0,-9}}, color={0,127,255}));
  connect(sensor_pT2.port, condenser.port_a)
    annotation (Line(points={{36,70},{36,33}}, color={0,127,255}));
  connect(sensor_pT4.port, boundary.ports[1]) annotation (Line(points={{-109,62},
          {-102,62},{-102,38},{-104,38},{-104,39.75}}, color={0,127,255}));
  connect(boundary1.ports[1], resistance2.port_a)
    annotation (Line(points={{-138,-20},{-121,-20}}, color={0,127,255}));
  connect(lmtd_HX1.port_a1, boundary.ports[2]) annotation (Line(points={{-84,36},
          {-84,40.25},{-104,40.25}}, color={0,127,255}));
  connect(lmtd_HX1.port_a2, pump_SimpleMassFlow1.port_b)
    annotation (Line(points={{-76,16},{-76,-9},{-22,-9}}, color={0,127,255}));
  connect(lmtd_HX1.port_b1, resistance2.port_b) annotation (Line(points={{-84,
          16},{-84,-20},{-107,-20}}, color={0,127,255}));
  connect(sensor_pT5.port, resistance2.port_b) annotation (Line(points={{-115,2},
          {-116,2},{-116,-4},{-98,-4},{-98,-20},{-107,-20}}, color={0,127,255}));
  connect(sensor_pT0.port, pump_SimpleMassFlow1.port_b)
    annotation (Line(points={{-52,2},{-52,-9},{-22,-9}}, color={0,127,255}));
  connect(ramp.y, boundary.m_flow_in) annotation (Line(points={{-143.3,73},{-132,
          73},{-132,48},{-124,48}}, color={0,0,127}));
  connect(Pump_Speed.y, pump_SimpleMassFlow1.in_m_flow) annotation (Line(points
        ={{-97.3,-81},{-97.3,-82},{-11,-82},{-11,-17.03}}, color={0,0,127}));
  connect(sensor_pT1.T, Pump_Speed.u_m) annotation (Line(points={{-64,75.8},{-62,
          75.8},{-62,76},{-58,76},{-58,94},{-202,94},{-202,-92},{-105,-92},{-105,
          -89.4}}, color={0,0,127}));
  connect(steamTurbine.portLP, condenser.port_a) annotation (Line(points={{-10,70},
          {20,70},{20,44},{36,44},{36,33}}, color={0,127,255}));
  connect(steamTurbine.portHP, lmtd_HX1.port_b2) annotation (Line(points={{-30,70},
          {-54,70},{-54,42},{-76,42},{-76,36}}, color={0,127,255}));
  connect(sensor_pT1.port, lmtd_HX1.port_b2) annotation (Line(points={{-70,68},{
          -62,68},{-62,70},{-54,70},{-54,42},{-76,42},{-76,36}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{-10,64},{-2,64}}, color={0,0,0}));
  connect(powerSensor.flange_b, generator1.shaft_a)
    annotation (Line(points={{18,64},{28,64}}, color={0,0,0}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(StopTime=5000, __Dymola_Algorithm="Esdirk34a"));
end WaterCircTrial_3;
