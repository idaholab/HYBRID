within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_2b
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={-11,-9})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=2000000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-12,56})));

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
    k=-0.1,
    Ti=10,
    yMax=2,
    yMin=0.0001,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=0.01)
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
  Modelica.Blocks.Sources.Constant const2(k=0.01)
    annotation (Placement(transformation(extent={{-100,-50},{-86,-36}})));
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
    nV=4,
    V_1=0.1,
    V_2=0.1,
    surfaceArea=10,
    alpha_1=500,
    alpha_2=2500,
    p_a_start_1=100000,
    p_b_start_1=100000,
    T_a_start_1=973.15,
    T_b_start_1=673.15,
    m_flow_start_1=0.5,
    p_a_start_2=500000,
    p_b_start_2=500000,
    T_a_start_2=293.15,
    T_b_start_2=773.15,
    m_flow_start_2=0.01,
    R_1=100,
    R_2=100) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-80,26})));
equation
  connect(sensor_pT3.port, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{96,-8},{96,-9},{0,-9}},   color={0,127,255}));
  connect(const1.y,Pump_Speed. u_s) annotation (Line(points={{-139.3,-69},{
          -139.3,-70},{-120,-70},{-120,-81},{-113.4,-81}}, color={0,0,127}));
  connect(sensor_pT1.T,Pump_Speed. u_m) annotation (Line(points={{-64,75.8},{-48,
          75.8},{-48,98},{-184,98},{-184,-92},{-105,-92},{-105,-89.4}},
                         color={0,0,127}));
  connect(condenser.port_b, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{43,18},{0,18},{0,-9}}, color={0,127,255}));
  connect(resistance1.port_b, condenser.port_a) annotation (Line(points={{-5,56},
          {20,56},{20,50},{36,50},{36,33}}, color={0,127,255}));
  connect(sensor_pT2.port, condenser.port_a)
    annotation (Line(points={{36,70},{36,33}}, color={0,127,255}));
  connect(sensor_pT1.port, resistance1.port_a)
    annotation (Line(points={{-70,68},{-70,56},{-19,56}}, color={0,127,255}));
  connect(const.y, boundary.m_flow_in) annotation (Line(points={{-141.3,47},{-132.65,
          47},{-132.65,48},{-124,48}}, color={0,0,127}));
  connect(sensor_pT4.port, boundary.ports[1]) annotation (Line(points={{-109,62},
          {-102,62},{-102,38},{-104,38},{-104,39.75}}, color={0,127,255}));
  connect(boundary1.ports[1], resistance2.port_a)
    annotation (Line(points={{-138,-20},{-121,-20}}, color={0,127,255}));
  connect(lmtd_HX1.port_b2, resistance1.port_a)
    annotation (Line(points={{-76,36},{-76,56},{-19,56}}, color={0,127,255}));
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
  connect(const2.y, pump_SimpleMassFlow1.in_m_flow) annotation (Line(points={{
          -85.3,-43},{-85.3,-44},{-11,-44},{-11,-17.03}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(StopTime=1000, __Dymola_Algorithm="Esdirk34a"));
end WaterCircTrial_2b;
