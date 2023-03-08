within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_2a
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

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
    NTU=4,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium =
        Modelica.Media.Air.DryAirNasa,
    redeclare package Shell_medium =
        Modelica.Media.Water.StandardWater,
    V_Tube=0.1,
    V_Shell=0.1,
    use_T_start_tube=true,
    T_start_tube_inlet=1023.15,
    T_start_tube_outlet=573.15,
    p_start_shell=200000,
    use_T_start_shell=true,
    T_start_shell_inlet=523.15,
    T_start_shell_outlet=523.15,
    Q_init=30000,
    m_start_tube=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-84,28})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{-122,62},{-96,80}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{-124,4},{-98,22}})));
  Modelica.Blocks.Sources.Constant const2(k=0.01)
    annotation (Placement(transformation(extent={{-100,-50},{-86,-36}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_m_flow_in=true,
    T=973.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-124,30},{-104,50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=200)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-114,-20})));
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
  connect(pump_SimpleMassFlow1.port_b, nTU_HX_SinglePhase.Shell_in)
    annotation (Line(points={{-22,-9},{-82,-9},{-82,18}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase.Shell_out, resistance1.port_a)
    annotation (Line(points={{-82,38},{-82,56},{-19,56}}, color={0,127,255}));
  connect(sensor_pT0.port, nTU_HX_SinglePhase.Shell_in) annotation (Line(points
        ={{-52,2},{-52,-9},{-82,-9},{-82,18}}, color={0,127,255}));
  connect(boundary.ports[1], nTU_HX_SinglePhase.Tube_in) annotation (Line(
        points={{-104,39.75},{-104,38},{-88,38}},
                                               color={0,127,255}));
  connect(const.y, boundary.m_flow_in) annotation (Line(points={{-141.3,47},{-132.65,
          47},{-132.65,48},{-124,48}}, color={0,0,127}));
  connect(sensor_pT4.port, boundary.ports[2]) annotation (Line(points={{-109,62},
          {-102,62},{-102,38},{-104,38},{-104,40.25}}, color={0,127,255}));
  connect(Pump_Speed.y, pump_SimpleMassFlow1.in_m_flow) annotation (Line(points
        ={{-97.3,-81},{-97.3,-82},{-11,-82},{-11,-17.03}}, color={0,0,127}));
  connect(sensor_pT5.port, nTU_HX_SinglePhase.Tube_out)
    annotation (Line(points={{-111,4},{-88,4},{-88,18}}, color={0,127,255}));
  connect(boundary1.ports[1], resistance2.port_a)
    annotation (Line(points={{-138,-20},{-121,-20}}, color={0,127,255}));
  connect(resistance2.port_b, nTU_HX_SinglePhase.Tube_out) annotation (Line(
        points={{-107,-20},{-88,-20},{-88,18}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end WaterCircTrial_2a;
