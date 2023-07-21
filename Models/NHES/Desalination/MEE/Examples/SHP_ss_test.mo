within NHES.Desalination.MEE.Examples;
model SHP_ss_test "Test of a single effect with constant UA"

  Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss
    annotation (Placement(transformation(extent={{-44,-32},{44,56}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(
      Q_flow=1000000)
    annotation (Placement(transformation(extent={{-94,-70},{-74,-50}})));
equation
  connect(boundary.port, evaporator_Brine_SHP_ss.Heat_Port)
    annotation (Line(points={{-74,-60},{0,-60},{0,-32}}, color={191,0,0}));
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
end SHP_ss_test;
