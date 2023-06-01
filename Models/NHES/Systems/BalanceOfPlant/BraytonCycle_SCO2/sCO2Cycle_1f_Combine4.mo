within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1f_Combine4
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{82,104},{102,124}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA LowTempRecuperator(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    p_start_1=8451000,
    p_start_2=20130000,
    T_start_1=478.15,
    T_start_2=347.8,
    m_flow_start_1=2867,
    m_flow_start_2=1783,
    R_1=1,
    R_2=1,
    Q_flow0=370.1e6) annotation (Placement(transformation(extent={{-18,-16},{-38,4}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{6,-33},{26,-13}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-74,-35},{-54,-15}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{24,-3},{4,17}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-58,-2},{-78,18}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater2(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.1),
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
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,73},{8,93}})));
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
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1084) annotation (Placement(transformation(extent={{70,-110},{96,-88}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-97,-107},{-83,-93}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-148,-110},{-168,-90}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-52,-110},{-32,-90}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={55,-57})));
  GasTurbine.Compressor.Compressor      Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    allowFlowReversal=false,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-196,-44},{-170,-22}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8431000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=-304.8e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-224,-84})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{4,-107},{-10,-93}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{32,-91},{46,-77}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-116,-33},{-130,-19}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-130,-73},{-116,-59}})));
equation
  connect(sensor_ShellOut3.port_b, Heater2.port_a) annotation (Line(points={{28,58},{42,58}}, color={0,127,255}));
  connect(sensor_ShellIn3.port_b, HighTempRecuperator1.port_a2)
    annotation (Line(points={{-42,53},{-34,53},{-34,66},{-28,66}}, color={0,127,255}));
  connect(sensor_ShellOut3.port_a, HighTempRecuperator1.port_b2)
    annotation (Line(points={{8,58},{-2,58},{-2,66},{-8,66}},  color={0,127,255}));
  connect(sensor_ShellIn1.port_b, LowTempRecuperator.port_a1)
    annotation (Line(points={{4,7},{-12,7},{-12,-2},{-18,-2}},  color={0,127,255}));
  connect(LowTempRecuperator.port_b1, sensor_ShellOut1.port_a)
    annotation (Line(points={{-38,-2},{-52,-2},{-52,8},{-58,8}},                           color={0,127,255}));
  connect(turbine.inlet, Heater2.port_b)
    annotation (Line(points={{69.2,45.2},{68,45.2},{68,58},{54,58}}, color={0,127,255}));
  connect(HighTempRecuperator1.port_b1, sensor_ShellIn1.port_a)
    annotation (Line(points={{-28,74},{-96,74},{-96,20},{24,20},{24,7}},     color={0,127,255}));
  connect(Split.port_1, resistance1.port_a) annotation (Line(points={{-97,-100},{-151,-100}},color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{-83,-100},{-49,-100}}, color={0,127,255}));
  connect(sensor_ShellOut1.port_b, Split.port_3)
    annotation (Line(points={{-78,8},{-90,8},{-90,-93}},                     color={0,127,255}));
  connect(resistance1.port_b, Cooler.port_a)
    annotation (Line(points={{-165,-100},{-224,-100},{-224,-90}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-224,-78},{-224,-24.2},{-190.8,-24.2}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b, LowTempRecuperator.port_a2)
    annotation (Line(points={{-54,-25},{-44,-25},{-44,-10},{-38,-10}}, color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2) annotation (Line(points={{90.8,-90.2},{90.8,-57},{62,-57}}, color={0,127,255}));
  connect(Merge.port_3, sensor_ShellIn3.port_a)
    annotation (Line(points={{55,-50},{54,-50},{54,36},{-66,36},{-66,53},{-62,53}}, color={0,127,255}));
  connect(Tube_Downstream2.ports[1], resistance.port_b) annotation (Line(points={{-10,-100},{-35,-100}}, color={0,127,255}));
  connect(Comp1.inlet, Tube_Feed2.ports[1])
    annotation (Line(points={{75.2,-90.2},{74,-90.2},{74,-84},{46,-84}}, color={0,127,255}));
  connect(LowTempRecuperator.port_b2, sensor_TubeOut1.port_a)
    annotation (Line(points={{-18,-10},{0,-10},{0,-23},{6,-23}}, color={0,127,255}));
  connect(sensor_TubeOut1.port_b, Merge.port_1)
    annotation (Line(points={{26,-23},{42,-23},{42,-57},{48,-57}}, color={0,127,255}));
  connect(turbine.outlet, sensor_TubeIn3.port_a)
    annotation (Line(points={{90.8,45.2},{90.8,83},{28,83}}, color={0,127,255}));
  connect(sensor_TubeIn3.port_b, HighTempRecuperator1.port_a1)
    annotation (Line(points={{8,83},{0,83},{0,74},{-8,74}}, color={0,127,255}));
  connect(Tube_Downstream1.ports[1], Comp2.outlet)
    annotation (Line(points={{-130,-26},{-130,-24},{-175.2,-24},{-175.2,-24.2}}, color={0,127,255}));
  connect(Tube_Feed1.ports[1], sensor_TubeIn1.port_a)
    annotation (Line(points={{-116,-66},{-80,-66},{-80,-25},{-74,-25}}, color={0,127,255}));
end sCO2Cycle_1f_Combine4;
