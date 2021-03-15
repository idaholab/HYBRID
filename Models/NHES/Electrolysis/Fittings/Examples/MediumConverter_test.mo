within NHES.Electrolysis.Fittings.Examples;
model MediumConverter_test
  extends Modelica.Icons.Example;

  BaseClasses.MediumConverter mediumConverter(redeclare package Medium_port_b =
        Electrolysis.Media.Electrolysis.CathodeGas, redeclare package
      Medium_port_a = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Fluid.Sources.Boundary_pT feedWaterSink(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{54,0},{34,20}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedWaterIn(
    nPorts=1,
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_X_in=false,
    T=556.55)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.Ramp feedWaterFlow(
    duration=0,
    offset=4.48467,
    height=-0.2,
    startTime=100)      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,18})));
equation
  connect(mediumConverter.port_b, feedWaterSink.ports[1])
    annotation (Line(points={{10,10},{34,10}}, color={0,127,255}));
  connect(feedWaterFlow.y, feedWaterIn.m_flow_in)
    annotation (Line(points={{-79,18},{-60,18}}, color={0,0,127}));
  connect(feedWaterIn.ports[1], mediumConverter.port_a)
    annotation (Line(points={{-40,10},{-10.2,10}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end MediumConverter_test;
