within NHES.Desalination.Examples;
model RO_plant_closedLoop
  extends Modelica.Icons.Example;

  final parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";
  final parameter Integer NoPumps = 45
    "Number of pumps";
  final parameter Integer NoVesselUnits = NoPumps*NoVesselUnits_per_pump "Number of online RO vessel units per system";
  final parameter SI.Power capacity_nom(displayUnit="MW") = 45e6 "Nominal electrical power consumption in an RO system";
  parameter SI.Power capacity(displayUnit="MW") = capacity_nom "System capacity";
  final parameter Real capacityScaler = capacity/capacity_nom "Scaler that sizes the capacity of the overall system";

  Real SaltRejection "Salt rejection [%]";
  Real OverallRecoveryRatio "Overall recovery ratio [%]";
  SI.MassFlowRate mp_plant_kg_s "Overall permeate mass flow rate [kg/s]";
  NHES.Desalination.Types.VolumeFlowRate_gpd Qp_plant_gpd
    "Overall volumetric permeate flow rate [gallon per day]";

  ReverseOsmosis.RO_unit rO_unit(redeclare package Medium =
        Media.BrineProp.BrineDriesner, NoVesselUnits_per_pump=
        NoVesselUnits_per_pump)
    annotation (Placement(transformation(extent={{-10,-34},{10,-14}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p=1189512)                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,-20})));
  Modelica.Fluid.Sources.Boundary_pT permeateSink(
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p=101325) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-60})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Valves.ValveLinear PCV(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    m_flow(start=PCV.m_flow_nominal),
    m_flow_nominal=1.21876*NoVesselUnits_per_pump,
    m_flow_start=PCV.m_flow_nominal,
    dp_start=PCV.dp_nominal/0.8,
    dp_nominal=0.8*((14.8689 - 11.89512)*1e5))
                                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-20})));
  Machines.PumpingSystem
                pumpingSystem(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    V=1,
    NoPumps=1,
    NoVesselUnits_per_pump=NoVesselUnits_per_pump)
         annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Fluid.Sources.Boundary_pT brineSource(
    use_p_in=false,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    nPorts=1,
    p=system.p_ambient,
    T=system.T_ambient)                                   annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-20})));
  Modelica.Fluid.Sensors.Pressure p_feed_meas(redeclare package Medium =
        Media.BrineProp.BrineDriesner)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_p_feed(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,10})));
  Modelica.Blocks.Continuous.LimPID FBctrl_p_feed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y(start=actuator_p_feed.y_start),
    xi_start=actuator_p_feed.y_start/FBctrl_p_feed.k,
    y_start=actuator_p_feed.y_start,
    gainPID(y(start=actuator_p_feed.y_start)),
    k=0.0000190174326465927,
    Ti=11.3161614243773,
    yMax=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,50})));
  Modelica.Blocks.Sources.Ramp p_feed_set(
    duration=0,
    height=0,
    startTime=0,
    y(unit="Pa", displayUnit="bar"),
    offset=17.5133e5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={10,10})));
  Modelica.Blocks.Sources.Ramp power_set(
    duration=0,
    startTime=100,
    height=NoPumps*(-0.2e6 - 0.6666667e6*0 + 0.04e6*0),
    offset=NoPumps*1e6)                       annotation (Placement(
        transformation(extent={{-40,50},{-60,70}},   rotation=0)));
  Modelica.Blocks.Continuous.LimPID FBctrl_W_pump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.0125318684948903,
    xi_start=FBctrl_W_pump.y_start/FBctrl_W_pump.k,
    y_start=9736.677,
    gainPID(y(start=FBctrl_W_pump.y_start)),
    yMax=12500,
    yMin=1250,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Ti=8.60505190607221) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,30})));
  Modelica.Blocks.Sources.RealExpression mH2O(y=capacityScaler*mp_plant_kg_s)
    annotation (Placement(transformation(extent={{-60,74},{-80,94}})));
  Modelica.Blocks.Sources.RealExpression W_RO(y=capacityScaler*pumpingSystem.multiSensor.power
        *NoPumps)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Modelica.Blocks.Math.Gain load_per_pump(k=1/NoPumps) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={-76,60})));
equation
  SaltRejection = rO_unit.SaltRejection;
  OverallRecoveryRatio = rO_unit.OverallRecoveryRatio;
  mp_plant_kg_s = -rO_unit.flowJoin.port_2.m_flow * NoVesselUnits;
  Qp_plant_gpd = rO_unit.Qp_total_m3_hr * (264.172*24) * NoVesselUnits;

  connect(permeateSink.ports[1], rO_unit.permeateFlange) annotation (Line(
        points={{30,-60},{30,-60},{0,-60},{0,-35}},
                                                  color={0,127,255}));
  connect(retentateSink.ports[1], PCV.port_b)
    annotation (Line(points={{80,-20},{60,-20}},
                                             color={0,127,255}));
  connect(PCV.port_a, rO_unit.retentateFlange)
    annotation (Line(points={{40,-20},{11,-20}},
                                             color={0,127,255}));
  connect(pumpingSystem.port_b, rO_unit.feedFlange)
    annotation (Line(points={{-40,-20},{-11,-20}},
                                               color={0,127,255}));
  connect(brineSource.ports[1], pumpingSystem.port_a)
    annotation (Line(points={{-80,-20},{-60,-20}},
                                               color={0,127,255}));
  connect(p_feed_meas.port, pumpingSystem.port_b) annotation (Line(points={{-20,40},
          {-20,40},{-20,-16},{-20,-20},{-40,-20}},
                                                 color={0,127,255}));
  connect(actuator_p_feed.y, PCV.opening)
    annotation (Line(points={{50,-1},{50,-1},{50,-12}},
                                                      color={0,0,127}));
  connect(FBctrl_p_feed.y, actuator_p_feed.u)
    annotation (Line(points={{21,50},{50,50},{50,22}}, color={0,0,127}));
  connect(p_feed_meas.p, FBctrl_p_feed.u_s)
    annotation (Line(points={{-9,50},{-2,50}}, color={0,0,127}));
  connect(p_feed_set.y, FBctrl_p_feed.u_m)
    annotation (Line(points={{10,21},{10,21},{10,38}}, color={0,0,127}));
  connect(pumpingSystem.Load, FBctrl_W_pump.u_m)
    annotation (Line(points={{-60.2,-16},{-70,-16},{-70,18}},
                                                          color={0,0,127}));
  connect(FBctrl_W_pump.y, pumpingSystem.Voltage)
    annotation (Line(points={{-59,30},{-50,30},{-50,-10.2}},
                                                           color={0,0,127}));
  connect(load_per_pump.u, power_set.y)
    annotation (Line(points={{-71.2,60},{-61,60}}, color={0,0,127}));
  connect(load_per_pump.y, FBctrl_W_pump.u_s) annotation (Line(points={{-80.4,
          60},{-90,60},{-90,30},{-82,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=500,
      Interval=1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end RO_plant_closedLoop;
