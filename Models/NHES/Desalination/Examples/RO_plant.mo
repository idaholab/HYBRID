within NHES.Desalination.Examples;
model RO_plant
  extends Modelica.Icons.Example;

  final parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";

  ReverseOsmosis.RO_unit rO_unit(redeclare package Medium =
        Media.BrineProp.BrineDriesner, NoVesselUnits_per_pump=
        NoVesselUnits_per_pump)
    annotation (Placement(transformation(extent={{10,-14},{30,6}})));
  Modelica.Fluid.Sources.MassFlowSource_T brineSource(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    T=298.2818)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Modelica.Blocks.Sources.Ramp brineFlowRate(
    startTime=10,
    offset=4.36917117117117*NoVesselUnits_per_pump,
    height=-0.1*(4.36917117117117*NoVesselUnits_per_pump),
    duration=5)
    annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
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
        origin={40,-46})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Valves.ValveLinear PCV(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    dp_nominal=0.8*((14.8689 - 11.89512)*1e5),
    m_flow(start=PCV.m_flow_nominal),
    m_flow_nominal=1.21876*NoVesselUnits_per_pump,
    m_flow_start=PCV.m_flow_nominal,
    dp_start=PCV.dp_nominal/0.8)        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={60,0})));
  Modelica.Blocks.Sources.Ramp PCV_opening(
    height=0,
    duration=0,
    offset=0.8,
    startTime=10)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
equation
  connect(brineSource.ports[1], rO_unit.feedFlange)
    annotation (Line(points={{-8,0},{9,0}},    color={0,127,255}));
  connect(brineFlowRate.y, brineSource.m_flow_in)
    annotation (Line(points={{-39,8},{-34,8},{-28,8}},
                                                 color={0,0,127}));
  connect(permeateSink.ports[1], rO_unit.permeateFlange) annotation (Line(
        points={{30,-46},{30,-46},{20,-46},{20,-15}},
                                                  color={0,127,255}));
  connect(retentateSink.ports[1], PCV.port_b)
    annotation (Line(points={{80,0},{70,0}}, color={0,127,255}));
  connect(PCV.port_a, rO_unit.retentateFlange)
    annotation (Line(points={{50,0},{31,0}}, color={0,127,255}));
  connect(PCV_opening.y, PCV.opening)
    annotation (Line(points={{79,50},{60,50},{60,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RO_plant;
