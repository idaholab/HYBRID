within NHES.Desalination.MEE.Examples;
model Utest "Test of a single effect with constant"

  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph cond_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_h Tube_Inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_h_in=true,
    m_flow=1,
    h=2706.9e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Components.SEE_Tube_Side_Ue          sEE_Tube_Side_Ue(Ax=15.8)
    annotation (Placement(transformation(extent={{-42,-38},{38,42}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
    boundary(T=343.15)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=inleth)
    annotation (Placement(transformation(extent={{-194,4},{-174,24}})));
  parameter Modelica.Blocks.Interfaces.RealOutput inleth=2706e3
    "Value of Real output";
  Modelica.Blocks.Sources.RealExpression
                               realExpression1(y=mdot)
    annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));

  parameter SI.MassFlowRate mdot=1 "Heat Transfer Area (Outside Tube Area)";
equation
  connect(realExpression.y, Tube_Inlet.h_in) annotation (Line(points={{-173,
          14},{-110,14},{-110,4},{-102,4}}, color={0,0,127}));
  connect(realExpression1.y, Tube_Inlet.m_flow_in) annotation (Line(points=
          {{-173,-22},{-112,-22},{-112,16},{-100,16},{-100,8}}, color={0,0,
          127}));
  connect(Tube_Inlet.ports[1], sEE_Tube_Side_Ue.port_a)
    annotation (Line(points={{-80,0},{-62,0},{-62,2},{-42,2}},
                                               color={0,127,255}));
  connect(sEE_Tube_Side_Ue.port_b, cond_out.ports[1])
    annotation (Line(points={{38,2},{60,2},{60,0},{80,0}},
                                             color={0,127,255}));
  connect(boundary.port, sEE_Tube_Side_Ue.heat_port)
    annotation (Line(points={{-40,70},{-2,70},{-2,26}},
                                                      color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),                               graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=500,
      Interval=0.5,
      __Dymola_Algorithm="Esdirk45a"));
end Utest;
