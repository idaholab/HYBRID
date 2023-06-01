within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model Unnamed2
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM
                     HX1(
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    NTU=10.6,
    K_tube=1,
    K_shell=1,
    V_Tube=0.1,
    V_Shell=0.1,
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
    annotation (Placement(transformation(extent={{-14,64},{12,88}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2758,
    h=1164540,
    nPorts=1) annotation (Placement(transformation(extent={{66,84},{52,98}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-50,81},{-30,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{20,81},{40,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{174,106},{194,126}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM
                     HX2(
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    NTU=4.255,
    K_tube=1,
    K_shell=1,
    V_Tube=0.1,
    V_Shell=0.1,
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
    annotation (Placement(transformation(extent={{8,-22},{-18,2}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{46,-5},{66,15}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-54,-7},{-34,13}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,-33},{24,-13}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-38,-32},{-58,-12}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater1(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={80,62})));
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
        origin={110,50})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8471000,
    h=1147600,
    nPorts=1)
    annotation (Placement(transformation(extent={{148,55},{136,67}})));
  GasTurbine.Compressor.Compressor      Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20100000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{14,-96},{40,-74}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-108,-115},{-94,-101}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.392690355329949)
    annotation (Placement(transformation(extent={{-124,-118},{-144,-98}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-80,-118},{-60,-98}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Merge(
                                                 redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={139,-61})));
  GasTurbine.Compressor.Compressor      Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-152,-17},{-126,5}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8431000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    Q_gen=-304.8e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-204,-46})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1083.04,
    h=515350,
    nPorts=1) annotation (Placement(transformation(extent={{-18,-78},{-4,-64}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    h=515350,
    nPorts=1)
    annotation (Placement(transformation(extent={{-22,-125},{-34,-113}})));
equation
  connect(HX1.Tube_out,sensor_TubeOut1. port_b)
    annotation (Line(points={{-14,80.8},{-24,80.8},{-24,91},{-30,91}},color={0,127,255}));
  connect(sensor_ShellIn1.port_b,HX1. Shell_in)
    annotation (Line(points={{-32,63},{-24,63},{-24,73.6},{-14,73.6}},color={0,127,255}));
  connect(HX1.Tube_in,sensor_TubeIn1. port_a)
    annotation (Line(points={{12,80.8},{16,80.8},{16,91},{20,91}}, color={0,127,255}));
  connect(sensor_TubeIn1.port_b,Tube_Feed1. ports[1]) annotation (Line(points={{40,91},{52,91}}, color={0,127,255}));
  connect(sensor_ShellOut1.port_a,HX1. Shell_out)
    annotation (Line(points={{24,62},{16,62},{16,73.6},{12,73.6}}, color={0,127,255}));
  connect(Heater1.port_b,turbine. inlet) annotation (Line(points={{86,62},{99.2,62},{99.2,61.2}},color={0,127,255}));
  connect(boundary3.ports[1],turbine. outlet)
    annotation (Line(points={{136,61},{134,61},{134,61.2},{120.8,61.2}},
                                                                     color={0,127,255}));
  connect(sensor_ShellOut1.port_b, Heater1.port_a) annotation (Line(points={{44,62},{74,62}}, color={0,127,255}));
  connect(sensor_TubeIn2.port_b, HX2.Tube_in)
    annotation (Line(points={{-34,3},{-24,3},{-24,-5.2},{-18,-5.2}},       color={0,127,255}));
  connect(HX2.Tube_out, sensor_TubeOut2.port_a)
    annotation (Line(points={{8,-5.2},{40,-5.2},{40,5},{46,5}},        color={0,127,255}));
  connect(sensor_ShellOut2.port_a, HX2.Shell_out)
    annotation (Line(points={{-38,-22},{-22,-22},{-22,-12.4},{-18,-12.4}}, color={0,127,255}));
  connect(sensor_ShellIn2.port_b, HX2.Shell_in)
    annotation (Line(points={{24,-23},{12,-23},{12,-12.4},{8,-12.4}},  color={0,127,255}));
  connect(sensor_TubeOut1.port_a, sensor_ShellIn2.port_a)
    annotation (Line(points={{-50,91},{-90,91},{-90,-36},{48,-36},{48,-23},{44,-23}}, color={0,127,255}));
  connect(Split.port_1,resistance1. port_a) annotation (Line(points={{-108,-108},{-127,-108}},
                                                                                             color={0,127,255}));
  connect(Split.port_2,resistance. port_a) annotation (Line(points={{-94,-108},{-77,-108}}, color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2)
    annotation (Line(points={{34.8,-76.2},{34.8,-76},{166,-76},{166,-61},{146,-61}},    color={0,127,255}));
  connect(sensor_TubeOut2.port_b, Merge.port_1)
    annotation (Line(points={{66,5},{110,5},{110,-61},{132,-61}},     color={0,127,255}));
  connect(Merge.port_3, sensor_ShellIn1.port_a)
    annotation (Line(points={{139,-54},{94,-54},{94,26},{-70,26},{-70,63},{-52,63}},     color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet)
    annotation (Line(points={{-204,-40},{-204,2.8},{-146.8,2.8}},            color={0,127,255}));
  connect(resistance1.port_b, Cooler.port_a)
    annotation (Line(points={{-141,-108},{-204,-108},{-204,-52}}, color={0,127,255}));
  connect(sensor_ShellOut2.port_b, Split.port_3)
    annotation (Line(points={{-58,-22},{-66,-22},{-66,-40},{-101,-40},{-101,-101}}, color={0,127,255}));
  connect(sensor_TubeIn2.port_a, Comp2.outlet)
    annotation (Line(points={{-54,3},{-131.2,3},{-131.2,2.8}},       color={0,127,255}));
  connect(Tube_Feed2.ports[1], Comp1.inlet)
    annotation (Line(points={{-4,-71},{-4,-72},{19.2,-72},{19.2,-76.2}},       color={0,127,255}));
  connect(resistance.port_b, boundary1.ports[1])
    annotation (Line(points={{-63,-108},{-34,-108},{-34,-119}}, color={0,127,255}));
end Unnamed2;
