within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_6b
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={91,-21})));

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
    annotation (Placement(transformation(extent={{144,84},{164,104}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{136,-76},{156,-56}})));
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
  Modelica.Blocks.Sources.Constant const2(k=0.01)
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
    annotation (Placement(transformation(extent={{52,34},{72,54}})));
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
  Modelica.Blocks.Sources.Constant const3(k=100 + 273)
    annotation (Placement(transformation(extent={{-48,34},{-34,48}})));
  TRANSFORM.Controls.LimPID FWH_ctr(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=50,
    yb=0.001,
    yMax=1,
    yMin=0.001,
    wp=0.8,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-22,10},{-8,24}})));
  Modelica.Blocks.Sources.Constant const12(k=0.002)
    annotation (Placement(transformation(extent={{-104,198},{-86,216}})));
  Modelica.Blocks.Sources.Constant valvedelay3(k=2500)
    annotation (Placement(transformation(extent={{-144,252},{-124,272}})));
  Modelica.Blocks.Sources.ContinuousClock clock3(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-144,212},{-124,232}})));
  Modelica.Blocks.Logical.Greater greater3
    annotation (Placement(transformation(extent={{-104,252},{-84,232}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV3
    annotation (Placement(transformation(extent={{-64,232},{-44,252}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=0.4,
    duration=2000,
    offset=0.001,
    startTime=4000)
    annotation (Placement(transformation(extent={{-92,274},{-78,288}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay2(Ti=20)
    annotation (Placement(transformation(extent={{8,236},{22,248}})));
equation
  connect(sensor_pT3.port, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{146,-76},{146,-82},{114,-82},{114,-21},{102,-21}},
                                                        color={0,127,255}));
  connect(const1.y,Pump_Speed. u_s) annotation (Line(points={{-139.3,-69},{
          -139.3,-70},{-120,-70},{-120,-81},{-113.4,-81}}, color={0,0,127}));
  connect(condenser.port_b, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{157,-12},{157,-21},{102,-21}},
                                                     color={0,127,255}));
  connect(sensor_pT2.port, condenser.port_a)
    annotation (Line(points={{154,84},{154,12},{136,12},{136,3},{150,3}},
                                               color={0,127,255}));
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
  connect(sensor_pT1.T, Pump_Speed.u_m) annotation (Line(points={{-64,75.8},{-62,
          75.8},{-62,76},{-58,76},{-58,94},{-202,94},{-202,-92},{-105,-92},{-105,
          -89.4}}, color={0,0,127}));
  connect(steamTurbine.portHP, lmtd_HX1.port_b2) annotation (Line(points={{-30,70},
          {-54,70},{-54,42},{-76,42},{-76,36}}, color={0,127,255}));
  connect(sensor_pT1.port, lmtd_HX1.port_b2) annotation (Line(points={{-70,68},{
          -62,68},{-62,70},{-54,70},{-54,42},{-76,42},{-76,36}}, color={0,127,255}));
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
  connect(InternalBypass.port_b, condenser.port_a) annotation (Line(points={{50,
          6},{136,6},{136,3},{150,3}}, color={0,127,255}));
  connect(sensor_pT_ext2.port, InternalBypass.port_a) annotation (Line(points={
          {62,34},{62,22},{30,22},{30,6},{34,6}}, color={0,127,255}));
  connect(const3.y, FWH_ctr.u_s) annotation (Line(points={{-33.3,41},{-26,41},{
          -26,22},{-28,22},{-28,17},{-23.4,17}}, color={0,0,127}));
  connect(valvedelay3.y,greater3. u2) annotation (Line(points={{-123,262},{-114,
          262},{-114,250},{-106,250}},color={0,0,127}));
  connect(clock3.y,greater3. u1) annotation (Line(points={{-123,222},{-116,222},
          {-116,242},{-106,242}}, color={0,0,127}));
  connect(greater3.y,switch_P_setpoint_TCV3. u2)
    annotation (Line(points={{-83,242},{-66,242}},   color={255,0,255}));
  connect(ramp2.y, switch_P_setpoint_TCV3.u3) annotation (Line(points={{-77.3,
          281},{-38,281},{-38,226},{-66,226},{-66,234}}, color={0,0,127}));
  connect(sensor_pT0.T, FWH_ctr.u_m) annotation (Line(points={{-46,9.8},{-28,
          9.8},{-28,8.6},{-15,8.6}}, color={0,0,127}));
  connect(delay2.u, switch_P_setpoint_TCV3.y)
    annotation (Line(points={{6.6,242},{-43,242}}, color={0,0,127}));
  connect(FWH_ctr.y, switch_P_setpoint_TCV3.u1) annotation (Line(points={{-7.3,
          17},{-6,17},{-6,26},{-32,26},{-32,258},{-66,258},{-66,250}}, color={0,
          0,127}));
  connect(delay2.y, InternalBypass.opening) annotation (Line(points={{22.98,242},
          {42,242},{42,12.4}}, color={0,0,127}));
  connect(Pump_Speed.y, pump_SimpleMassFlow1.in_m_flow) annotation (Line(points
        ={{-97.3,-81},{-97.3,-82},{91,-82},{91,-29.03}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=10000,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk34a"));
end WaterCircTrial_6b;
