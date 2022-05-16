within NHES.Systems.BalanceOfPlant.NewSCO2Mods;
model New_v2
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
  TRANSFORM.HeatExchangers.Simple_HX
                     HX1(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    nV=3,
    V_1=0.01,
    V_2=0.01,
    UA=4.34178e7,
    p_a_start_1=HX2.p_a_start_1,
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
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-78,56},{-64,70}})));
  TRANSFORM.HeatExchangers.Simple_HX
                     HX2(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    nV=3,
    V_1=0.01,
    V_2=0.01,
    UA=1.66712e7,
    p_a_start_1=HX2_TubeOut.p,
    T_a_start_1=HX2_TubeIn.T,
    m_flow_start_1=HX2_TubeIn.m_flow,
    p_a_start_2=HX2_ShellOut.p,
    T_a_start_2=HX2_ShellOut.T,
    m_flow_start_2=Turbine.w0,
    R_1=0.001,
    R_2=0.001)
    annotation (Placement(transformation(extent={{16,-6},{-10,18}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    T=347.8,
    nPorts=1) annotation (Placement(transformation(extent={{80,14},{66,28}})));
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
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_ShellOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{78,-13},{66,-1}})));
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
    w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
  GasTurbine.Compressor.Compressor_v2   Comp1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    T=309.15,
    nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20130000,
    T=347.8,
    nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=8431000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-192,64})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-192,98})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    T=372.25,
    nPorts=1)
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-235,63})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8411000,
    T=309.15,
    nPorts=1) annotation (Placement(transformation(extent={{-140,43},{-152,55}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SplitIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-224,10},{-210,24}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-226,-32},{-246,-12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-280,-29},{-266,-15}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-210,-29},{-196,-15}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-176,-32},{-156,-12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-128,-29},{-142,-15}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1783,
    T=458.05,
    nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=1084,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
    p_start=20080000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={142,68})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=850e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={142,102})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
        ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
    annotation (Placement(transformation(extent={{98,54},{118,74}})));
equation
  connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
    annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
  connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
  connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-52,63}}, color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
    annotation (Line(points={{-32,63},{-18,63},{-18,71.2},{-14,71.2}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
    annotation (Line(points={{24,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_b, HX2_TubeIn.ports[1]) annotation (Line(points={{56,21},{66,21}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
    annotation (Line(points={{36,21},{22,21},{22,10.8},{16,10.8}}, color={0,127,255}));
  connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21},{-26,21}}, color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
    annotation (Line(points={{-28,-7},{-14,-7},{-14,1.2},{-10,1.2}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, HX2_ShellOut.ports[1])
    annotation (Line(points={{48,-8},{48,-7},{66,-7}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
    annotation (Line(points={{28,-8},{22,-8},{22,1.2},{16,1.2}}, color={0,127,255}));
  connect(Comp2.inlet, Comp1In.ports[1])
    annotation (Line(points={{151.2,16.8},{144,16.8},{144,17},{138,17}}, color={0,127,255}));
  connect(Comp2.outlet, Comp1Out.ports[1])
    annotation (Line(points={{166.8,16.8},{178,16.8},{178,17},{190,17}}, color={0,127,255}));
  connect(Comp1.inlet, Comp2In.ports[1])
    annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
  connect(Comp1.outlet, Comp2Out.ports[1])
    annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
  connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-192,88},{-192,70}}, color={191,0,0}));
  connect(Cooler.port_a, CoolerIn.ports[1])
    annotation (Line(points={{-198,64},{-214,64},{-214,63},{-228,63}}, color={0,127,255}));
  connect(Cooler.port_b, CoolerOut.ports[1])
    annotation (Line(points={{-186,64},{-164,64},{-164,49},{-152,49}}, color={0,127,255}));
  connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-229,-22},{-210,-22}}, color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{-196,-22},{-173,-22}}, color={0,127,255}));
  connect(resistance1.port_b, SplitToC2.ports[1]) annotation (Line(points={{-243,-22},{-266,-22}}, color={0,127,255}));
  connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{-159,-22},{-142,-22}}, color={0,127,255}));
  connect(SplitIn.ports[1], Split.port_3) annotation (Line(points={{-210,17},{-203,17},{-203,-15}}, color={0,127,255}));
  connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
  connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
  connect(MergeIn.ports[1], Merge.port_3)
    annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
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
end New_v2;
