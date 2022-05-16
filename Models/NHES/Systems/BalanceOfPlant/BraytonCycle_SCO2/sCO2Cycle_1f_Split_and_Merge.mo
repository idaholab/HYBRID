within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1f_Split_and_Merge
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{82,104},{102,124}})));
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
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{-2,-14},{-22,6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{68,-28},{54,-14}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{42,-31},{22,-11}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-30},{-66,-16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-32,-33},{-52,-13}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{40,-1},{20,19}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-78,4},{-66,16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-32,0},{-52,20}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater2(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={48,58})));
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
        origin={80,34})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{130,53},{118,65}})));
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
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-8,60},{-28,80}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{54,76},{40,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{8,73},{28,93}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-88,46},{-74,60}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-62,43},{-42,63}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{8,48},{28,68}})));
  GasTurbine.Compressor.Compressor      Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-168,18},{-142,40}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=324530,
    nPorts=1) annotation (Placement(transformation(extent={{-194,36},{-180,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20130000,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-108,36},{-122,50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-194,-10},{-180,4}})));
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-168,-28},{-142,-6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20130000,
    h=576280,
    nPorts=1) annotation (Placement(transformation(extent={{-108,-10},{-122,4}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-80,-107},{-66,-93}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp,                                                                 R=1 - resistance.R)
    annotation (Placement(transformation(extent={{-94,-110},{-114,-90}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp,                                                                R=
        0.378250591016547)
    annotation (Placement(transformation(extent={{-52,-110},{-32,-90}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed5(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-100,-68},{-86,-54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-2,-106},{-16,-92}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream5(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-154,-107},{-140,-93}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed6(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{52,-108},{66,-94}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={95,-101})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed7(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    h=576280,
    nPorts=1) annotation (Placement(transformation(extent={{144,-108},{130,-94}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream6(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576280,
    nPorts=1) annotation (Placement(transformation(extent={{124,-76},{110,-62}})));
equation
  connect(sensor_TubeOut1.port_a,Tube_Downstream1. ports[1]) annotation (Line(points={{42,-21},{54,-21}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b,Tube_Feed1. ports[1]) annotation (Line(points={{-52,-23},{-66,-23}},
                                                                                                 color={0,127,255}));
  connect(Shell_Downstream1.ports[1],sensor_ShellOut1. port_b) annotation (Line(points={{-66,10},{-52,10}},
                                                                                                          color={0,127,255}));
  connect(boundary4.ports[1], turbine.outlet) annotation (Line(points={{118,59},{90.8,59},{90.8,45.2}}, color={0,127,255}));
  connect(sensor_TubeIn3.port_b,Tube_Feed3. ports[1]) annotation (Line(points={{28,83},{40,83}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_b, Heater2.port_a) annotation (Line(points={{28,58},{42,58}}, color={0,127,255}));
  connect(sensor_ShellIn3.port_b, HighTempRecuperator1.port_a2)
    annotation (Line(points={{-42,53},{-34,53},{-34,66},{-28,66}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_a, HighTempRecuperator1.port_b2)
    annotation (Line(points={{8,58},{-2,58},{-2,66},{-8,66}},  color={0,127,255}));
  connect(sensor_ShellIn3.port_a, Shell_Feed3.ports[1]) annotation (Line(points={{-62,53},{-74,53}}, color={0,127,255}));
  connect(sensor_ShellIn1.port_b, LowTempRecuperator.port_a1)
    annotation (Line(points={{20,9},{4,9},{4,0},{-2,0}},        color={0,127,255}));
  connect(LowTempRecuperator.port_b1, sensor_ShellOut1.port_a)
    annotation (Line(points={{-22,0},{-28,0},{-28,6},{-26,6},{-26,10},{-32,10}},           color={0,127,255}));
  connect(sensor_TubeIn1.port_a, LowTempRecuperator.port_a2)
    annotation (Line(points={{-32,-23},{-26,-23},{-26,-8},{-22,-8}},   color={0,127,255}));
  connect(LowTempRecuperator.port_b2, sensor_TubeOut1.port_b)
    annotation (Line(points={{-2,-8},{16,-8},{16,-21},{22,-21}},  color={0,127,255}));
  connect(HighTempRecuperator1.port_a1, sensor_TubeIn3.port_a)
    annotation (Line(points={{-8,74},{0,74},{0,83},{8,83}},  color={0,127,255}));
  connect(turbine.inlet, Heater2.port_b)
    annotation (Line(points={{69.2,45.2},{68,45.2},{68,58},{54,58}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_b1, sensor_ShellIn1.port_a)
    annotation (Line(points={{-28,74},{-96,74},{-96,30},{40,30},{40,9}},     color={0,127,255}));
  connect(Tube_Feed2.ports[1], Comp2.inlet)
    annotation (Line(points={{-180,43},{-162.8,43},{-162.8,37.8}}, color={0,127,255}));
  connect(Tube_Downstream2.ports[1], Comp2.outlet)
    annotation (Line(points={{-122,43},{-147.2,43},{-147.2,37.8}}, color={0,127,255}));
  connect(Tube_Feed4.ports[1], Comp1.inlet)
    annotation (Line(points={{-180,-3},{-162.8,-3},{-162.8,-8.2}}, color={0,127,255}));
  connect(Comp1.outlet, Tube_Downstream3.ports[1])
    annotation (Line(points={{-147.2,-8.2},{-147.2,-3},{-122,-3}}, color={0,127,255}));
  connect(Tube_Feed5.ports[1], Split.port_3) annotation (Line(points={{-86,-61},{-73,-61},{-73,-93}}, color={0,127,255}));
  connect(Split.port_1, resistance1.port_a) annotation (Line(points={{-80,-100},{-97,-100}}, color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{-66,-100},{-49,-100}}, color={0,127,255}));
  connect(resistance.port_b, Tube_Downstream4.ports[1])
    annotation (Line(points={{-35,-100},{-35,-99},{-16,-99}}, color={0,127,255}));
  connect(Tube_Downstream5.ports[1], resistance1.port_b)
    annotation (Line(points={{-140,-100},{-111,-100}}, color={0,127,255}));
  connect(Tube_Feed6.ports[1], Merge.port_1) annotation (Line(points={{66,-101},{88,-101}}, color={0,127,255}));
  connect(Tube_Feed7.ports[1], Merge.port_2) annotation (Line(points={{130,-101},{102,-101}}, color={0,127,255}));
  connect(Merge.port_3, Tube_Downstream6.ports[1])
    annotation (Line(points={{95,-94},{94,-94},{94,-69},{110,-69}}, color={0,127,255}));
end sCO2Cycle_1f_Split_and_Merge;
