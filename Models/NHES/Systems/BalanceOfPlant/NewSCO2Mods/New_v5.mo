within NHES.Systems.BalanceOfPlant.NewSCO2Mods;
model New_v5
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
  TRANSFORM.HeatExchangers.Simple_HX
                     HX1(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    nV=3,
    V_1=0.01,
    V_2=0.01,
    UA=4.34178e7,
    p_a_start_1=Turbine.pstart_out,
    T_a_start_1=Turbine.Tstart_out,
    m_flow_start_1=Turbine.w0,
    p_a_start_2=Turbine.pstart_in,
    T_a_start_2=Comp1.Tstart_out,
    m_flow_start_2=Turbine.w0,
    R_1=0.001,
    R_2=0.001)
    annotation (Placement(transformation(extent={{12,64},{-14,88}})));
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
  TRANSFORM.HeatExchangers.Simple_HX
                     HX2(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    nV=3,
    V_1=0.01,
    V_2=0.01,
    UA=1.66712e7,
    p_a_start_1=HX2_TubeOut.p,
    T_a_start_1=Comp2.Tstart_out,
    m_flow_start_1=Comp2.w0,
    p_a_start_2=8451000,
    T_a_start_2=HX1.T_b_start_1,
    m_flow_start_2=Turbine.w0,
    R_1=0.001,
    R_2=0.001)
    annotation (Placement(transformation(extent={{18,-6},{-8,18}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{36,11},{56,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    T=458.05,
    nPorts=1) annotation (Placement(transformation(extent={{-74,15},{-62,27}})));
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
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{224,-97},{212,-85}})));
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
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    T=458.05,
    nPorts=1) annotation (Placement(transformation(extent={{114,-10},{128,4}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{222,-10},{208,4}})));
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
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-62,-107},{-48,-93}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=Comp2.w0,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-232,-94},{-218,-80}})));
equation
  connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
    annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
  connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
    annotation (Line(points={{-32,63},{-18,63},{-18,71.2},{-14,71.2}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
    annotation (Line(points={{24,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
    annotation (Line(points={{36,21},{22,21},{22,10.8},{18,10.8}}, color={0,127,255}));
  connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{-8,10.8},{-18,10.8},{-18,21},{-26,21}},  color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
    annotation (Line(points={{-28,-7},{-14,-7},{-14,1.2},{-8,1.2}},  color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
    annotation (Line(points={{28,-8},{22,-8},{22,1.2},{18,1.2}}, color={0,127,255}));
  connect(Comp1.inlet, Comp2In.ports[1])
    annotation (Line(points={{173.2,-91.2},{164,-91.2},{164,-91},{156,-91}}, color={0,127,255}));
  connect(Comp1.outlet, Comp2Out.ports[1])
    annotation (Line(points={{188.8,-91.2},{200,-91.2},{200,-91},{212,-91}}, color={0,127,255}));
  connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-248,-50},{-214,-50}}, color={191,0,0}));
  connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
  connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
  connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{128,-3},{160,-3}}, color={0,127,255}));
  connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{174,-3},{208,-3}}, color={0,127,255}));
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
  connect(SplitToC2.ports[1], resistance1.port_b)
    annotation (Line(points={{-48,-100},{-18,-100},{-18,-86},{-9,-86}}, color={0,127,255}));
  connect(CoolerIn.ports[1], Cooler.port_a)
    annotation (Line(points={{-218,-87},{-214,-87},{-214,-56},{-208,-56}}, color={0,127,255}));
  connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-186.8,26.8},{-208,26.8},{-208,-44}}, color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
    annotation (Line(points={{-171.2,26.8},{-78,26.8},{-78,34},{60,34},{60,21},{56,21}}, color={0,127,255}));
  connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
    annotation (Line(points={{167,4},{118,4},{118,46},{-70,46},{-70,63},{-52,63}}, color={0,127,255}));
end New_v5;
