within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1f_Combine2
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{-150,90},{-130,110}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA LowTempRecuperator(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    p_start_1=8451000,
    p_start_2=20100000,
    T_start_1=478.15,
    T_start_2=347.8,
    m_flow_start_1=2867,
    m_flow_start_2=1783,
    R_1=1,
    R_2=1,
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{-8,-18},{-28,2}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{36,-35},{16,-15}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-38,-37},{-58,-17}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{34,-5},{14,15}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-46,-4},{-66,16}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={52,94})));
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
        origin={84,70})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{134,89},{122,101}})));
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
    Q_flow0=1438e6) annotation (Placement(transformation(extent={{-8,100},{-28,120}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{58,112},{44,126}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{12,109},{32,129}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-62,77},{-42,97}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{12,84},{32,104}})));
  GasTurbine.Compressor.Compressor      Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-158,-47},{-132,-25}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{188,-16},{174,-2}})));
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{138,-38},{112,-16}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-108,-91},{-94,-77}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-122,-94},{-142,-74}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-78,-94},{-58,-74}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-30,-90},{-44,-76}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={61,15})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8411000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=-304.8e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-186,-42})));
equation
  connect(boundary4.ports[1], turbine.outlet) annotation (Line(points={{122,95},{94.8,95},{94.8,81.2}}, color={0,127,255}));
  connect(sensor_TubeIn3.port_b,Tube_Feed3. ports[1]) annotation (Line(points={{32,119},{44,119}},
                                                                                                 color={0,127,255}));
  connect(sensor_ShellOut3.port_b, Heater.port_a) annotation (Line(points={{32,94},{46,94}}, color={0,127,255}));
  connect(sensor_ShellIn3.port_b, HighTempRecuperator1.port_a2)
    annotation (Line(points={{-42,87},{-34,87},{-34,106},{-28,106}},
                                                                   color={0,127,255}));
  connect(sensor_ShellOut3.port_a, HighTempRecuperator1.port_b2)
    annotation (Line(points={{12,94},{2,94},{2,106},{-8,106}}, color={0,127,255}));
  connect(sensor_ShellIn1.port_b, LowTempRecuperator.port_a1)
    annotation (Line(points={{14,5},{-2,5},{-2,-4},{-8,-4}},    color={0,127,255}));
  connect(LowTempRecuperator.port_b1, sensor_ShellOut1.port_a)
    annotation (Line(points={{-28,-4},{-34,-4},{-34,6},{-46,6}},                           color={0,127,255}));
  connect(sensor_TubeIn1.port_a, LowTempRecuperator.port_a2)
    annotation (Line(points={{-38,-27},{-32,-27},{-32,-12},{-28,-12}}, color={0,127,255}));
  connect(LowTempRecuperator.port_b2, sensor_TubeOut1.port_b)
    annotation (Line(points={{-8,-12},{10,-12},{10,-25},{16,-25}},color={0,127,255}));
  connect(HighTempRecuperator1.port_a1, sensor_TubeIn3.port_a)
    annotation (Line(points={{-8,114},{0,114},{0,119},{12,119}},
                                                             color={0,127,255}));
  connect(turbine.inlet, Heater.port_b) annotation (Line(points={{73.2,81.2},{72,81.2},{72,94},{58,94}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_b1, sensor_ShellIn1.port_a)
    annotation (Line(points={{-28,114},{-90,114},{-90,26},{34,26},{34,5}},   color={0,127,255}));
  connect(Tube_Feed4.ports[1], Comp1.inlet)
    annotation (Line(points={{174,-9},{132.8,-9},{132.8,-18.2}},   color={0,127,255}));
  connect(Split.port_1, resistance1.port_a) annotation (Line(points={{-108,-84},{-125,-84}},
                                                                                           color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{-94,-84},{-75,-84}}, color={0,127,255}));
  connect(resistance.port_b, Tube_Downstream4.ports[1])
    annotation (Line(points={{-61,-84},{-61,-83},{-44,-83}}, color={0,127,255}));
  connect(Merge.port_3, sensor_ShellIn3.port_a)
    annotation (Line(points={{61,22},{68,22},{68,72},{-62,72},{-62,87}}, color={0,127,255}));
  connect(sensor_TubeOut1.port_a, Merge.port_1)
    annotation (Line(points={{36,-25},{46,-25},{46,15},{54,15}}, color={0,127,255}));
  connect(sensor_ShellOut1.port_b, Split.port_3) annotation (Line(points={{-66,6},{-101,6},{-101,-77}}, color={0,127,255}));
  connect(resistance1.port_b, Cooler.port_a)
    annotation (Line(points={{-139,-84},{-202,-84},{-202,-42},{-192,-42}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet)
    annotation (Line(points={{-180,-42},{-168,-42},{-168,-27.2},{-152.8,-27.2}}, color={0,127,255}));
  connect(Comp2.outlet, sensor_TubeIn1.port_b)
    annotation (Line(points={{-137.2,-27.2},{-120,-27},{-58,-27}}, color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2)
    annotation (Line(points={{117.2,-18.2},{92.6,-18.2},{92.6,15},{68,15}}, color={0,127,255}));
end sCO2Cycle_1f_Combine2;
