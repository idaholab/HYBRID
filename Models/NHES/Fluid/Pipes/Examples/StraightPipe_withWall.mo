within NHES.Fluid.Pipes.Examples;
model StraightPipe_withWall
extends Modelica.Icons.Example;

  NHES.Fluid.Pipes.StraightPipe_withWall pipe(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    length=1,
    diameter=0.01,
    redeclare package Wall_Material = Media.Solids.SS316,
    redeclare model HeatTransfer =
        Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    th_wall=0.006,
    nRadial=5,
    p_a_start=Sink.p + 1000,
    p_b_start=Sink.p,
    T_a_start=Source.T,
    T_b_start=Source.T,
    m_flow_a_start=Source.m_flow)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Thermal.HeatTransfer.Components.Convection convection[pipe.nV]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,28})));
  Modelica.Blocks.Sources.Constant const[pipe.nV](each k=5000*Modelica.Constants.pi
        *2*0.011*1/pipe.nV)
    annotation (Placement(transformation(extent={{-60,18},{-40,38}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature[pipe.nV](each T=
        473.15)
    annotation (Placement(transformation(extent={{-30,49},{-10,71}})));
  Modelica.Fluid.Sources.Boundary_pT Sink(
    nPorts=1,
    p=100000,
    T=323.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T Source(
    nPorts=1,
    m_flow=0.05,
    T=293.15,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  inner NHES.Fluid.System_TP system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(convection.solid, pipe.heatPorts)
    annotation (Line(points={{0,18},{0,4.4},{0.1,4.4}}, color={191,0,0}));
  connect(const.y, convection.Gc)
    annotation (Line(points={{-39,28},{-26,28},{-10,28}}, color={0,0,127}));
  connect(fixedTemperature.port, convection.fluid) annotation (Line(points={{-10,
          60},{-6,60},{0,60},{0,38}}, color={191,0,0}));
  connect(Source.ports[1], pipe.port_a)
    annotation (Line(points={{-68,0},{-40,0},{-10,0}}, color={0,127,255}));
  connect(Sink.ports[1], pipe.port_b)
    annotation (Line(points={{50,0},{30,0},{10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StraightPipe_withWall;
