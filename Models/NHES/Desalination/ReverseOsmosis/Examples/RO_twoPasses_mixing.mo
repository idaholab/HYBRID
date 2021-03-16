within NHES.Desalination.ReverseOsmosis.Examples;
model RO_twoPasses_mixing
  extends Modelica.Icons.Example;

  parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";

  MembraneElements VesselsStage1(initOpt=Desalination.Utilities.Options.steadyState)
    annotation (Placement(transformation(extent={{-42,-14},{-18,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T brineSource(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    T=298.2818)
    annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
  Modelica.Blocks.Sources.Ramp brineFlowRate(
    startTime=10,
    offset=4.36917117117117*NoVesselUnits_per_pump,
    height=-0.1*(4.36917117117117*NoVesselUnits_per_pump),
    duration=5)
    annotation (Placement(transformation(extent={{-20,38},{-40,58}})));
  Modelica.Fluid.Sources.Boundary_pT permeateSink(
    redeclare package Medium =
        NHES.Desalination.Media.BrineProp.BrineDriesner,
    p=101325,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-90})));

  MembraneElements VesselsStage2(initOpt=Desalination.Utilities.Options.steadyState,
    Tf_start_K(displayUnit="degC") = 298.5436,
    Xif_NaCl_start=0.00671314,
    Xip_NaCl_start=0.000119863,
    wf_start=2.26915,
    Pf_start=1553150,
    Pr_start=1486890,
    Osmotic_Pstart_Pa=909321,
    Re_b_start=129.56,
    Tr_start_K=298.7475,
    Xir_NaCl_start=0.0123956,
    wr_start=1.21876,
    Lv_b_start=9.27769e-12)
    annotation (Placement(transformation(extent={{18,-14},{42,10}})));
  Modelica.Fluid.Sources.Boundary_pT retentateSink(
    nPorts=1,
    redeclare package Medium =
        Desalination.Media.BrineProp.BrineDriesner,
    p=1486890)                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={100,0})));
  Fluid.Pipes.parallelFlow nFlow_feed(redeclare package Medium =
        Media.BrineProp.BrineDriesner, nParallel=NoVesselUnits_per_pump)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,0})));
  Fluid.Pipes.parallelFlow nFlow_retentate(redeclare package Medium =
        Media.BrineProp.BrineDriesner, nParallel=NoVesselUnits_per_pump)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,0})));
  Modelica.Fluid.Fittings.TeeJunctionVolume flowJoin(
    use_T_start=true,
    redeclare package Medium =
        NHES.Desalination.Media.BrineProp.BrineDriesner,
    V=1600,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    port_2(p(start=101325, fixed=true)),
    p_start=101325,
    T_start=298.45) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-14,-40})));

  Fluid.Pipes.parallelFlow nFlow_permeate(redeclare package Medium =
        Media.BrineProp.BrineDriesner, nParallel=NoVesselUnits_per_pump)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(VesselsStage1.RetentateFlange, VesselsStage2.FeedFlange)
    annotation (Line(points={{-19.2,-0.08},{19.2,-0.08}}, color={0,127,255}));
  connect(brineSource.ports[1], nFlow_feed.port_a) annotation (Line(points={{-80,
          40},{-90,40},{-90,1.33227e-015},{-80,1.33227e-015}}, color={0,127,255}));
  connect(nFlow_feed.port_b, VesselsStage1.FeedFlange) annotation (Line(points=
          {{-60,-1.33227e-015},{-40.8,-1.33227e-015},{-40.8,-0.08}}, color={0,
          127,255}));
  connect(brineSource.m_flow_in, brineFlowRate.y)
    annotation (Line(points={{-60,48},{-41,48}}, color={0,0,127}));
  connect(retentateSink.ports[1], nFlow_retentate.port_a) annotation (Line(
        points={{90,0},{85,0},{85,-1.22125e-015},{80,-1.22125e-015}}, color={0,
          127,255}));
  connect(nFlow_retentate.port_b, VesselsStage2.RetentateFlange) annotation (
      Line(points={{60,1.22125e-015},{40.8,0},{40.8,-0.08}}, color={0,127,255}));
  connect(VesselsStage1.PermeateFlange, flowJoin.port_1) annotation (Line(
        points={{-30,-10.4},{-30,-10.4},{-30,-40},{-24,-40}}, color={0,127,255}));
  connect(VesselsStage2.PermeateFlange, flowJoin.port_3) annotation (Line(
        points={{30,-10.4},{30,-20},{-14,-20},{-14,-30}}, color={0,127,255}));
  connect(flowJoin.port_2, nFlow_permeate.port_b)
    annotation (Line(points={{-4,-40},{0,-40},{0,-60}}, color={0,127,255}));
  connect(permeateSink.ports[1], nFlow_permeate.port_a)
    annotation (Line(points={{20,-90},{0,-90},{0,-80}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1500,
      Interval=0.1,
      Tolerance=1e-08,
      __Dymola_Algorithm="Esdirk45a"));
end RO_twoPasses_mixing;
