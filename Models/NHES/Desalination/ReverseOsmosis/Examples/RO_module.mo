within NHES.Desalination.ReverseOsmosis.Examples;
model RO_module
  extends Modelica.Icons.Example;

  final parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";

  RO_unit rO_unit(redeclare package Medium =
        Media.BrineProp.BrineDriesner,
      NoVesselUnits_per_pump=NoVesselUnits_per_pump)
    annotation (Placement(transformation(extent={{-10,-14},{10,6}})));
  Modelica.Fluid.Sources.MassFlowSource_T brineSource(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    T=298.2818)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Blocks.Sources.Ramp brineFlowRate(
    startTime=10,
    offset=4.36917117117117*NoVesselUnits_per_pump,
    height=-0.1*(4.36917117117117*NoVesselUnits_per_pump),
    duration=5)
    annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p=1486890)                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,0})));
  Modelica.Fluid.Sources.Boundary_pT permeateSink(
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p=101325) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,-46})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(brineSource.ports[1], rO_unit.feedFlange)
    annotation (Line(points={{-28,0},{-11,0}}, color={0,127,255}));
  connect(brineFlowRate.y, brineSource.m_flow_in)
    annotation (Line(points={{-59,8},{-48,8}},   color={0,0,127}));
  connect(retentateSink.ports[1], rO_unit.retentateFlange)
    annotation (Line(points={{50,0},{11,0}}, color={0,127,255}));
  connect(permeateSink.ports[1], rO_unit.permeateFlange) annotation (Line(
        points={{10,-46},{6,-46},{0,-46},{0,-15}},color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RO_module;
