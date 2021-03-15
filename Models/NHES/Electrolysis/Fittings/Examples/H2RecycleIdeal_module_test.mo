within NHES.Electrolysis.Fittings.Examples;
model H2RecycleIdeal_module_test
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT feedWaterSink(
    use_p_in=false,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{66,-32},{46,-12}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedWaterIn(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    T=556.55)
    annotation (Placement(transformation(extent={{-66,-38},{-46,-18}})));
  Modelica.Blocks.Sources.Ramp feedWaterFlow(
    offset=4.48467,
    height=-0.2,
    startTime=100,
    duration=0)         annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-20})));
  Modelica.Fluid.Sources.MassFlowSource_T H2Recycled(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    X={1,0},
    m_flow=0.055756419,
    use_m_flow_in=true,
    nPorts=1,
    T=556.55) annotation (Placement(transformation(extent={{-18,-2},{-38,18}})));
  CascadeCtrlIdeal_yH2 cascadeCtrl_yH2(
    redeclare package MixtureGas =
        Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Steam = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    yH2_setPoint=0.1,
    V=0.125,
    initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
    TSteam_start=556.55)
    annotation (Placement(transformation(extent={{-28,-34},{-6,-10}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_yH2(
    k=1,
    T=10,
    y_start=0.055756419,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={2,16})));
equation
  connect(feedWaterFlow.y, feedWaterIn.m_flow_in) annotation (Line(points={
          {-79,-20},{-74,-20},{-66,-20}}, color={0,0,127}));
  connect(cascadeCtrl_yH2.mixtureGas_port_3, feedWaterSink.ports[1])
    annotation (Line(points={{-8.2,-22},{-8.2,-22},{46,-22}}, color={0,127,
          255}));
  connect(feedWaterIn.ports[1], cascadeCtrl_yH2.steam_port_2)
    annotation (Line(points={{-46,-28},{-25.8,-28}}, color={0,127,255}));
  connect(H2Recycled.ports[1], cascadeCtrl_yH2.mixtureGas_port_1)
    annotation (Line(points={{-38,8},{-44,8},{-44,-16},{-25.8,-16}}, color=
          {0,127,255}));
  connect(H2Recycled.m_flow_in, actuator_yH2.y)
    annotation (Line(points={{-18,16},{-6.8,16}}, color={0,0,127}));
  connect(cascadeCtrl_yH2.c_yH2, actuator_yH2.u) annotation (Line(points={{
          -12.6,-18.64},{-12.6,-14},{-12.6,-4},{20,-4},{20,16},{11.6,16}},
        color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=1000, Interval=1),
    __Dymola_experimentSetupOutput);
end H2RecycleIdeal_module_test;
