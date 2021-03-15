within NHES.Desalination.ReverseOsmosis.Examples;
model RO_1st_pass
  extends Modelica.Icons.Example;

  MembraneElements VesselsStage1(initOpt=Desalination.Utilities.Options.steadyState)
    annotation (Placement(transformation(extent={{-12,-14},{12,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T brineSource(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    T=298.2818)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Ramp brineFlowRate(
    duration=0,
    height=0,
    startTime=10,
    offset=4.36917117117117)
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    nPorts=1,
    redeclare package Medium =
        Desalination.Media.BrineProp.BrineDriesner,
    p=1553150)                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={46,0})));
  Modelica.Fluid.Sources.Boundary_pT permeateSink(
    nPorts=1,
    redeclare package Medium =
        NHES.Desalination.Media.BrineProp.BrineDriesner,
    p=101325) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,-40})));
equation
  connect(brineSource.ports[1], VesselsStage1.FeedFlange) annotation (Line(
        points={{-30,0},{-10.8,0},{-10.8,-0.08}}, color={0,127,255}));
  connect(brineFlowRate.y, brineSource.m_flow_in) annotation (Line(points={{-69,
          20},{-64,20},{-60,20},{-60,8},{-50,8}}, color={0,0,127}));
  connect(retentateSink.ports[1], VesselsStage1.RetentateFlange) annotation (
      Line(points={{36,0},{10.8,0},{10.8,-0.08}}, color={0,127,255}));
  connect(permeateSink.ports[1], VesselsStage1.PermeateFlange)
    annotation (Line(points={{10,-40},{0,-40},{0,-10.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end RO_1st_pass;
