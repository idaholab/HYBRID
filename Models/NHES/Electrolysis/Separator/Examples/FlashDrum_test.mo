within NHES.Electrolysis.Separator.Examples;
model FlashDrum_test
  extends Modelica.Icons.Example;

  Temp_flashDrum temp_flashDrum(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T feed(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    X={0.337643,0.662357},
    m_flow=1.35415,
    T=618.331)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  Modelica.Blocks.Sources.Ramp feedSignal(
    duration=10,
    offset=1.35415,
    height=-0.3,
    startTime=10) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-68,8})));
  Modelica.Fluid.Sources.Boundary_pT H2_sink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=1960350,
    T=618.331) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,30})));

  Modelica.Fluid.Sources.Boundary_pT H2O_sink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=1960350,
    T=618.331) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-30})));

equation
  connect(feedSignal.y, feed.m_flow_in)
    annotation (Line(points={{-57,8},{-40,8}}, color={0,0,127}));
  connect(feed.ports[1], temp_flashDrum.feedInlet) annotation (Line(
        points={{-20,0},{-14,0},{-8,0}}, color={0,127,255}));
  connect(H2_sink.ports[1], temp_flashDrum.vaporOutlet)
    annotation (Line(points={{20,30},{0,30},{0,9}}, color={0,127,255}));
  connect(temp_flashDrum.liquidOutlet, H2O_sink.ports[1]) annotation (
      Line(points={{0,-9},{0,-30},{20,-30}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=100, Interval=1),
    __Dymola_experimentSetupOutput);
end FlashDrum_test;
