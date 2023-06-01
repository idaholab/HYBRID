within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle.ModelDevelopment;
model New_v3
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                     HX1(
    NTU=operatingConditions.HTR_NTU,
    K_tube=operatingConditions.HTR_K_tube,
    K_shell=operatingConditions.HTR_K_shell,
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=operatingConditions.HTR_volume_tube,
    V_Shell=operatingConditions.HTR_volume_shell,
    p_start_tube=initialConditions.HTR_PStart_Tube,
    h_start_tube_inlet=initialConditions.HTR_HStart_Tube_In,
    h_start_tube_outlet=initialConditions.HTR_HStart_Tube_Out,
    p_start_shell=initialConditions.HTR_PStart_Shell,
    h_start_shell_inlet=initialConditions.HTR_HStart_Shell_In,
    h_start_shell_outlet=initialConditions.HTR_HStart_Shell_Out,
    dp_init_tube=initialConditions.HTR_dp_Tube,
    dp_init_shell=initialConditions.HTR_dp_Shell,
    Q_init=-1438e6,
    Cr_init=initialConditions.CR_init_HTR,
    m_start_tube=initialConditions.HTR_MassFlowStart_Tube,
    m_start_shell=initialConditions.HTR_MassFlowStart_Shell)
               annotation (Placement(transformation(extent={{-14,64},{12,88}})));
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
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{80,120},{100,140}})));
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
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                     HX2(
    NTU=operatingConditions.LTR_NTU,
    K_tube=operatingConditions.LTR_K_tube,
    K_shell=operatingConditions.LTR_K_shell,
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=operatingConditions.LTR_volume_tube,
    V_Shell=operatingConditions.LTR_volume_shell,
    p_start_tube=initialConditions.LTR_PStart_Tube,
    h_start_tube_inlet=initialConditions.LTR_HStart_Tube_In,
    h_start_tube_outlet=initialConditions.LTR_HStart_Tube_Out,
    p_start_shell=initialConditions.LTR_PStart_Shell,
    h_start_shell_inlet=initialConditions.LTR_HStart_Shell_In,
    h_start_shell_outlet=initialConditions.LTR_HStart_Shell_Out,
    Q_init=370.1e6,
    Cr_init=initialConditions.CR_init_LTR,
    m_start_tube=initialConditions.LTR_MassFlowStart_Tube,
    m_start_shell=initialConditions.LTR_MassFlowStart_Shell)
    annotation (Placement(transformation(extent={{-10,-6},{16,18}})));
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
  GasTurbine.Turbine.Turbine_v2 Turbine(
    redeclare package Medium = Medium,
    pstart_out=initialConditions.Turbine_P_ref,
    Tstart_in=initialConditions.Turbine_TStart_In,
    Tstart_out=initialConditions.Turbine_TStart_Out,
    eta0=operatingConditions.Turbine_Efficiency,
    PR0=operatingConditions.Turbine_PressureRatio,
    w0=operatingConditions.Turbine_NominalMassFlowRate)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={156,60})));
  Components.Compressor_v2 Comp2(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp2_P_ref,
    Tstart_in=initialConditions.Comp2_TStart_In,
    Tstart_out=initialConditions.Comp2_TStart_Out,
    eta0=operatingConditions.Comp2_Efficiency,
    PR0=operatingConditions.Comp2_PressureRatio,
    w0=operatingConditions.Comp2_NominalMassFlowRate) annotation (Placement(transformation(extent={{-138,-17},{-112,5}})));
  Components.Compressor_v2 Comp1(
    redeclare package Medium = Medium,
    pstart_in=8411000,
    pstart_out=20130000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
    redeclare package Medium = Medium,
    m_flow=1084,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
    redeclare package Medium = Medium,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=initialConditions.Cooler_PStart,
    T_start=initialConditions.Cooler_TStart,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-190,-106})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary(T=309.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-190,-72})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
    redeclare package Medium = Medium,
    m_flow=1783,
    T=372.25,
    nPorts=1)
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-233,-107})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = Medium, R=operatingConditions.FlowResistance1)
    annotation (Placement(transformation(extent={{0,-124},{-20,-104}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
    redeclare package Medium = Medium,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-54,-121},{-40,-107}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{16,-121},{30,-107}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = Medium, R=operatingConditions.FlowResistance2)
    annotation (Placement(transformation(extent={{50,-124},{70,-104}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
    redeclare package Medium = Medium,
    p=8431000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{98,-121},{84,-107}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
    redeclare package Medium = Medium,
    m_flow=1783,
    T=458.05,
    nPorts=1) annotation (Placement(transformation(extent={{140,-112},{154,-98}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
    redeclare package Medium = Medium,
    m_flow=1084,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{248,-112},{234,-98}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{192,-111},{206,-97}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
    redeclare package Medium = Medium,
    p=20100000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{222,-83},{208,-69}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Turbine_In_Boundary(
    redeclare package Medium = Medium,
    p=19590000,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{106,65},{118,77}})));
  InitialConditions initialConditions annotation (Placement(transformation(extent={{-126,104},{-106,124}})));
  OperatingConditions operatingConditions annotation (Placement(transformation(extent={{-94,104},{-74,124}})));
equation
  connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-52,63}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_b, HX1_ShellOut.ports[1])
    annotation (Line(points={{44,62},{44,63},{62,63}}, color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
  connect(Comp1.inlet, Comp2In.ports[1])
    annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
  connect(Comp1.outlet, Comp2Out.ports[1])
    annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
  connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-190,-82},{-190,-100}}, color={191,0,0}));
  connect(Cooler.port_a, CoolerIn.ports[1])
    annotation (Line(points={{-196,-106},{-212,-106},{-212,-107},{-226,-107}},
                                                                       color={0,127,255}));
  connect(FlowResistance1.port_a, Split.port_1) annotation (Line(points={{-3,-114},{16,-114}}, color={0,127,255}));
  connect(Split.port_2, FlowResistance2.port_a) annotation (Line(points={{30,-114},{53,-114}}, color={0,127,255}));
  connect(FlowResistance1.port_b, SplitToC2.ports[1]) annotation (Line(points={{-17,-114},{-40,-114}}, color={0,127,255}));
  connect(FlowResistance2.port_b, SplitToC1.ports[1]) annotation (Line(points={{67,-114},{84,-114}}, color={0,127,255}));
  connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{154,-105},{192,-104}}, color={0,127,255}));
  connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{206,-104},{234,-105}}, color={0,127,255}));
  connect(MergeIn.ports[1], Merge.port_3)
    annotation (Line(points={{208,-76},{198,-76},{198,-97},{199,-97}},     color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_a, HX1.Tube_in)
    annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
  connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
    annotation (Line(points={{-32,63},{-18,63},{-18,73.6},{-14,73.6}}, color={0,127,255}));
  connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
    annotation (Line(points={{12,73.6},{18,73.6},{18,62},{24,62}}, color={0,127,255}));
  connect(HX2.Tube_in, HX2_sensor_TubeIn.port_a)
    annotation (Line(points={{16,10.8},{30,10.8},{30,21},{36,21}}, color={0,127,255}));
  connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21},{-26,21}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
    annotation (Line(points={{-28,-7},{-14,-7},{-14,3.6},{-10,3.6}}, color={0,127,255}));
  connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
    annotation (Line(points={{16,3.6},{22,3.6},{22,-8},{28,-8}}, color={0,127,255}));
  connect(Turbine_In_Boundary.ports[1], Turbine.inlet) annotation (Line(points={{118,71},{145.2,71.2}}, color={0,127,255}));
  connect(Turbine.outlet, HX1_sensor_TubeIn.port_b) annotation (Line(points={{166.8,71.2},{184.4,71.2},{184.4,91},{52,91}}, color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
    annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, Split.port_3) annotation (Line(points={{48,-8},{52,-8},{52,-102},{23,-102},{23,-107}}, color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
    annotation (Line(points={{-117.2,2.8},{-116,2.8},{-116,8},{-78,8},{-78,34},{60,34},{60,21},{56,21}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-184,-106},{-158,-106},{-158,2.8},{-132.8,2.8}}, color={0,127,255}));
end New_v3;
