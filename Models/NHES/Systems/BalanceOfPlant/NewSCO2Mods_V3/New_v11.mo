within NHES.Systems.BalanceOfPlant.NewSCO2Mods_V3;
model New_v11
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
               annotation (Placement(transformation(extent={{-48,64},{-22,88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-64,81},{-84,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-2,81},{18,101}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-86,53},{-66,73}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{-148,126},{-128,146}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX1_ShellOut(
    redeclare package Medium = Medium,
    p=20080000,
    T=857.05,
    nPorts=1) annotation (Placement(transformation(extent={{62,57},{50,69}})));
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
    annotation (Placement(transformation(extent={{-44,-6},{-18,18}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-60,11},{-80,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{2,11},{22,31}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-82,-17},{-62,3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-6,-18},{14,2}})));
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
        origin={128,50})));
  GasTurbine.Compressor.Compressor_v2   Comp2(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp2_P_ref,
    Tstart_in=initialConditions.Comp2_TStart_In,
    Tstart_out=initialConditions.Comp2_TStart_Out,
    eta0=operatingConditions.Comp2_Efficiency,
    PR0=operatingConditions.Comp2_PressureRatio,
    w0=operatingConditions.Comp2_NominalMassFlowRate)
             annotation (Placement(transformation(extent={{-126,-17},{-100,5}})));
  GasTurbine.Compressor.Compressor_v2   Comp1(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp1_P_ref,
    Tstart_in=initialConditions.Comp1_TStart_In,
    Tstart_out=initialConditions.Comp1_TStart_Out,
    eta0=operatingConditions.Comp1_Efficiency,
    PR0=operatingConditions.Comp1_PressureRatio,
    w0=operatingConditions.Comp1_NominalMassFlowRate)
             annotation (Placement(transformation(extent={{82,-71},{108,-49}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=initialConditions.Cooler_PStart,
    T_start=initialConditions.Cooler_TStart,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-124,-46})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary(T=309.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-152,-46})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{82,-25},{96,-11}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Turbine_In_Boundary(
    redeclare package Medium = Medium,
    p=19590000,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{78,58},{90,70}})));
  InitialConditions initialConditions annotation (Placement(transformation(extent={{-114,128},{-94,148}})));
  OperatingConditions operatingConditions annotation (Placement(transformation(extent={{-82,128},{-62,148}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
        0.378250591016547) annotation (Placement(transformation(extent={{-16,-96},{-36,-76}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=8411000,
    T_start=372.25,
    V=0.1)
    annotation (Placement(transformation(extent={{0,-93},{14,-79}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
         - FlowResistance1.R) annotation (Placement(transformation(extent={{28,-96},{48,-76}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8411000,
    T=372.25,
    nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-61,-130})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-61,-106})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal  Split1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-61,-86})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e7,
    Ti=15,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{146,108},{126,128}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Turbine.pout) annotation (Placement(transformation(extent={{200,66},{180,86}})));
  Modelica.Blocks.Sources.Constant const(k=84.51) annotation (Placement(transformation(extent={{198,108},{178,128}})));
  Modelica.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    dp_nominal=1000,
    m_flow_nominal=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={84,118})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    T=908.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={95,152})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler1(
    p_start=8411000,
    T_start=372.25,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.1),
    redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={64,-51})));
equation
  connect(HX1_sensor_ShellOut.port_b, HX1_ShellOut.ports[1])
    annotation (Line(points={{10,62},{10,63},{50,63}}, color={0,127,255}));
  connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-142,-46},{-130,-46}},  color={191,0,0}));
  connect(HX1_sensor_TubeIn.port_a, HX1.Tube_in)
    annotation (Line(points={{-2,91},{-16,91},{-16,80.8},{-22,80.8}},
                                                                   color={0,127,255}));
  connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{-48,80.8},{-56,80.8},{-56,91},{-64,91}}, color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
    annotation (Line(points={{-66,63},{-52,63},{-52,73.6},{-48,73.6}}, color={0,127,255}));
  connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
    annotation (Line(points={{-22,73.6},{-16,73.6},{-16,62},{-10,62}},
                                                                   color={0,127,255}));
  connect(HX2.Tube_in, HX2_sensor_TubeIn.port_a)
    annotation (Line(points={{-18,10.8},{-4,10.8},{-4,21},{2,21}}, color={0,127,255}));
  connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{-44,10.8},{-52,10.8},{-52,21},{-60,21}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
    annotation (Line(points={{-62,-7},{-48,-7},{-48,3.6},{-44,3.6}}, color={0,127,255}));
  connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
    annotation (Line(points={{-18,3.6},{-12,3.6},{-12,-8},{-6,-8}},
                                                                 color={0,127,255}));
  connect(Turbine_In_Boundary.ports[1], Turbine.inlet) annotation (Line(points={{90,64},{117.2,64},{117.2,61.2}},
                                                                                                        color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
    annotation (Line(points={{-84,91},{-96,91},{-96,-7},{-82,-7}}, color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
    annotation (Line(points={{-105.2,2.8},{-104,2.8},{-104,44},{70,44},{70,21},{22,21}},                 color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-124,-40},{-124,8},{-120.8,8},{-120.8,2.8}},     color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
    annotation (Line(points={{-80,21},{-90,21},{-90,36},{42,36},{42,-18},{82,-18}},    color={0,127,255}));
  connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
    annotation (Line(points={{89,-11},{88,-11},{88,48},{-92,48},{-92,63},{-86,63}},  color={0,127,255}));
  connect(FlowResistance1.port_a,Split. port_1) annotation (Line(points={{-19,-86},{0,-86}},   color={0,127,255}));
  connect(Split.port_2,FlowResistance2. port_a) annotation (Line(points={{14,-86},{31,-86}},color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b,Split. port_3)
    annotation (Line(points={{14,-8},{14,-72},{7,-72},{7,-79}},           color={0,127,255}));
  connect(resistance2.port_b,Pressurizer. ports[1]) annotation (Line(points={{-61,-113},{-61,-123}},   color={0,127,255}));
  connect(FlowResistance1.port_b,Split1. port_1) annotation (Line(points={{-33,-86},{-54,-86}}, color={0,127,255}));
  connect(resistance2.port_a,Split1. port_3)
    annotation (Line(points={{-61,-99},{-61,-93}},                           color={0,127,255}));
  connect(Cooler.port_a, Split1.port_2) annotation (Line(points={{-124,-52},{-124,-86},{-68,-86}},           color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_b, Turbine.outlet) annotation (Line(points={{18,91},{150,91},{150,61.2},{138.8,61.2}}, color={0,127,255}));
  connect(PID.y, valveLinear.opening) annotation (Line(points={{125,118},{92,118}},color={0,0,127}));
  connect(const.y, PID.u_s) annotation (Line(points={{177,118},{148,118}},
                                                                         color={0,0,127}));
  connect(realExpression.y, PID.u_m) annotation (Line(points={{179,76},{160,76},{160,106},{136,106}},
                                                                                                    color={0,0,127}));
  connect(Sink.ports[1], valveLinear.port_b) annotation (Line(points={{95,145},{84,145},{84,128}},    color={0,127,255}));
  connect(FlowResistance2.port_b, Cooler1.port_b) annotation (Line(points={{45,-86},{52,-86},{52,-51},{58,-51}},     color={0,127,255}));
  connect(Cooler1.port_a, Comp1.inlet) annotation (Line(points={{70,-51},{80.6,-51},{80.6,-51.2},{87.2,-51.2}},     color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2) annotation (Line(points={{102.8,-51.2},{102.8,-18},{96,-18}},  color={0,127,255}));

  connect(valveLinear.port_a, Turbine.outlet) annotation (Line(points={{84,108},{84,90},{150,90},{150,61.2},{138.8,61.2}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,-150},{
            150,150}})));
end New_v11;
