within NHES.Desalination.ReverseOsmosis.Examples;
model RO_2nd_pass
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T brineSource(
    use_m_flow_in=true,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.00671314}),
    T=298.5436,
    nPorts=1)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Ramp brineFlowRate(
    duration=0,
    height=0,
    startTime=10,
    offset=2.26915)
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    redeclare package Medium =
        Desalination.Media.BrineProp.BrineDriesner,
    p=1486890,
    nPorts=1)                         annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={46,0})));
  Modelica.Fluid.Sources.Boundary_pT permeateSink(
    redeclare package Medium =
        NHES.Desalination.Media.BrineProp.BrineDriesner,
    p=101325,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,-40})));
  MembraneElements VesselsStage2(initOpt=Desalination.Utilities.Options.steadyState,
    Tf_start_K(displayUnit="degC") = 298.5436,
    Xif_NaCl_start=0.00671314,
    Xip_NaCl_start=0.000119863,
    wf_start=2.26915,
    Re_b_start=129.56,
    Xir_NaCl_start=0.0123956,
    wr_start=1.21876,
    Lv_b_start=9.27769e-12,
    Pf_start=1553150,
    Pr_start=1486890,
    Osmotic_Pstart_Pa=909321,
    Tr_start_K=298.7475)
    annotation (Placement(transformation(extent={{-12,-14},{12,10}})));
equation
  connect(brineFlowRate.y, brineSource.m_flow_in) annotation (Line(points={{-69,
          20},{-64,20},{-60,20},{-60,8},{-50,8}}, color={0,0,127}));
  connect(brineSource.ports[1], VesselsStage2.FeedFlange) annotation (Line(
        points={{-30,0},{-10.8,0},{-10.8,-0.08}}, color={0,127,255}));
  connect(retentateSink.ports[1], VesselsStage2.RetentateFlange) annotation (
      Line(points={{36,0},{10.8,0},{10.8,-0.08}}, color={0,127,255}));
  connect(permeateSink.ports[1], VesselsStage2.PermeateFlange)
    annotation (Line(points={{10,-40},{0,-40},{0,-10.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end RO_2nd_pass;
