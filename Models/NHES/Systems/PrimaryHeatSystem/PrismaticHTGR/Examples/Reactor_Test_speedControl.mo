within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Examples;
model Reactor_Test_speedControl
   extends Modelica.Icons.Example;
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,0},{80,20}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    p=3000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Reactor_speed RX(redeclare replaceable CS.CS_Texit_speedControl CS,
      controlRod(Pos(start=0.75, fixed=true)))
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
equation
  connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
          -24},{42,-30},{80,-30}}, color={0,127,255}));
  connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
          24},{74,10},{80,10}},  color={0,127,255}));
  annotation (experiment(
      StopTime=1000000,
      Interval=50,
      __Dymola_Algorithm="Esdirk45a"));
end Reactor_Test_speedControl;
