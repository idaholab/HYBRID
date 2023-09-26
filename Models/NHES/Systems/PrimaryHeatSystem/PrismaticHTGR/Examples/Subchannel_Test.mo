within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Examples;
model Subchannel_Test
   extends Modelica.Icons.Example;
  PrismaticHTGR.Components.Subchannel subchannel(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow=0.5,
    T=773.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare package
              Medium =
               Modelica.Media.IdealGases.SingleGases.He, nPorts=1)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=10000)
    annotation (Placement(transformation(extent={{-70,18},{-50,38}})));
equation
  connect(boundary.ports[1], subchannel.port_a)
    annotation (Line(points={{-80,0},{-40,0}}, color={0,127,255}));
  connect(subchannel.port_b, boundary1.ports[1])
    annotation (Line(points={{40,0},{80,0}}, color={0,127,255}));
  connect(realExpression.y, subchannel.PowerIn)
    annotation (Line(points={{-49,28},{-28,28}},         color={0,0,127}));
  annotation (experiment(
      StopTime=10000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end Subchannel_Test;
