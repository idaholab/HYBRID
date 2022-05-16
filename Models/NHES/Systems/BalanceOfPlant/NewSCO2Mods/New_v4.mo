within NHES.Systems.BalanceOfPlant.NewSCO2Mods;
model New_v4
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
  TRANSFORM.HeatExchangers.Simple_HX
                     HX1(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    nV=5,
    V_1=0.01,
    V_2=0.01,
    UA=4.34178e7,
    p_a_start_1=Turbine.pstart_out,
    T_a_start_1=Turbine.Tstart_out,
    m_flow_start_1=Turbine.w0,
    p_a_start_2=Turbine.pstart_in,
    T_a_start_2=HX1_ShellIn.T,
    m_flow_start_2=HX1_ShellIn.m_flow,
    R_1=0.001,
    R_2=0.001)
    annotation (Placement(transformation(extent={{12,64},{-14,88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,81},{-60,108}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{32,81},{64,110}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-54,50},{-26,75}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{22,49},{50,75}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-78,56},{-64,70}})));
  TRANSFORM.HeatExchangers.Simple_HX
                     HX2(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    nV=5,
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
    annotation (Placement(transformation(extent={{16,-6},{-10,18}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-22,9},{-52,34}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{32,6},{62,34}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-56,-20},{-28,3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,-18},{60,6}})));
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
        origin={146,52})));
  GasTurbine.Compressor.Compressor_v2   Comp2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-126,13},{-100,35}})));
  GasTurbine.Compressor.Compressor_v2   Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1084) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=Comp2.pstart_in,
    T_start=Comp2.Tstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-136,-42})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-186,-42})));
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
    nPorts=1) annotation (Placement(transformation(extent={{150,-112},{164,-98}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{258,-112},{244,-98}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{202,-111},{216,-97}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{232,-83},{218,-69}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
    p_start=20080000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={108,62})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={108,106})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
    annotation (Placement(transformation(extent={{62,52},{82,72}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-46,-93},{-32,-79}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=Comp2.w0,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-160,-86},{-146,-72}})));
equation
  connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
    annotation (Line(points={{32,95.5},{16,95.5},{16,80.8},{12,80.8}},
                                                                   color={0,127,255}));
  connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-14,80.8},{-22,80.8},{-22,94.5},{-30,94.5}},
                                                                       color={0,127,255}));
  connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-54,63},{-54,62.5}},
                                                                                                        color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
    annotation (Line(points={{-26,62.5},{-18,62.5},{-18,71.2},{-14,71.2}},
                                                                       color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
    annotation (Line(points={{22,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
    annotation (Line(points={{32,20},{22,20},{22,10.8},{16,10.8}}, color={0,127,255}));
  connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21.5},{-22,21.5}},
                                                                       color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-52,21.5},{-52,21},{-62,21}},
                                                                                                        color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
    annotation (Line(points={{-28,-8.5},{-14,-8.5},{-14,1.2},{-10,1.2}},
                                                                     color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
    annotation (Line(points={{28,-6},{20,-6},{20,1.2},{16,1.2}}, color={0,127,255}));
  connect(Comp1.inlet, Comp2In.ports[1])
    annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
  connect(Comp1.outlet, Comp2Out.ports[1])
    annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
  connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-176,-42},{-142,-42}}, color={191,0,0}));
  connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
  connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
  connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{164,-105},{202,-104}}, color={0,127,255}));
  connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{216,-104},{244,-105}}, color={0,127,255}));
  connect(MergeIn.ports[1], Merge.port_3)
    annotation (Line(points={{218,-76},{208,-76},{208,-97},{209,-97}}, color={0,127,255}));
  connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{108,96},{108,68}}, color={191,0,0}));
  connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{114,62},{114,63.2},{135.2,63.2}}, color={0,127,255}));
  connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
    annotation (Line(points={{156.8,63.2},{166,63.2},{166,95.5},{64,95.5}}, color={0,127,255}));
  connect(HeaterResistance.port_b, Heater.port_a)
    annotation (Line(points={{79,62},{102,62}},                    color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
    annotation (Line(points={{50,62},{65,62}},                  color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
    annotation (Line(points={{-60,94.5},{-84,94.5},{-84,-8.5},{-56,-8.5}},
                                                                   color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, Split.port_3)
    annotation (Line(points={{60,-6},{64,-6},{64,-74},{31,-74},{31,-79}}, color={0,127,255}));
  connect(SplitToC2.ports[1], resistance1.port_b)
    annotation (Line(points={{-32,-86},{-9,-86}},                       color={0,127,255}));
  connect(CoolerIn.ports[1], Cooler.port_a)
    annotation (Line(points={{-146,-79},{-136,-79},{-136,-48}},            color={0,127,255}));
  connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-120.8,32.8},{-136,32.8},{-136,-36}}, color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
    annotation (Line(points={{-105.2,32.8},{-104,32.8},{-104,38},{60,38},{60,20},{62,20}},
                                                                                         color={0,127,255}));
end New_v4;
