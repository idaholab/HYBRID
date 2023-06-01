within NHES.TestModels_AS;
model HeatingFlowThroughPipeWithWall_TwoPhase
  import TRANSFORM;
extends TRANSFORM.Icons.Example;
  package Medium=Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"},
                                             C_nominal={1.519E-3});
  TRANSFORM.Fluid.Pipes.GenericPipe_withWall pipe(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_a_start=0.1,
    use_HeatTransferOuter=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    energyDynamics_wall=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wall.StraightPipe (
        dimension=0.1,
        nV=1,
        nR=1),
    p_a_start=100000,
    T_a_start=323.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    nPorts=1,
    p(displayUnit="kPa") = 105000,
    T=323.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{96,-10},{76,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Source(
    nPorts=1,
    m_flow=0.1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_C_in=false,
    T=293.15)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
  inner TRANSFORM.Fluid.System    system
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow    boundary1[
    pipe.nV](Q_flow(displayUnit="MW") = 100000)
             annotation (Placement(transformation(extent={{28,12},{8,32}})));
  TRANSFORM.Utilities.ErrorAnalysis.UnitTests unitTests(x={pipe.pipe.mediums[1].T})
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TempIn(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TempOut(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
equation
  connect(boundary1.port, pipe.heatPorts) annotation (Line(
      points={{8,22},{0,22},{0,5}},
      color={191,0,0},
      thickness));
  connect(Source.ports[1], TempIn.port_a) annotation (Line(points={{-76,0},{-52,0}}, color={0,127,255}));
  connect(TempIn.port_b, pipe.port_a) annotation (Line(points={{-32,0},{-10,0}}, color={0,127,255}));
  connect(Sink.ports[1], TempOut.port_b) annotation (Line(points={{76,0},{52,0}}, color={0,127,255}));
  connect(TempOut.port_a, pipe.port_b) annotation (Line(points={{32,0},{10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end HeatingFlowThroughPipeWithWall_TwoPhase;
