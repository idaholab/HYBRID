within NHES.Desalination.MEE.Examples;
model boilingTestsmoothconsatn "Test of a single effect with constant UA"

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph cond_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_h_in=true,
    m_flow=1,
    h=2706.9e3,
    nPorts=1) annotation (Placement(transformation(extent={{-100,-10},{-80,
            10}})));

  Components.SEE_Tube_Side_PoolBoiling_smoothconsant
                                       sEE_Tube_Side_PoolBoiling_smoothconsant(Ax=50)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
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
  parameter Modelica.Blocks.Interfaces.RealOutput mdot=1.0
    "Value of Real output";
  parameter SI.Area Ax=0.5e4 "Heat Transfer Area (Outside Tube Area)";
equation
  connect(Tube_Inlet.ports[1], sEE_Tube_Side_PoolBoiling_smoothconsant.Steam_Inlet_Port)
    annotation (Line(points={{-80,0},{-40,0}}, color={0,127,255}));
  connect(boundary.port, sEE_Tube_Side_PoolBoiling_smoothconsant.Heat_Port)
    annotation (Line(points={{-40,70},{0,70},{0,20}}, color={191,0,0}));
  connect(sEE_Tube_Side_PoolBoiling_smoothconsant.Liquid_Outlet_Port, cond_out.ports[
    1]) annotation (Line(points={{40,0},{80,0}}, color={0,127,255}));
  connect(realExpression.y, Tube_Inlet.h_in) annotation (Line(points={{-173,
          14},{-110,14},{-110,4},{-102,4}}, color={0,0,127}));
  connect(realExpression1.y, Tube_Inlet.m_flow_in) annotation (Line(points=
          {{-173,-22},{-112,-22},{-112,16},{-100,16},{-100,8}}, color={0,0,
          127}));
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
end boilingTestsmoothconsatn;
