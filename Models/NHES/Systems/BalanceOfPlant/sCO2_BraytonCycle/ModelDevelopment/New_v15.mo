within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle.ModelDevelopment;
model New_v15
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
               annotation (Placement(transformation(extent={{26,16},{0,40}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,36},{64,56}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,37},{-10,57}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{64,6},{44,26}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-10,8},{-30,28}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{58,124},{78,144}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT BoundaryOut(
    redeclare package Medium = Medium,
    p=19800000,
    T=857.05,
    nPorts=1) annotation (Placement(transformation(extent={{-104,12},{-92,24}})));
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
    annotation (Placement(transformation(extent={{28,-34},{2,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,-21},{64,-1}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,-21},{-10,-1}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{64,-47},{44,-27}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-8,-46},{-28,-26}})));
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
        origin={-64,50})));
  Components.Compressor_v2 Comp2(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp2_P_ref,
    Tstart_in=initialConditions.Comp2_TStart_In,
    Tstart_out=initialConditions.Comp2_TStart_Out,
    eta0=operatingConditions.Comp2_Efficiency,
    PR0=operatingConditions.Comp2_PressureRatio,
    w0=operatingConditions.Comp2_NominalMassFlowRate) annotation (Placement(transformation(extent={{-100,-33},{-74,-11}})));
  Components.Compressor_v2 Comp1(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp1_P_ref,
    Tstart_in=initialConditions.Comp1_TStart_In,
    Tstart_out=initialConditions.Comp1_TStart_Out,
    eta0=operatingConditions.Comp1_Efficiency,
    PR0=operatingConditions.Comp1_PressureRatio,
    w0=operatingConditions.Comp1_NominalMassFlowRate) annotation (Placement(transformation(extent={{30,-108},{56,-86}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=initialConditions.Cooler_PStart,
    T_start=initialConditions.Cooler_TStart,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-110,-50})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary(T=309.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-50})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{86,-71},{100,-57}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT BoundaryIn(
    redeclare package Medium = Medium,
    p=19590000,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{-104,56},{-92,68}})));
  InitialConditions initialConditions annotation (Placement(transformation(extent={{92,126},{112,146}})));
  OperatingConditions operatingConditions annotation (Placement(transformation(extent={{124,126},{144,146}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
        0.378250591016547) annotation (Placement(transformation(extent={{-76,-98},{-96,-78}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=8411000,
    T_start=372.25,
    V=0.1)
    annotation (Placement(transformation(extent={{-52,-95},{-38,-81}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
         - FlowResistance1.R) annotation (Placement(transformation(extent={{-12,-98},{8,-78}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e7,
    Ti=15,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{80,78},{60,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Turbine.pout) annotation (Placement(transformation(extent={{138,48},{118,68}})));
  Modelica.Blocks.Sources.Constant const(k=84.51) annotation (Placement(transformation(extent={{138,78},{118,98}})));
  Modelica.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    dp_nominal=1000,
    m_flow_nominal=1)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-30,88})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8403000,
    T=908.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-30,120})));
equation
  connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-130,-50},{-116,-50}},  color={191,0,0}));
  connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{26,32.8},{44,32.8},{44,46}},             color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
    annotation (Line(points={{44,16},{38,16},{38,25.6},{26,25.6}},     color={0,127,255}));
  connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
    annotation (Line(points={{0,25.6},{0,18},{-10,18}},            color={0,127,255}));
  connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{28,-17.2},{36,-17.2},{36,-11},{44,-11}}, color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
    annotation (Line(points={{44,-37},{32,-37},{32,-24.4},{28,-24.4}},
                                                                     color={0,127,255}));
  connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
    annotation (Line(points={{2,-24.4},{-2,-24.4},{-2,-36},{-8,-36}},
                                                                 color={0,127,255}));
  connect(BoundaryIn.ports[1], Turbine.inlet) annotation (Line(points={{-92,62},{-74.8,62},{-74.8,61.2}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-110,-44},{-110,-12},{-94.8,-12},{-94.8,-13.2}}, color={0,127,255}));
  connect(FlowResistance1.port_a,Split. port_1) annotation (Line(points={{-79,-88},{-52,-88}}, color={0,127,255}));
  connect(Split.port_2,FlowResistance2. port_a) annotation (Line(points={{-38,-88},{-9,-88}},
                                                                                            color={0,127,255}));
  connect(PID.y, valveLinear.opening) annotation (Line(points={{59,88},{-22,88}},  color={0,0,127}));
  connect(const.y, PID.u_s) annotation (Line(points={{117,88},{82,88}},  color={0,0,127}));
  connect(realExpression.y, PID.u_m) annotation (Line(points={{117,58},{70,58},{70,76}},            color={0,0,127}));
  connect(Sink.ports[1], valveLinear.port_b) annotation (Line(points={{-30,113},{-30,98}},            color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2) annotation (Line(points={{50.8,-88.2},{50.8,-86},{108,-86},{108,-64},{100,-64}},
                                                                                                     color={0,127,255}));

  connect(valveLinear.port_a, Turbine.outlet) annotation (Line(points={{-30,78},{-30,61.2},{-53.2,61.2}}, color={0,127,255}));
  connect(Cooler.port_a, FlowResistance1.port_b) annotation (Line(points={{-110,-56},{-110,-88},{-93,-88}}, color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_b, BoundaryOut.ports[1]) annotation (Line(points={{-30,18},{-92,18}}, color={0,127,255}));
  connect(Turbine.outlet, HX1_sensor_TubeIn.port_a) annotation (Line(points={{-53.2,61.2},{-53.2,62},{-30,62},{-30,47}}, color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in) annotation (Line(points={{-10,47},{0,47},{0,32.8}}, color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a) annotation (Line(points={{64,46},{68,46},{68,-37},{64,-37}}, color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in) annotation (Line(points={{-10,-11},{-4,-11},{-4,-17.2},{2,-17.2}}, color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_a) annotation (Line(points={{-79.2,-13.2},{-78,-13.2},{-78,-11},{-30,-11}}, color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, Merge.port_1) annotation (Line(points={{64,-11},{80,-11},{80,-64},{86,-64}}, color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, Split.port_3) annotation (Line(points={{-28,-36},{-45,-36},{-45,-81}}, color={0,127,255}));
  connect(FlowResistance2.port_b, Comp1.inlet) annotation (Line(points={{5,-88},{26,-88},{26,-88.2},{35.2,-88.2}}, color={0,127,255}));
  connect(Merge.port_3, HX1_sensor_ShellIn.port_a) annotation (Line(points={{93,-57},{92,-57},{92,16},{64,16}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,-150},{
            150,150}})));
end New_v15;
