within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1b_TestingHXs_CoolProp_sCO2
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{144,58},{164,78}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM
                     HX1(
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    NTU=10.6,
    K_tube=1,
    K_shell=1,
    V_Tube=0.193,
    V_Shell=2.272,
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
    annotation (Placement(transformation(extent={{-10,-12},{16,12}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{70,8},{56,22}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-20},{-54,-6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=643750,
    nPorts=1) annotation (Placement(transformation(extent={{-68,8},{-54,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20080000,
    h=1077200,
    nPorts=1) annotation (Placement(transformation(extent={{68,-20},{56,-8}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-46,5},{-26,25}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{24,5},{44,25}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-48,-23},{-28,-3}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{28,-24},{48,-4}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater1(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,60})));
  GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    pstart_out=8471000,
    Tstart_in=1023.15,
    Tstart_out=908.05,
    eta0=0.9,
    PR0=2.3126,
    w0=2867)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={12,50})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    m_flow=2867,
    T=857.05,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,52},{-44,68}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{54,55},{42,67}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA lmtd_HX(
    redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
    p_start_1=8471000,
    p_start_2=20100000,
    T_start_1=908.05,
    T_start_2=458.15,
    m_flow_start_1=2867,
    m_flow_start_2=2867,
    R_1=1,
    R_2=1,
    Q_flow0=1438e6)  annotation (Placement(transformation(extent={{-16,-74},{4,-54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=643750,
    nPorts=1) annotation (Placement(transformation(extent={{-82,-56},{-68,-42}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-60,-59},{-40,-39}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=1147600,
    nPorts=1) annotation (Placement(transformation(extent={{72,-56},{58,-42}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_TubeIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{26,-59},{46,-39}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    m_flow=2867,
    h=576280,
    nPorts=1)
    annotation (Placement(transformation(extent={{-84,-94},{-70,-80}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellIn2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-64,-97},{-44,-77}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=20080000,
    h=1077200,
    nPorts=1) annotation (Placement(transformation(extent={{64,-88},{52,-76}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort
                                              sensor_ShellOut2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{24,-92},{44,-72}})));
equation
  connect(HX1.Tube_out, sensor_TubeOut1.port_b)
    annotation (Line(points={{-10,4.8},{-20,4.8},{-20,15},{-26,15}},  color={0,127,255}));
  connect(sensor_TubeOut1.port_a, Tube_Downstream1.ports[1]) annotation (Line(points={{-46,15},{-54,15}}, color={0,127,255}));
  connect(Shell_Feed1.ports[1], sensor_ShellIn1.port_a) annotation (Line(points={{-54,-13},{-48,-13}},
                                                                                                     color={0,127,255}));
  connect(sensor_ShellIn1.port_b, HX1.Shell_in)
    annotation (Line(points={{-28,-13},{-20,-13},{-20,-2.4},{-10,-2.4}},
                                                                      color={0,127,255}));
  connect(HX1.Tube_in, sensor_TubeIn1.port_a)
    annotation (Line(points={{16,4.8},{20,4.8},{20,15},{24,15}},   color={0,127,255}));
  connect(sensor_TubeIn1.port_b, Tube_Feed1.ports[1]) annotation (Line(points={{44,15},{56,15}}, color={0,127,255}));
  connect(Shell_Downstream1.ports[1], sensor_ShellOut1.port_b) annotation (Line(points={{56,-14},{48,-14}},
                                                                                                          color={0,127,255}));
  connect(sensor_ShellOut1.port_a, HX1.Shell_out)
    annotation (Line(points={{28,-14},{20,-14},{20,-2.4},{16,-2.4}},
                                                                   color={0,127,255}));
  connect(Heater1.port_b, turbine.inlet) annotation (Line(points={{-14,60},{1.2,60},{1.2,61.2}}, color={0,127,255}));
  connect(Heater1.port_a, boundary2.ports[1]) annotation (Line(points={{-26,60},{-44,60}}, color={0,127,255}));
  connect(boundary3.ports[1], turbine.outlet)
    annotation (Line(points={{42,61},{36,61},{36,61.2},{22.8,61.2}}, color={0,127,255}));
  connect(sensor_TubeOut2.port_a,Tube_Downstream2. ports[1]) annotation (Line(points={{-60,-49},{-68,-49}},
                                                                                                          color={0,127,255}));
  connect(sensor_TubeOut2.port_b, lmtd_HX.port_a1)
    annotation (Line(points={{-40,-49},{-22,-49},{-22,-60},{-16,-60}}, color={0,127,255}));
  connect(sensor_TubeIn2.port_b,Tube_Feed2. ports[1]) annotation (Line(points={{46,-49},{58,-49}},
                                                                                                 color={0,127,255}));
  connect(sensor_TubeIn2.port_a, lmtd_HX.port_b1)
    annotation (Line(points={{26,-49},{24,-49},{24,-60},{4,-60}}, color={0,127,255}));
  connect(Shell_Feed2.ports[1],sensor_ShellIn2. port_a) annotation (Line(points={{-70,-87},{-64,-87}},
                                                                                                     color={0,127,255}));
  connect(sensor_ShellIn2.port_b, lmtd_HX.port_b2)
    annotation (Line(points={{-44,-87},{-22,-87},{-22,-68},{-16,-68}}, color={0,127,255}));
  connect(Shell_Downstream2.ports[1],sensor_ShellOut2. port_b) annotation (Line(points={{52,-82},{44,-82}},
                                                                                                          color={0,127,255}));
  connect(sensor_ShellOut2.port_a, lmtd_HX.port_a2)
    annotation (Line(points={{24,-82},{10,-82},{10,-68},{4,-68}}, color={0,127,255}));
end sCO2Cycle_1b_TestingHXs_CoolProp_sCO2;
