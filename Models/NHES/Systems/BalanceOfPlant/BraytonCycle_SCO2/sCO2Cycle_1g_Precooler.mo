within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1g_Precooler
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
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
    nPorts=1) annotation (Placement(transformation(extent={{126,-74},{140,-60}})));
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{152,-92},{178,-70}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20130000,
    h=576280,
    nPorts=1) annotation (Placement(transformation(extent={{212,-74},{198,-60}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-132,-101},{-118,-87}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-146,-104},{-166,-84}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-104,-104},{-84,-84}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-54,-100},{-68,-86}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed6(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{144,8},{158,22}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={187,15})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed7(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    h=576280,
    nPorts=1) annotation (Placement(transformation(extent={{236,8},{222,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream6(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576280,
    nPorts=1) annotation (Placement(transformation(extent={{216,40},{202,54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream7(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=323220,
    nPorts=1) annotation (Placement(transformation(extent={{-180,-25},{-194,-11}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8431000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=-304.8e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-224,-38})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{76,76},{96,96}})));
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
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{0,-30},{-20,-10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{70,-44},{56,-30}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,-47},{24,-27}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-78,-44},{-64,-30}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,-47},{-50,-27}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{42,-17},{22,3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,-14},{-50,6}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater2(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={54,40})));
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
        origin={92,16})));
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
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-6,40},{-26,60}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{10,55},{30,75}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-86,28},{-72,42}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-60,25},{-40,45}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{10,30},{30,50}})));
equation
  connect(Tube_Feed2.ports[1], Comp2.inlet)
    annotation (Line(points={{-180,43},{-162.8,43},{-162.8,37.8}}, color={0,127,255}));
  connect(Tube_Downstream2.ports[1], Comp2.outlet)
    annotation (Line(points={{-122,43},{-147.2,43},{-147.2,37.8}}, color={0,127,255}));
  connect(Tube_Feed4.ports[1], Comp1.inlet)
    annotation (Line(points={{140,-67},{157.2,-67},{157.2,-72.2}}, color={0,127,255}));
  connect(Comp1.outlet, Tube_Downstream3.ports[1])
    annotation (Line(points={{172.8,-72.2},{172.8,-67},{198,-67}}, color={0,127,255}));
  connect(Split.port_1, resistance1.port_a) annotation (Line(points={{-132,-94},{-149,-94}},
                                                                                           color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{-118,-94},{-101,-94}},
                                                                                          color={0,127,255}));
  connect(resistance.port_b, Tube_Downstream4.ports[1])
    annotation (Line(points={{-87,-94},{-87,-93},{-68,-93}}, color={0,127,255}));
  connect(Tube_Feed6.ports[1], Merge.port_1) annotation (Line(points={{158,15},{180,15}}, color={0,127,255}));
  connect(Tube_Feed7.ports[1], Merge.port_2) annotation (Line(points={{222,15},{194,15}}, color={0,127,255}));
  connect(Merge.port_3, Tube_Downstream6.ports[1])
    annotation (Line(points={{187,22},{186,22},{186,47},{202,47}}, color={0,127,255}));
  connect(Cooler.port_b, Tube_Downstream7.ports[1]) annotation (Line(points={{-224,-32},{-224,-18},{-194,-18}},
                                                                                                color={0,127,255}));
  connect(sensor_TubeOut1.port_a,Tube_Downstream1. ports[1]) annotation (Line(points={{44,-37},{56,-37}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b,Tube_Feed1. ports[1]) annotation (Line(points={{-50,-37},{-54,-37},{-54,-38},{-58,-38},{-58,
          -37},{-64,-37}},                                                                       color={0,127,255}));
  connect(sensor_ShellIn3.port_b,HighTempRecuperator1. port_a2)
    annotation (Line(points={{-40,35},{-32,35},{-32,46},{-26,46}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_a,HighTempRecuperator1. port_b2)
    annotation (Line(points={{10,40},{0,40},{0,46},{-6,46}},   color={0,127,255}));
  connect(sensor_ShellIn1.port_b,LowTempRecuperator. port_a1)
    annotation (Line(points={{22,-7},{6,-7},{6,-16},{0,-16}},   color={0,127,255}));
  connect(LowTempRecuperator.port_b1,sensor_ShellOut1. port_a)
    annotation (Line(points={{-20,-16},{-26,-16},{-26,-10},{-24,-10},{-24,-4},{-30,-4}},   color={0,127,255}));
  connect(sensor_TubeIn1.port_a,LowTempRecuperator. port_a2)
    annotation (Line(points={{-30,-37},{-24,-37},{-24,-24},{-20,-24}}, color={0,127,255}));
  connect(LowTempRecuperator.port_b2,sensor_TubeOut1. port_b)
    annotation (Line(points={{0,-24},{18,-24},{18,-37},{24,-37}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_a1,sensor_TubeIn3. port_a)
    annotation (Line(points={{-6,54},{2,54},{2,65},{10,65}}, color={0,127,255}));
  connect(turbine.inlet,Heater2. port_b)
    annotation (Line(points={{81.2,27.2},{80,27.2},{80,40},{60,40}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_b1,sensor_ShellIn1. port_a)
    annotation (Line(points={{-26,54},{-94,54},{-94,14},{42,14},{42,-7}},    color={0,127,255}));
  connect(turbine.outlet,sensor_TubeIn3. port_b)
    annotation (Line(points={{102.8,27.2},{102.8,65},{30,65}},
                                                             color={0,127,255}));
  connect(sensor_ShellOut3.port_b, Heater2.port_a)
    annotation (Line(points={{30,40},{36,40},{36,42},{40,42},{40,40},{48,40}}, color={0,127,255}));
  connect(Shell_Feed3.ports[1], sensor_ShellIn3.port_a) annotation (Line(points={{-72,35},{-60,35}}, color={0,127,255}));
  connect(sensor_ShellOut1.port_b, Split.port_3)
    annotation (Line(points={{-50,-4},{-102,-4},{-102,-80},{-120,-80},{-120,-87},{-125,-87}}, color={0,127,255}));
  connect(resistance1.port_b, Cooler.port_a) annotation (Line(points={{-163,-94},{-224,-94},{-224,-44}}, color={0,127,255}));
end sCO2Cycle_1g_Precooler;
