within NHES.Systems.BalanceOfPlant.NewSCO2Mods;
model New
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
  TRANSFORM.HeatExchangers.Simple_HX HX1(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium,
    nV=3,
    counterCurrent=true,
    V_1=0.01,
    V_2=0.01,
    UA=4.34178e7,
    p_a_start_1=HX1_TubeOut.p,
    T_a_start_1=HX1_TubeIn.T,
    m_flow_start_1=HX1_TubeIn.m_flow,
    p_a_start_2=HX1_ShellOut.p,
    T_a_start_2=HX1_ShellIn.T,
    m_flow_start_2=HX1_ShellIn.m_flow,
    R_1=0.001,
    R_2=0.001) annotation (Placement(transformation(extent={{12,64},{-14,88}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_TubeIn(
    redeclare package Medium = Medium,
    m_flow=2867,
    T=908.05,
    nPorts=1) annotation (Placement(transformation(extent={{76,84},{62,98}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{110,92},{130,112}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX1_TubeOut(
    redeclare package Medium = Medium,
    p=8451000,
    T=478.15,
    nPorts=1) annotation (Placement(transformation(extent={{-78,85},{-66,97}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
    redeclare package Medium = Medium,
    m_flow=2867,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-78,56},{-64,70}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX1_ShellOut(
    redeclare package Medium = Medium,
    p=20080000,
    T=857.05,
    nPorts=1) annotation (Placement(transformation(extent={{74,57},{62,69}})));
  TRANSFORM.HeatExchangers.Simple_HX
                     HX2(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium,
    nV=3,
    V_1=0.01,
    V_2=0.01,
    UA=1.66712e7,
    p_a_start_1=20130000,
    p_b_start_1=20100000,
    T_a_start_1=347.8,
    T_b_start_1=458.05,
    m_flow_start_1=1783,
    p_a_start_2=8451000,
    p_b_start_2=8431000,
    T_a_start_2=478.15,
    T_b_start_2=372.25,
    m_flow_start_2=2867,
    R_1=0.001,
    R_2=0.001)
    annotation (Placement(transformation(extent={{16,-6},{-10,18}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
    redeclare package Medium = Medium,
    m_flow=1783,
    T=347.8,
    nPorts=1) annotation (Placement(transformation(extent={{80,14},{66,28}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{36,11},{56,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
    redeclare package Medium = Medium,
    p=20100000,
    T=458.05,
    nPorts=1) annotation (Placement(transformation(extent={{-74,15},{-62,27}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_ShellIn(
    redeclare package Medium = Medium,
    m_flow=2867,
    T=478.15,
    nPorts=1) annotation (Placement(transformation(extent={{-74,-14},{-60,0}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_ShellOut(
    redeclare package Medium = Medium,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{78,-13},{66,-1}})));
  GasTurbine.Turbine.Turbine_v2 Turbine(
    redeclare package Medium = Medium,
    pstart_out=TurbineOut.p,
    Tstart_in=TurbineIn.T,
    eta0=0.9,
    PR0=2.3126,
    w0=2867)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={156,60})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineOut(
    redeclare package Medium = Medium,
    p=8471000,
    T=908.05,
    nPorts=1) annotation (Placement(transformation(extent={{194,65},{182,77}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T TurbineIn(
    redeclare package Medium = Medium,
    m_flow=2867,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{110,64},{124,78}})));
  GasTurbine.Compressor.Compressor_v2   Comp2(
    redeclare package Medium = Medium,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
  GasTurbine.Compressor.Compressor_v2   Comp1(
    redeclare package Medium = Medium,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
    redeclare package Medium = Medium,
    m_flow=1783,
    T=309.15,
    nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
    redeclare package Medium = Medium,
    m_flow=1084,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
    redeclare package Medium = Medium,
    p=20130000,
    T=347.8,
    nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
    redeclare package Medium = Medium,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=CoolerOut.p,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
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
    redeclare package Medium = Medium,
    m_flow=1783,
    T=372.25,
    nPorts=1)
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-235,63})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
    redeclare package Medium = Medium,
    p=8411000,
    T=309.15,
    nPorts=1) annotation (Placement(transformation(extent={{-140,43},{-152,55}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SplitIn(
    redeclare package Medium = Medium,
    m_flow=2867,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-224,10},{-210,24}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
        Medium, R=0.378250591016547)
    annotation (Placement(transformation(extent={{-226,-32},{-246,-12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
    redeclare package Medium = Medium,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-280,-27},{-266,-13}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-210,-29},{-196,-15}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
        Medium, R=1 - resistance1.R)
    annotation (Placement(transformation(extent={{-176,-32},{-156,-12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
    redeclare package Medium = Medium,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-128,-29},{-142,-15}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
    redeclare package Medium = Medium,
    m_flow=1783,
    T=458.05,
    nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
    redeclare package Medium = Medium,
    m_flow=1084,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
    redeclare package Medium = Medium,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
    p_start=HeaterOut.p,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={18,-122})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={18,-88})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HeaterIn(
    redeclare package Medium = Medium,
    m_flow=2867,
    T=857.05,
    nPorts=1)
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-25,-123})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HeaterOut(
    redeclare package Medium = Medium,
    p=19590000,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{70,-143},{58,-131}})));
equation
  connect(HX1_sensor_TubeIn.port_b, HX1_TubeIn.ports[1]) annotation (Line(points={{52,91},{62,91}}, color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
    annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
  connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX1_TubeOut.ports[1]) annotation (Line(points={{-50,91},{-66,91}}, color={0,127,255}));
  connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-52,63}}, color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
    annotation (Line(points={{-32,63},{-18,63},{-18,71.2},{-14,71.2}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_b, HX1_ShellOut.ports[1])
    annotation (Line(points={{44,62},{44,63},{62,63}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
    annotation (Line(points={{24,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_b, HX2_TubeIn.ports[1]) annotation (Line(points={{56,21},{66,21}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
    annotation (Line(points={{36,21},{22,21},{22,10.8},{16,10.8}}, color={0,127,255}));
  connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21},{-26,21}}, color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
  connect(HX2_ShellIn.ports[1], HX2_sensor_ShellIn.port_a) annotation (Line(points={{-60,-7},{-48,-7}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
    annotation (Line(points={{-28,-7},{-14,-7},{-14,1.2},{-10,1.2}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, HX2_ShellOut.ports[1])
    annotation (Line(points={{48,-8},{48,-7},{66,-7}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
    annotation (Line(points={{28,-8},{22,-8},{22,1.2},{16,1.2}}, color={0,127,255}));
  connect(TurbineOut.ports[1], Turbine.outlet)
    annotation (Line(points={{182,71},{180,71},{180,71.2},{166.8,71.2}}, color={0,127,255}));
  connect(TurbineIn.ports[1], Turbine.inlet) annotation (Line(points={{124,71},{145.2,71.2}}, color={0,127,255}));
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
  connect(resistance1.port_b, SplitToC2.ports[1])
    annotation (Line(points={{-243,-22},{-260,-22},{-260,-20},{-266,-20}}, color={0,127,255}));
  connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{-159,-22},{-142,-22}}, color={0,127,255}));
  connect(SplitIn.ports[1], Split.port_3) annotation (Line(points={{-210,17},{-203,17},{-203,-15}}, color={0,127,255}));
  connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
  connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
  connect(MergeIn.ports[1], Merge.port_3)
    annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
  connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{18,-98},{18,-116}}, color={191,0,0}));
  connect(Heater.port_a, HeaterIn.ports[1])
    annotation (Line(points={{12,-122},{-4,-122},{-4,-123},{-18,-123}}, color={0,127,255}));
  connect(Heater.port_b, HeaterOut.ports[1])
    annotation (Line(points={{24,-122},{46,-122},{46,-137},{58,-137}}, color={0,127,255}));
end New;
