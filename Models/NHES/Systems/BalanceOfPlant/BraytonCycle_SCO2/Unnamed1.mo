within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model Unnamed1
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM
                     HX1(
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    NTU=10.6,
    K_tube=1,
    K_shell=1,
    V_Tube=0.193,
    V_Shell=2.272,
    p_start_tube=8471000,
    h_start_tube_inlet=1147600,
    h_start_tube_outlet=643750,
    p_start_shell=20100000,
    h_start_shell_inlet=576280,
    h_start_shell_outlet=1077200,
    Q_init=-1438e6,
    Cr_init=0.8506,
    m_start_tube=2867,
    m_start_shell=2867)
    annotation (Placement(transformation(extent={{-6,26},{20,50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{74,46},{60,60}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-42,43},{-22,63}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,43},{48,63}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-44,15},{-24,35}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{32,14},{52,34}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{182,68},{202,88}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM
                     HX2(
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    NTU=4.255,
    K_tube=1,
    K_shell=1,
    V_Tube=0.193,
    V_Shell=2.272,
    p_start_tube=20100000,
    h_start_tube_inlet=361690,
    h_start_tube_outlet=576130,
    p_start_shell=8431000,
    h_start_shell_inlet=643750,
    h_start_shell_outlet=515350,
    Q_init=370e6,
    Cr_init=0.7114,
    m_start_tube=1783,
    m_start_shell=2867)
    annotation (Placement(transformation(extent={{16,-60},{-10,-36}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-78,-66},{-66,-54}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{54,-43},{74,-23}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-46,-45},{-26,-25}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{52,-71},{32,-51}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,-70},{-50,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater1(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={88,24})));
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
        origin={118,12})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{156,17},{144,29}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=600e6)
    annotation (Placement(transformation(extent={{54,-8},{74,12}})));
  GasTurbine.Compressor.Compressor      Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-182,-58},{-156,-36}})));
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{24,-156},{50,-134}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=8431000,
    V=1)
    annotation (Placement(transformation(extent={{-102,-145},{-88,-131}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-124,-148},{-144,-128}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-74,-148},{-54,-128}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed5(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-122,-106},{-108,-92}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={145,-99})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8431000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.001),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-242,-132})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
    annotation (Placement(transformation(extent={{-296,-134},{-276,-114}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream5(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-188,-163},{-174,-149}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-262,-196},{-248,-182}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed4(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-126,-64},{-112,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20130000,
    h=361690,
    nPorts=1) annotation (Placement(transformation(extent={{-122,-44},{-136,-30}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=8431000,
    V=1)
    annotation (Placement(transformation(extent={{-222,-45},{-208,-31}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=100)
    annotation (Placement(transformation(extent={{-194,-18},{-214,2}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20130000,
    T=309.15,
    nPorts=1) annotation (Placement(transformation(extent={{-162,-14},{-176,0}})));
equation
  connect(HX1.Tube_out,sensor_TubeOut1. port_b)
    annotation (Line(points={{-6,42.8},{-16,42.8},{-16,53},{-22,53}}, color={0,127,255}));
  connect(sensor_ShellIn1.port_b,HX1. Shell_in)
    annotation (Line(points={{-24,25},{-16,25},{-16,35.6},{-6,35.6}}, color={0,127,255}));
  connect(HX1.Tube_in,sensor_TubeIn1. port_a)
    annotation (Line(points={{20,42.8},{24,42.8},{24,53},{28,53}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b,Tube_Feed1. ports[1]) annotation (Line(points={{48,53},{60,53}}, color={0,127,255}));
  connect(sensor_ShellOut1.port_a,HX1. Shell_out)
    annotation (Line(points={{32,24},{24,24},{24,35.6},{20,35.6}}, color={0,127,255}));
  connect(Heater1.port_b,turbine. inlet) annotation (Line(points={{94,24},{107.2,24},{107.2,23.2}},
                                                                                                 color={0,127,255}));
  connect(boundary3.ports[1],turbine. outlet)
    annotation (Line(points={{144,23},{142,23},{142,23.2},{128.8,23.2}},
                                                                     color={0,127,255}));
  connect(sensor_ShellOut1.port_b, Heater1.port_a) annotation (Line(points={{52,24},{82,24}}, color={0,127,255}));
  connect(fixedHeatFlow.port, Heater1.heatPort) annotation (Line(points={{74,2},{88,2},{88,18}}, color={191,0,0}));
  connect(sensor_TubeIn2.port_b, HX2.Tube_in)
    annotation (Line(points={{-26,-35},{-16,-35},{-16,-43.2},{-10,-43.2}}, color={0,127,255}));
  connect(HX2.Tube_out, sensor_TubeOut2.port_a)
    annotation (Line(points={{16,-43.2},{48,-43.2},{48,-33},{54,-33}}, color={0,127,255}));
  connect(sensor_ShellOut2.port_a, HX2.Shell_out)
    annotation (Line(points={{-30,-60},{-14,-60},{-14,-50.4},{-10,-50.4}}, color={0,127,255}));
  connect(sensor_ShellOut2.port_b, Shell_Downstream2.ports[1])
    annotation (Line(points={{-50,-60},{-66,-60}}, color={0,127,255}));
  connect(sensor_ShellIn2.port_b, HX2.Shell_in)
    annotation (Line(points={{32,-61},{20,-61},{20,-50.4},{16,-50.4}}, color={0,127,255}));
  connect(sensor_TubeOut1.port_a, sensor_ShellIn2.port_a)
    annotation (Line(points={{-42,53},{-82,53},{-82,-74},{56,-74},{56,-61},{52,-61}}, color={0,127,255}));
  connect(Tube_Feed5.ports[1],Split. port_3) annotation (Line(points={{-108,-99},{-95,-99},{-95,-131}},
                                                                                                      color={0,127,255}));
  connect(Split.port_1,resistance1. port_a) annotation (Line(points={{-102,-138},{-127,-138}},
                                                                                             color={0,127,255}));
  connect(Split.port_2,resistance. port_a) annotation (Line(points={{-88,-138},{-71,-138}}, color={0,127,255}));
  connect(resistance.port_b, Comp1.inlet)
    annotation (Line(points={{-57,-138},{-57,-120},{29.2,-120},{29.2,-136.2}}, color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2)
    annotation (Line(points={{44.8,-136.2},{44.8,-134},{176,-134},{176,-99},{152,-99}}, color={0,127,255}));
  connect(sensor_TubeOut2.port_b, Merge.port_1)
    annotation (Line(points={{74,-33},{118,-33},{118,-99},{138,-99}}, color={0,127,255}));
  connect(Merge.port_3, sensor_ShellIn1.port_a)
    annotation (Line(points={{145,-92},{116,-92},{116,-12},{-48,-12},{-48,25},{-44,25}}, color={0,127,255}));
  connect(Cooler.heatPort, fixedHeatFlow1.port)
    annotation (Line(points={{-248,-132},{-268,-132},{-268,-124},{-276,-124}}, color={191,0,0}));
  connect(resistance1.port_b, Tube_Downstream5.ports[1])
    annotation (Line(points={{-141,-138},{-154,-138},{-154,-156},{-174,-156}}, color={0,127,255}));
  connect(Tube_Feed2.ports[1], Cooler.port_a)
    annotation (Line(points={{-248,-189},{-240,-189},{-240,-138},{-242,-138}}, color={0,127,255}));
  connect(Tube_Feed4.ports[1], sensor_TubeIn2.port_a)
    annotation (Line(points={{-112,-57},{-80,-57},{-80,-35},{-46,-35}}, color={0,127,255}));
  connect(Tube_Downstream2.ports[1], Comp2.outlet)
    annotation (Line(points={{-136,-37},{-136,-120},{-161.2,-120},{-161.2,-38.2}}, color={0,127,255}));
  connect(Cooler.port_b, Split1.port_1)
    annotation (Line(points={{-242,-126},{-256,-126},{-256,-102},{-240,-102},{-240,-38.2},{-222,-38}}, color={0,127,255}));
  connect(Split1.port_2, Comp2.inlet)
    annotation (Line(points={{-208,-38},{-192.4,-38},{-192.4,-38.2},{-176.8,-38.2}}, color={0,127,255}));
  connect(resistance2.port_b, Split1.port_3)
    annotation (Line(points={{-211,-8},{-216,-8},{-216,-31},{-215,-31}}, color={0,127,255}));
  connect(resistance2.port_a, Tube_Downstream1.ports[1])
    annotation (Line(points={{-197,-8},{-176,-8},{-176,-7}}, color={0,127,255}));
end Unnamed1;
