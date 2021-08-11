within NHES.Systems.PrimaryHeatSystem.HTGR.Examples;
model HTGR_System_Example
  extends Modelica.Icons.Example;
  NHES.Systems.PrimaryHeatSystem.HTGR.Nuclear_loop_HTGR_Integrable
    nuclear_loop_HTGR_Integrable(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.CS_One CS)
    annotation (Placement(transformation(extent={{-30,-22},{30,28}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    T=373.15,
    nPorts=1) annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-76,-36},{-56,-16}})));
  TRANSFORM.Electrical.Grid grid(Q_nominal=250000000)
    annotation (Placement(transformation(extent={{60,-6},{80,14}})));
equation
  connect(boundary2.ports[1], nuclear_loop_HTGR_Integrable.port_a) annotation (
      Line(points={{-70,16},{-40,16},{-40,12.5},{-31.2,12.5}}, color={0,127,255}));
  connect(boundary1.ports[1], nuclear_loop_HTGR_Integrable.port_b) annotation (
      Line(points={{-56,-26},{-40,-26},{-40,-7},{-31.2,-7}}, color={0,127,255}));
  connect(grid.port, nuclear_loop_HTGR_Integrable.e_port)
    annotation (Line(points={{60,4},{36,4},{36,7},{30.6,7}}, color={255,0,0}));
  annotation (experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"));
end HTGR_System_Example;
