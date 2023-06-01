within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1c_SimpleHXs_CoolProp_sCO2
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{144,58},{164,78}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater1(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-18,62})));
  GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    pstart_out=8471000,
    Tstart_in=1023.15,
    Tstart_out=908.05,
    eta0=0.9,
    PR0=2.3126,
    w0=2867)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={12,50})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    m_flow=2867,
    T=857.05,
    nPorts=1)
    annotation (Placement(transformation(extent={{-58,54},{-42,70}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{54,55},{42,67}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA HighTempRecuperator(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    p_start_1=8471000,
    p_start_2=20100000,
    T_start_1=908.05,
    T_start_2=458.15,
    m_flow_start_1=2867,
    m_flow_start_2=2867,
    R_1=1,
    R_2=1,
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=643750,
    nPorts=1) annotation (Placement(transformation(extent={{-72,8},{-58,22}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-50,5},{-30,25}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{82,8},{68,22}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{36,5},{56,25}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-74,-30},{-60,-16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-54,-33},{-34,-13}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20080000,
    h=1077200,
    nPorts=1) annotation (Placement(transformation(extent={{74,-24},{62,-12}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{34,-28},{54,-8}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA LowTempRecuperator(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    p_start_1=20130000,
    p_start_2=8451000,
    T_start_1=347.8,
    T_start_2=478.15,
    m_flow_start_1=1783,
    m_flow_start_2=2867,
    R_1=1,
    R_2=1,
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{88,-98},{74,-84}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{62,-101},{42,-81}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-60,-100},{-46,-86}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-12,-103},{-32,-83}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=643750,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,-68},{74,-54}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{60,-71},{40,-51}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-58,-66},{-46,-54}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-12,-70},{-32,-50}})));
equation
  connect(Heater1.port_b, turbine.inlet) annotation (Line(points={{-12,62},{1.2,62},{1.2,61.2}}, color={0,127,255}));
  connect(Heater1.port_a, boundary2.ports[1]) annotation (Line(points={{-24,62},{-42,62}}, color={0,127,255}));
  connect(boundary3.ports[1], turbine.outlet)
    annotation (Line(points={{42,61},{36,61},{36,61.2},{22.8,61.2}}, color={0,127,255}));
  connect(sensor_TubeOut2.port_a,Tube_Downstream2. ports[1]) annotation (Line(points={{-50,15},{-58,15}}, color={0,127,255}));
  connect(sensor_TubeOut2.port_b, HighTempRecuperator.port_a1)
    annotation (Line(points={{-30,15},{-12,15},{-12,4},{-6,4}}, color={0,127,255}));
  connect(sensor_TubeIn2.port_b,Tube_Feed2. ports[1]) annotation (Line(points={{56,15},{68,15}}, color={0,127,255}));
  connect(sensor_TubeIn2.port_a, HighTempRecuperator.port_b1)
    annotation (Line(points={{36,15},{34,15},{34,4},{14,4}}, color={0,127,255}));
  connect(Shell_Feed2.ports[1],sensor_ShellIn2. port_a) annotation (Line(points={{-60,-23},{-54,-23}},
                                                                                                     color={0,127,255}));
  connect(sensor_ShellIn2.port_b, HighTempRecuperator.port_b2)
    annotation (Line(points={{-34,-23},{-12,-23},{-12,-4},{-6,-4}}, color={0,127,255}));
  connect(Shell_Downstream2.ports[1],sensor_ShellOut2. port_b) annotation (Line(points={{62,-18},{54,-18}},
                                                                                                          color={0,127,255}));
  connect(sensor_ShellOut2.port_a, HighTempRecuperator.port_a2)
    annotation (Line(points={{34,-18},{20,-18},{20,-4},{14,-4}}, color={0,127,255}));
  connect(sensor_TubeOut1.port_a,Tube_Downstream1. ports[1]) annotation (Line(points={{62,-91},{74,-91}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b,Tube_Feed1. ports[1]) annotation (Line(points={{-32,-93},{-46,-93}},
                                                                                                 color={0,127,255}));
  connect(Shell_Feed1.ports[1],sensor_ShellIn1. port_a) annotation (Line(points={{74,-61},{60,-61}}, color={0,127,255}));
  connect(Shell_Downstream1.ports[1],sensor_ShellOut1. port_b) annotation (Line(points={{-46,-60},{-32,-60}},
                                                                                                          color={0,127,255}));
  connect(sensor_TubeOut1.port_b, LowTempRecuperator.port_a2)
    annotation (Line(points={{42,-91},{24,-91},{24,-78},{18,-78}}, color={0,127,255}));
  connect(sensor_ShellIn1.port_b, LowTempRecuperator.port_b1)
    annotation (Line(points={{40,-61},{24,-61},{24,-70},{18,-70}}, color={0,127,255}));
  connect(sensor_ShellOut1.port_a, LowTempRecuperator.port_a1)
    annotation (Line(points={{-12,-60},{-12,-70},{-2,-70}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_a, LowTempRecuperator.port_b2)
    annotation (Line(points={{-12,-93},{-12,-78},{-2,-78}}, color={0,127,255}));
end sCO2Cycle_1c_SimpleHXs_CoolProp_sCO2;
