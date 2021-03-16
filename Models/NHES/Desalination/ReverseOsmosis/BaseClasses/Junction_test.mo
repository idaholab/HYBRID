within NHES.Desalination.ReverseOsmosis.BaseClasses;
model Junction_test
  extends Modelica.Icons.Example;

  BaseClasses.Junction junction
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T brineSource(
    use_m_flow_in=true,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.00671314}),
    nPorts=1,
    T=298.5436)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Blocks.Sources.Ramp brineFlowRate(
    duration=0,
    height=0,
    startTime=10,
    offset=2.26915)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    redeclare package Medium =
        Desalination.Media.BrineProp.BrineDriesner,
    p=1486890,
    nPorts=1)                         annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,0})));
  Fluid.Pipes.parallelFlow nFlow_in(redeclare package Medium =
        Media.BrineProp.BrineDriesner, nParallel=2)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,0})));
  Fluid.Pipes.parallelFlow nFlow_out(redeclare package Medium =
        Media.BrineProp.BrineDriesner, nParallel=2)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,0})));
equation
  connect(brineFlowRate.y, brineSource.m_flow_in) annotation (Line(points={{-79,20},
          {-74,20},{-74,8},{-68,8}},     color={0,0,127}));
  connect(brineSource.ports[1], nFlow_in.port_a) annotation (Line(points={{-48,
          0},{-48,1.33227e-015},{-40,1.33227e-015}}, color={0,127,255}));
  connect(nFlow_in.port_b, junction.port_a) annotation (Line(points={{-20,
          -1.33227e-015},{-12,-1.33227e-015},{-12,0},{-8,0}}, color={0,127,255}));
  connect(retentateSink.ports[1], nFlow_out.port_a) annotation (Line(points={{
          50,0},{50,-1.22125e-015},{40,-1.22125e-015}}, color={0,127,255}));
  connect(nFlow_out.port_b, junction.port_b) annotation (Line(points={{20,
          1.22125e-015},{12,1.22125e-015},{12,0},{8,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Junction_test;
