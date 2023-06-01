within NHES.Systems.BalanceOfPlant.NewSCO2Mods;
model New_v6
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                     HX1(
    NTU=10.6,
    K_tube=0.1,
    K_shell=0.1,
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=0.1,
    V_Shell=0.1,
    p_start_tube=Turbine.pstart_out,
    h_start_tube_inlet=1147600,
    h_start_tube_outlet=643750,
    p_start_shell=Comp2.pstart_out,
    h_start_shell_inlet=576280,
    h_start_shell_outlet=1077200,
    dp_init_tube=100000,
    dp_init_shell=100000,
    Q_init=-1438e6,
    Cr_init=0.8506,
    m_start_tube=Turbine.w0,
    m_start_shell=Turbine.w0)
    annotation (Placement(transformation(extent={{-14,64},{12,88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                     HX2(
    NTU=1.255,
    K_tube=0.1,
    K_shell=0.4,
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=0.1,
    V_Shell=0.1,
    p_start_tube=Comp2.pstart_out,
    h_start_tube_inlet=361690,
    h_start_tube_outlet=576280,
    p_start_shell=Turbine.pstart_out,
    h_start_shell_inlet=643750,
    h_start_shell_outlet=515350,
    dp_init_tube=100000,
    dp_init_shell=100000,
    Q_init=370e6,
    Cr_init=0.7114,
    m_start_tube=Comp2.w0,
    m_start_shell=Turbine.w0)
    annotation (Placement(transformation(extent={{-8,-6},{18,18}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{56,11},{36,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
  GasTurbine.Turbine.Turbine_v2 Turbine(
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
        origin={172,58})));
  GasTurbine.Compressor.Compressor_v2   Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-192,7},{-166,29}})));
  GasTurbine.Compressor.Compressor_v2   Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{168,-111},{194,-89}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{142,-98},{156,-84}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=Comp2.pstart_in,
    T_start=Comp2.Tstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-208,-50})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-258,-50})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=50*0.378250591016547)
    annotation (Placement(transformation(extent={{8,-96},{-12,-76}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{24,-93},{38,-79}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=50*1 - resistance1.R)
    annotation (Placement(transformation(extent={{58,-96},{78,-76}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{106,-93},{92,-79}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{160,-10},{174,4}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
    p_start=20080000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={142,68})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={142,102})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
    annotation (Placement(transformation(extent={{98,54},{118,74}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC3(
    redeclare package Medium = Medium,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-121,-148})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium = Medium, R=1e6)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-121,-122})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split1(
    redeclare package Medium = Medium,
    p_start=8431000,
    T_start=372.25,
    V=0.01)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-121,-98})));
equation
  connect(Comp1.inlet, Comp2In.ports[1])
    annotation (Line(points={{173.2,-91.2},{164,-91.2},{164,-91},{156,-91}}, color={0,127,255}));
  connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-248,-50},{-214,-50}}, color={191,0,0}));
  connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
  connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
  connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
  connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
  connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
    annotation (Line(points={{182.8,69.2},{196,69.2},{196,91},{52,91}}, color={0,127,255}));
  connect(HeaterResistance.port_b, Heater.port_a)
    annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
    annotation (Line(points={{44,62},{94,62},{94,64},{101,64}}, color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
    annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, Split.port_3)
    annotation (Line(points={{48,-8},{52,-8},{52,-74},{31,-74},{31,-79}}, color={0,127,255}));
  connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-186.8,26.8},{-208,26.8},{-208,-44}}, color={0,127,255}));
  connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
    annotation (Line(points={{167,4},{118,4},{118,46},{-70,46},{-70,63},{-52,63}}, color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
    annotation (Line(points={{-46,21},{-50,21},{-50,36},{116,36},{116,-3},{160,-3}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_a, Comp2.outlet)
    annotation (Line(points={{56,21},{60,21},{60,38},{-120,38},{-120,26.8},{-171.2,26.8}}, color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2)
    annotation (Line(points={{188.8,-91.2},{200,-91.2},{200,-3},{174,-3}}, color={0,127,255}));
  connect(Cooler.port_a, Split1.port_2)
    annotation (Line(points={{-208,-56},{-170,-56},{-170,-98},{-128,-98}}, color={0,127,255}));
  connect(Split1.port_1, resistance1.port_b)
    annotation (Line(points={{-114,-98},{-18,-98},{-18,-86},{-9,-86}}, color={0,127,255}));
  connect(Split1.port_3, resistance2.port_a)
    annotation (Line(points={{-121,-105},{-121,-110.5},{-121,-110.5},{-121,-115}}, color={0,127,255}));
  connect(resistance2.port_b, SplitToC3.ports[1]) annotation (Line(points={{-121,-129},{-121,-141}}, color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_a, HX1.Tube_in)
    annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
  connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
    annotation (Line(points={{-32,63},{-18,63},{-18,73.6},{-14,73.6}}, color={0,127,255}));
  connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
    annotation (Line(points={{12,73.6},{18,73.6},{18,62},{24,62}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
    annotation (Line(points={{36,21},{22,21},{22,10.8},{18,10.8}}, color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_a, HX2.Tube_out)
    annotation (Line(points={{-26,21},{-12,21},{-12,10.8},{-8,10.8}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
    annotation (Line(points={{-28,-7},{-14,-7},{-14,3.6},{-8,3.6}}, color={0,127,255}));
  connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
    annotation (Line(points={{18,3.6},{22,3.6},{22,-8},{28,-8}}, color={0,127,255}));
end New_v6;
