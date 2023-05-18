within NHES.ExperimentalSystems.TEDS.Obselete_Files_from_Building;
model TEDSloop
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-42,32},{-22,52}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    m_flow=0.689,
    T=498.15,
    nPorts=1) annotation (Placement(transformation(extent={{-62,-8},{-42,12}})));
  Modelica.Blocks.Sources.Step step(height=0, offset=200e3)
    annotation (Placement(transformation(extent={{-84,32},{-64,52}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_a_start=boundary.T,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
        (nV=1, dimensions=fill(0.076, pipe1.nV)),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal)
    annotation (Placement(transformation(extent={{-12,-10},{12,14}})));

  Modelica.Fluid.Sensors.Temperature temperature_entrance(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{-36,-14},{-16,-34}})));
  Modelica.Fluid.Sensors.Temperature temperature_exit(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{10,-14},{30,-34}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=200000,
    T=498.15,
    nPorts=1) annotation (Placement(transformation(extent={{56,-8},{36,12}})));
equation
  connect(step.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-63,42},{-42,42}}, color={0,0,127}));
  connect(boundary.ports[1], pipe1.port_a)
    annotation (Line(points={{-42,2},{-12,2}}, color={0,127,255}));
  connect(pipe1.port_a, temperature_entrance.port) annotation (Line(points={{
          -12,2},{-22,2},{-22,-14},{-26,-14}}, color={0,127,255}));
  connect(pipe1.port_b, temperature_exit.port) annotation (Line(points={{12,2},
          {16,2},{16,-14},{20,-14}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, pipe1.heatPorts[1, 1])
    annotation (Line(points={{-22,42},{0,42},{0,8}}, color={191,0,0}));
  connect(pipe1.port_b, boundary1.ports[1])
    annotation (Line(points={{12,2},{36,2}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=500,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk45a"));
end TEDSloop;
