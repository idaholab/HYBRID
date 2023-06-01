within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1d_ConnectHXs_v2
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{76,32},{96,52}})));
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
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{0,-74},{-20,-54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{70,-88},{56,-74}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,-91},{24,-71}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-78,-88},{-64,-74}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,-91},{-50,-71}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{42,-61},{22,-41}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-76,-54},{-64,-42}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,-58},{-50,-38}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater2(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={54,-4})));
  GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_out=8471000,
    Tstart_in=1023.15,
    Tstart_out=908.05,
    eta0=0.9,
    PR0=2.3126,
    w0=2867)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={92,-28})));
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
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-6,-4},{-26,16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{10,11},{30,31}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-86,-16},{-72,-2}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-60,-19},{-40,1}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{10,-14},{30,6}})));
equation
  connect(sensor_TubeOut1.port_a,Tube_Downstream1. ports[1]) annotation (Line(points={{44,-81},{56,-81}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b,Tube_Feed1. ports[1]) annotation (Line(points={{-50,-81},{-54,-81},{-54,-82},{-58,-82},{-58,
          -81},{-64,-81}},                                                                       color={0,127,255}));
  connect(Shell_Downstream1.ports[1],sensor_ShellOut1. port_b) annotation (Line(points={{-64,-48},{-62,-48},{-62,-46},{-58,
          -46},{-58,-48},{-50,-48}},                                                                      color={0,127,255}));
  connect(sensor_ShellIn3.port_b, HighTempRecuperator1.port_a2)
    annotation (Line(points={{-40,-9},{-32,-9},{-32,2},{-26,2}},   color={0,127,255}));
  connect(sensor_ShellOut3.port_a, HighTempRecuperator1.port_b2)
    annotation (Line(points={{10,-4},{0,-4},{0,2},{-6,2}},     color={0,127,255}));
  connect(sensor_ShellIn1.port_b, LowTempRecuperator.port_a1)
    annotation (Line(points={{22,-51},{6,-51},{6,-60},{0,-60}}, color={0,127,255}));
  connect(LowTempRecuperator.port_b1, sensor_ShellOut1.port_a)
    annotation (Line(points={{-20,-60},{-26,-60},{-26,-54},{-24,-54},{-24,-48},{-30,-48}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_a, LowTempRecuperator.port_a2)
    annotation (Line(points={{-30,-81},{-24,-81},{-24,-68},{-20,-68}}, color={0,127,255}));
  connect(LowTempRecuperator.port_b2, sensor_TubeOut1.port_b)
    annotation (Line(points={{0,-68},{18,-68},{18,-81},{24,-81}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_a1, sensor_TubeIn3.port_a)
    annotation (Line(points={{-6,10},{2,10},{2,21},{10,21}}, color={0,127,255}));
  connect(turbine.inlet, Heater2.port_b)
    annotation (Line(points={{81.2,-16.8},{80,-16.8},{80,-4},{60,-4}},
                                                                     color={0,127,255}));
  connect(HighTempRecuperator1.port_b1, sensor_ShellIn1.port_a)
    annotation (Line(points={{-26,10},{-94,10},{-94,-30},{42,-30},{42,-51}}, color={0,127,255}));
  connect(turbine.outlet, sensor_TubeIn3.port_b)
    annotation (Line(points={{102.8,-16.8},{102.8,21},{30,21}},
                                                             color={0,127,255}));
  connect(sensor_ShellOut3.port_b, Heater2.port_a)
    annotation (Line(points={{30,-4},{36,-4},{36,-2},{40,-2},{40,-4},{48,-4}}, color={0,127,255}));
  connect(Shell_Feed3.ports[1], sensor_ShellIn3.port_a) annotation (Line(points={{-72,-9},{-60,-9}}, color={0,127,255}));
end sCO2Cycle_1d_ConnectHXs_v2;
