within NHES.Electrolysis.Separator.Examples;
model FlashDrum_H2Recycled_test
  extends Modelica.Icons.Example;

  Temp_flashDrum temp_flashDrum(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,0})));
  Modelica.Fluid.Sources.MassFlowSource_T feed(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    X={0.337643,0.662357},
    m_flow=1.35415,
    T=618.331)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={30,30})));

  Modelica.Blocks.Sources.Ramp feed_signal(
    duration=10,
    offset=1.35415,
    height=-0.3,
    startTime=10) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,60})));
  Modelica.Fluid.Sources.Boundary_pT H2_prod_sink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1960350,
    T=618.331) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,-30})));

  Modelica.Fluid.Sources.Boundary_pT H2O_sink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=1960350,
    T=618.331) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,0})));

  Fittings.IdealRecycle_H2 idealRecycle_H2(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
  Modelica.Blocks.Sources.Ramp H2_recycled_CtrlSignal(
    duration=10,
    startTime=10,
    height=0,
    offset=0.0557585) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,40})));
  Modelica.Fluid.Sources.Boundary_pT H2_recycled_sink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=2045000,
    T=556.55) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,4})));

equation
  connect(feed.ports[1], temp_flashDrum.feedInlet) annotation (Line(
        points={{30,20},{30,20},{30,8}}, color={0,127,255}));
  connect(temp_flashDrum.liquidOutlet, H2O_sink.ports[1]) annotation (
      Line(points={{39,0},{39,8.88178e-016},{60,8.88178e-016}},
                                             color={0,127,255}));
  connect(feed_signal.y, feed.m_flow_in) annotation (Line(points={{21,60},
          {21,60},{38,60},{38,40}}, color={0,0,127}));
  connect(temp_flashDrum.vaporOutlet, idealRecycle_H2.H2_feed)
    annotation (Line(points={{21,0},{0,0}}, color={0,127,255}));
  connect(idealRecycle_H2.H2_prod, H2_prod_sink.ports[1]) annotation (
      Line(points={{-16,-5},{-30,-5},{-30,-30},{-40,-30}}, color={0,127,
          255}));
  connect(H2_recycled_CtrlSignal.y, idealRecycle_H2.c_yH2) annotation (
      Line(points={{-19,40},{-4,40},{-4,2.2}}, color={0,0,127}));
  connect(H2_recycled_sink.ports[1], idealRecycle_H2.H2_recycle)
    annotation (Line(points={{-40,4},{-16,4},{-16,5}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=100, Interval=1),
    __Dymola_experimentSetupOutput);
end FlashDrum_H2Recycled_test;
