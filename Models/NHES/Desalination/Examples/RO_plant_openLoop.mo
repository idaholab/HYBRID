within NHES.Desalination.Examples;
model RO_plant_openLoop
  extends Modelica.Icons.Example;

  final parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";

  ReverseOsmosis.RO_unit rO_unit(redeclare package Medium =
        Media.BrineProp.BrineDriesner, NoVesselUnits_per_pump=
        NoVesselUnits_per_pump)
    annotation (Placement(transformation(extent={{-10,-14},{10,6}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p=1189512)                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,0})));
  Modelica.Fluid.Sources.Boundary_pT permeateSink(
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p=101325) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-40})));
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
        origin={50,0})));
  Machines.PumpingSystem
                pumpingSystem(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    V=1,
    NoPumps=1,
    NoVesselUnits_per_pump=NoVesselUnits_per_pump)
         annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
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
        origin={-90,0})));
  Modelica.Fluid.Sensors.Pressure p_feed_meas(redeclare package Medium =
        Media.BrineProp.BrineDriesner)
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_p_feed(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,30})));
  Modelica.Blocks.Sources.Ramp Voltage_signal(
    duration=0,
    offset=9736.677,
    startTime=100,
    height=-2650*0 - 486.83385)
                     annotation (Placement(transformation(extent={{-90,30},{-70,
            50}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp PCV_opening(
    duration=0,
    offset=0.8,
    startTime=300,
    height=-0.04*0 + 0.2)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(permeateSink.ports[1], rO_unit.permeateFlange) annotation (Line(
        points={{30,-40},{30,-40},{0,-40},{0,-15}},
                                                  color={0,127,255}));
  connect(retentateSink.ports[1], PCV.port_b)
    annotation (Line(points={{80,0},{60,0}}, color={0,127,255}));
  connect(PCV.port_a, rO_unit.retentateFlange)
    annotation (Line(points={{40,0},{11,0}}, color={0,127,255}));
  connect(pumpingSystem.port_b, rO_unit.feedFlange)
    annotation (Line(points={{-40,0},{-11,0}}, color={0,127,255}));
  connect(brineSource.ports[1], pumpingSystem.port_a)
    annotation (Line(points={{-80,0},{-60,0}}, color={0,127,255}));
  connect(p_feed_meas.port, pumpingSystem.port_b) annotation (Line(points={{-20,60},
          {-20,60},{-20,4},{-20,0},{-40,0}},     color={0,127,255}));
  connect(actuator_p_feed.y, PCV.opening)
    annotation (Line(points={{50,19},{50,19},{50,8}}, color={0,0,127}));
  connect(PCV_opening.y, actuator_p_feed.u)
    annotation (Line(points={{41,60},{50,60},{50,42}}, color={0,0,127}));
  connect(Voltage_signal.y, pumpingSystem.Voltage)
    annotation (Line(points={{-69,40},{-50,40},{-50,9.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=400,
      Interval=0.1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end RO_plant_openLoop;
