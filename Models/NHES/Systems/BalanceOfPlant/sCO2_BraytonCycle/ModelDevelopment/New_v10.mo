within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle.ModelDevelopment;
model New_v10
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
    pstart_in=initialConditions.Comp1_P_ref,
    Tstart_in=initialConditions.Comp1_TStart_In,
    Tstart_out=initialConditions.Comp1_TStart_Out,
    eta0=operatingConditions.Comp1_Efficiency,
    PR0=operatingConditions.Comp1_PressureRatio,
    w0=operatingConditions.Comp1_NominalMassFlowRate) annotation (Placement(transformation(extent={{148,-71},{174,-49}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=initialConditions.Cooler_PStart,
    T_start=initialConditions.Cooler_TStart,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-148,-46})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary(T=309.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-208,-46})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{148,-25},{162,-11}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Turbine_In_Boundary(
    redeclare package Medium = Medium,
    p=19590000,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{106,65},{118,77}})));
  InitialConditions initialConditions annotation (Placement(transformation(extent={{-126,104},{-106,124}})));
  OperatingConditions operatingConditions annotation (Placement(transformation(extent={{-94,104},{-74,124}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
        0.378250591016547) annotation (Placement(transformation(extent={{42,-96},{22,-76}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=8411000,
    T_start=372.25,
    V=0.1)
    annotation (Placement(transformation(extent={{58,-93},{72,-79}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
         - FlowResistance1.R) annotation (Placement(transformation(extent={{86,-96},{106,-76}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8411000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-3,-130})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-3,-106})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-3,-86})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={209,-60})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={209,-78})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20150000,
    T=458.15,
    nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={209,-104})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e7,
    Ti=15,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{320,56},{300,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Turbine.pout) annotation (Placement(transformation(extent={{374,14},{354,34}})));
  Modelica.Blocks.Sources.Constant const(k=84.51) annotation (Placement(transformation(extent={{382,52},{362,72}})));
  Modelica.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    dp_nominal=1000,
    m_flow_nominal=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={260,52})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    T=908.15,
    nPorts=1) annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=90,
        origin={257,104})));
equation
  connect(HX1_sensor_ShellOut.port_b, HX1_ShellOut.ports[1])
    annotation (Line(points={{44,62},{44,63},{62,63}}, color={0,127,255}));
  connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-198,-46},{-154,-46}},  color={191,0,0}));
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
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
    annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
    annotation (Line(points={{-117.2,2.8},{-116,2.8},{-116,8},{-78,8},{-78,34},{60,34},{60,21},{56,21}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-148,-40},{-148,-40},{-148,2.8},{-132.8,2.8}},   color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
    annotation (Line(points={{-46,21},{-50,21},{-50,36},{118,36},{118,-18},{148,-18}}, color={0,127,255}));
  connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
    annotation (Line(points={{155,-11},{62,-11},{62,48},{-56,48},{-56,63},{-52,63}}, color={0,127,255}));
  connect(FlowResistance1.port_a,Split. port_1) annotation (Line(points={{39,-86},{58,-86}},   color={0,127,255}));
  connect(Split.port_2,FlowResistance2. port_a) annotation (Line(points={{72,-86},{89,-86}},color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b,Split. port_3)
    annotation (Line(points={{48,-8},{56,-8},{56,-72},{65,-72},{65,-79}}, color={0,127,255}));
  connect(resistance2.port_b,Pressurizer. ports[1]) annotation (Line(points={{-3,-113},{-3,-123}},     color={0,127,255}));
  connect(FlowResistance1.port_b,Split1. port_1) annotation (Line(points={{25,-86},{4,-86}},    color={0,127,255}));
  connect(resistance2.port_a,Split1. port_3)
    annotation (Line(points={{-3,-99},{-3,-93}},                             color={0,127,255}));
  connect(Cooler.port_a, Split1.port_2) annotation (Line(points={{-148,-52},{-148,-88},{-10,-88},{-10,-86}}, color={0,127,255}));
  connect(Pressurizer1.ports[1], resistance1.port_b) annotation (Line(points={{209,-97},{210,-97},{210,-85},{209,-85}}, color={0,127,255}));
  connect(Split2.port_3, resistance1.port_a) annotation (Line(points={{209,-67},{208,-67},{208,-71},{209,-71}}, color={0,127,255}));
  connect(FlowResistance2.port_b, Comp1.inlet) annotation (Line(points={{103,-86},{118,-86},{118,-51.2},{153.2,-51.2}}, color={0,127,255}));
  connect(Comp1.outlet, Split2.port_2) annotation (Line(points={{168.8,-51.2},{192,-51.2},{192,-60},{202,-60}}, color={0,127,255}));
  connect(Split2.port_1, Merge.port_2) annotation (Line(points={{216,-60},{232,-60},{232,-18},{162,-18}}, color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_b, Turbine.outlet) annotation (Line(points={{52,91},{170,91},{170,71.2},{166.8,71.2}}, color={0,127,255}));
  connect(PID.y, valveLinear.opening) annotation (Line(points={{299,66},{288,66},{288,52},{268,52}}, color={0,0,127}));
  connect(const.y, PID.u_s) annotation (Line(points={{361,62},{348,62},{348,66},{322,66}}, color={0,0,127}));
  connect(realExpression.y, PID.u_m) annotation (Line(points={{353,24},{334,24},{334,54},{310,54}}, color={0,0,127}));
  connect(valveLinear.port_a, Turbine.outlet)
    annotation (Line(points={{260,42},{246,42},{246,58},{230,58},{230,71.2},{166.8,71.2}}, color={0,127,255}));
  connect(Pressurizer2.ports[1], valveLinear.port_b) annotation (Line(points={{257,97},{276,97},{276,86},{260,86},{260,62}}, color={0,127,255}));
end New_v10;
