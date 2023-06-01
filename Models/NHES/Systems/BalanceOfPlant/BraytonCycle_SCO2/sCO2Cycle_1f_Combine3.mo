within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1f_Combine3
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  GasTurbine.Compressor.Compressor      Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-182,-72},{-156,-50}})));
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1084) annotation (Placement(transformation(extent={{154,-116},{180,-94}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-132,-101},{-118,-87}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-146,-104},{-166,-84}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-104,-104},{-84,-84}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed6(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{104,-44},{118,-30}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={147,-37})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8431000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=-304.8e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-222,-72})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{76,76},{96,96}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA LowTempRecuperator(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    p_start_1=8400000,
    p_start_2=20100000,
    T_start_1=478.15,
    T_start_2=347.8,
    m_flow_start_1=2867,
    m_flow_start_2=1783,
    UA(start=1.4e7),
    R_1=1,
    R_2=1,
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{-32,-50},{-52,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=576130,
    nPorts=1) annotation (Placement(transformation(extent={{58,-64},{44,-50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{0,-67},{20,-47}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-90,-67},{-70,-47}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{10,-37},{-10,-17}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-62,-34},{-82,-14}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater2(
    p_start=20000000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={62,40})));
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
    UA(start=3.7e7),
    R_1=1,
    R_2=1,
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-6,40},{-26,60}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{10,55},{30,75}})));
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
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=20100000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.0001))
    annotation (Placement(transformation(extent={{-130,-62},{-110,-42}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=20100000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.0001))
    annotation (Placement(transformation(extent={{-8,-104},{12,-84}})));
equation
  connect(Split.port_1, resistance1.port_a) annotation (Line(points={{-132,-94},{-149,-94}},
                                                                                           color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{-118,-94},{-101,-94}},
                                                                                          color={0,127,255}));
  connect(Tube_Feed6.ports[1], Merge.port_1) annotation (Line(points={{118,-37},{140,-37}},
                                                                                          color={0,127,255}));
  connect(sensor_ShellIn3.port_b,HighTempRecuperator1. port_a2)
    annotation (Line(points={{-40,35},{-32,35},{-32,46},{-26,46}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_a,HighTempRecuperator1. port_b2)
    annotation (Line(points={{10,40},{0,40},{0,46},{-6,46}},   color={0,127,255}));
  connect(sensor_ShellIn1.port_b,LowTempRecuperator. port_a1)
    annotation (Line(points={{-10,-27},{-10,-36},{-32,-36}},    color={0,127,255}));
  connect(LowTempRecuperator.port_b1,sensor_ShellOut1. port_a)
    annotation (Line(points={{-52,-36},{-52,-24},{-62,-24}},                               color={0,127,255}));
  connect(HighTempRecuperator1.port_a1,sensor_TubeIn3. port_a)
    annotation (Line(points={{-6,54},{2,54},{2,65},{10,65}}, color={0,127,255}));
  connect(turbine.inlet,Heater2. port_b)
    annotation (Line(points={{81.2,27.2},{80,27.2},{80,40},{68,40}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_b1,sensor_ShellIn1. port_a)
    annotation (Line(points={{-26,54},{-94,54},{-94,-12},{10,-12},{10,-27}}, color={0,127,255}));
  connect(turbine.outlet,sensor_TubeIn3. port_b)
    annotation (Line(points={{102.8,27.2},{102.8,65},{30,65}},
                                                             color={0,127,255}));
  connect(sensor_ShellOut1.port_b, Split.port_3)
    annotation (Line(points={{-82,-24},{-102,-24},{-102,-80},{-120,-80},{-120,-87},{-125,-87}},
                                                                                              color={0,127,255}));
  connect(resistance1.port_b, Cooler.port_a) annotation (Line(points={{-163,-94},{-222,-94},{-222,-78}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-222,-66},{-222,-52.2},{-176.8,-52.2}}, color={0,127,255}));
  connect(Comp2.outlet, volume.port_a)
    annotation (Line(points={{-161.2,-52.2},{-138.6,-52.2},{-138.6,-52},{-126,-52}}, color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2)
    annotation (Line(points={{174.8,-96.2},{174.8,-36},{154,-36},{154,-37}}, color={0,127,255}));
  connect(sensor_ShellIn3.port_a, Merge.port_3)
    annotation (Line(points={{-60,35},{-64,35},{-64,-10},{118,-10},{118,-30},{147,-30}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_b, Heater2.port_a) annotation (Line(points={{30,40},{56,40}}, color={0,127,255}));
  connect(volume.port_b, sensor_TubeIn1.port_a)
    annotation (Line(points={{-114,-52},{-96,-52},{-96,-57},{-90,-57}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b, LowTempRecuperator.port_a2)
    annotation (Line(points={{-70,-57},{-56,-57},{-56,-44},{-52,-44}}, color={0,127,255}));
  connect(LowTempRecuperator.port_b2, sensor_TubeOut1.port_a)
    annotation (Line(points={{-32,-44},{-16,-44},{-16,-57},{0,-57}}, color={0,127,255}));
  connect(Tube_Downstream1.ports[1], sensor_TubeOut1.port_b)
    annotation (Line(points={{44,-57},{20,-57}}, color={0,127,255}));
  connect(resistance.port_b, volume1.port_a) annotation (Line(points={{-87,-94},{-4,-94}},             color={0,127,255}));
  connect(volume1.port_b, Comp1.inlet)
    annotation (Line(points={{8,-94},{8,-96.2},{159.2,-96.2}},                  color={0,127,255}));
end sCO2Cycle_1f_Combine3;
