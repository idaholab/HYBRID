within NHES.Systems.PrimaryHeatSystem.HTGR;
model Basic_loop_DNE

  replaceable package Medium = BaseClasses.He_HighT;
  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp[10];
  TRANSFORM.Fluid.Pipes.GenericPipe_withWall pipe1(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wall.StraightPipe
        (
        dimension=0.1,
        length=20,
        nV=10),
    nParallel=200,                                 redeclare package Medium = Medium,
    p_a_start=6500000,
    p_b_start=6200000,
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple,
    redeclare model InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gen=25e6))
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));

  TRANSFORM.Fluid.Volumes.SimpleVolume volume(redeclare package Medium = Medium,
    p_start=6200000,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,8})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume1(redeclare package Medium = Medium,
    p_start=6500000,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    nPorts_b=2,
    nPorts_a=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={58,28})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium = Medium,
      m_flow_nominal=120)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX heatExchanger(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
        (
        nV=10,
        nTubes=500,
        nR=2,
        dimension_shell=0.1,
        length_shell=50,
        dimension_tube=0.09,
        length_tube=50),
    redeclare package Medium_shell = Modelica.Media.Examples.TwoPhaseWater,
    redeclare package Medium_tube = BaseClasses.He_HighT,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model FlowModel_shell =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple)
    annotation (Placement(transformation(extent={{-64,40},{-44,60}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=1500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,46},{-92,66}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    use_m_flow_in=true,
    use_h_in=true,
    m_flow=1250,
    h=600e3,
    nPorts=1) annotation (Placement(transformation(extent={{-2,52},{-22,72}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = BaseClasses.He_HighT,
    p_spring=6800000,
    K=50000,
    opening_init=0.)
    annotation (Placement(transformation(extent={{86,-10},{106,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium = BaseClasses.He_HighT,
    p=6500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{146,-10},{126,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0,
    duration=5000,
    offset=80,
    startTime=500)
    annotation (Placement(transformation(extent={{106,70},{86,90}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-200e3,
    duration=30000,
    offset=600e3,
    startTime=20000)
    annotation (Placement(transformation(extent={{104,38},{84,58}})));
equation
  for i in 1:10 loop
    cp[i] = Medium.specificHeatCapacityCp(pipe1.pipe.mediums[i].state);
  end for;
  connect(heatExchanger.port_b_tube, pump.port_a) annotation (Line(points={{-44,50},
          {0,50}},                                           color={0,127,255}));
  connect(boundary1.ports[1], heatExchanger.port_a_shell) annotation (Line(
        points={{-22,62},{-38,62},{-38,54.6},{-44,54.6}},
                       color={0,127,255}));
  connect(boundary.ports[1], heatExchanger.port_b_shell) annotation (Line(
        points={{-92,56},{-92,54.6},{-64,54.6}},                    color={0,
          127,255}));
  connect(springBallValve.port_b, boundary2.ports[1])
    annotation (Line(points={{106,0},{126,0}},            color={0,127,255}));
  connect(volume1.port_b[1], springBallValve.port_a) annotation (Line(points={{58.5,22},
          {58.5,0},{86,0}},                   color={0,127,255}));
  connect(pump.port_b, volume1.port_a[1])
    annotation (Line(points={{20,50},{58,50},{58,34}}, color={0,127,255}));
  connect(volume1.port_b[2], pipe1.port_a) annotation (Line(points={{57.5,22},{57.5,
          -30},{0,-30}},             color={0,127,255}));
  connect(pipe1.port_b, volume.port_a)
    annotation (Line(points={{-20,-30},{-90,-30},{-90,2}},color={0,127,255}));
  connect(volume.port_b, heatExchanger.port_a_tube)
    annotation (Line(points={{-90,14},{-90,50},{-64,50}}, color={0,127,255}));
  connect(ramp.y, boundary1.m_flow_in) annotation (Line(points={{85,80},{52,80},
          {52,70},{-2,70}},               color={0,0,127}));
  connect(boundary1.h_in, ramp1.y) annotation (Line(points={{0,66},{76,66},{76,
          48},{83,48}},             color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Basic_loop_DNE;
