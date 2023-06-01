within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1d_ConnectHXs
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
        origin={-218,160})));
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
        origin={-188,148})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    m_flow=2867,
    T=857.05,
    nPorts=1)
    annotation (Placement(transformation(extent={{-258,152},{-242,168}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-146,153},{-158,165}})));
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
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-350,100},{-330,120}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=643750,
    nPorts=1) annotation (Placement(transformation(extent={{-412,118},{-398,132}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-390,115},{-370,135}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{-262,118},{-276,132}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-308,115},{-288,135}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-414,80},{-400,94}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-394,77},{-374,97}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20080000,
    h=1077200,
    nPorts=1) annotation (Placement(transformation(extent={{-266,86},{-278,98}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-306,82},{-286,102}})));
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
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater2(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={46,28})));
  GasTurbine.Turbine.Turbine turbine1(
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
        origin={76,16})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,23},{102,35}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA HighTempRecuperator1(
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
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-68,32},{-48,52}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=643750,
    nPorts=1) annotation (Placement(transformation(extent={{-130,52},{-116,66}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-108,49},{-88,69}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{20,52},{6,66}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-26,49},{-6,69}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-132,14},{-118,28}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-112,11},{-92,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-4,18},{16,38}})));
equation
  connect(Heater1.port_b, turbine.inlet) annotation (Line(points={{-212,160},{-198.8,160},{-198.8,159.2}},
                                                                                                 color={0,127,255}));
  connect(Heater1.port_a, boundary2.ports[1]) annotation (Line(points={{-224,160},{-242,160}},
                                                                                           color={0,127,255}));
  connect(boundary3.ports[1], turbine.outlet)
    annotation (Line(points={{-158,159},{-164,159},{-164,159.2},{-177.2,159.2}},
                                                                     color={0,127,255}));
  connect(sensor_TubeOut2.port_a,Tube_Downstream2. ports[1]) annotation (Line(points={{-390,125},{-398,125}},
                                                                                                          color={0,127,255}));
  connect(sensor_TubeOut2.port_b, HighTempRecuperator.port_a1)
    annotation (Line(points={{-370,125},{-352,125},{-352,114},{-350,114}},
                                                                color={0,127,255}));
  connect(sensor_TubeIn2.port_b,Tube_Feed2. ports[1]) annotation (Line(points={{-288,125},{-276,125}},
                                                                                                 color={0,127,255}));
  connect(sensor_TubeIn2.port_a, HighTempRecuperator.port_b1)
    annotation (Line(points={{-308,125},{-306,125},{-306,114},{-330,114}},
                                                             color={0,127,255}));
  connect(Shell_Feed2.ports[1],sensor_ShellIn2. port_a) annotation (Line(points={{-400,87},{-394,87}},
                                                                                                     color={0,127,255}));
  connect(sensor_ShellIn2.port_b, HighTempRecuperator.port_b2)
    annotation (Line(points={{-374,87},{-352,87},{-352,106},{-350,106}},
                                                                    color={0,127,255}));
  connect(Shell_Downstream2.ports[1],sensor_ShellOut2. port_b) annotation (Line(points={{-278,92},{-286,92}},
                                                                                                          color={0,127,255}));
  connect(sensor_ShellOut2.port_a, HighTempRecuperator.port_a2)
    annotation (Line(points={{-306,92},{-320,92},{-320,106},{-330,106}},
                                                                 color={0,127,255}));
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
  connect(Heater2.port_b, turbine1.inlet) annotation (Line(points={{52,28},{65.2,28},{65.2,27.2}}, color={0,127,255}));
  connect(boundary4.ports[1], turbine1.outlet)
    annotation (Line(points={{102,29},{100,29},{100,27.2},{86.8,27.2}}, color={0,127,255}));
  connect(sensor_TubeOut3.port_a,Tube_Downstream3. ports[1]) annotation (Line(points={{-108,59},{-116,59}},
                                                                                                          color={0,127,255}));
  connect(sensor_TubeOut3.port_b, HighTempRecuperator1.port_a1)
    annotation (Line(points={{-88,59},{-70,59},{-70,46},{-68,46}}, color={0,127,255}));
  connect(sensor_TubeIn3.port_b,Tube_Feed3. ports[1]) annotation (Line(points={{-6,59},{6,59}},  color={0,127,255}));
  connect(sensor_TubeIn3.port_a, HighTempRecuperator1.port_b1)
    annotation (Line(points={{-26,59},{-24,59},{-24,46},{-48,46}}, color={0,127,255}));
  connect(Shell_Feed3.ports[1],sensor_ShellIn3. port_a) annotation (Line(points={{-118,21},{-112,21}},
                                                                                                     color={0,127,255}));
  connect(sensor_ShellIn3.port_b, HighTempRecuperator1.port_b2)
    annotation (Line(points={{-92,21},{-70,21},{-70,38},{-68,38}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_a, HighTempRecuperator1.port_a2)
    annotation (Line(points={{-4,28},{-42,28},{-42,38},{-48,38}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_b, Heater2.port_a) annotation (Line(points={{16,28},{40,28}}, color={0,127,255}));
end sCO2Cycle_1d_ConnectHXs;
