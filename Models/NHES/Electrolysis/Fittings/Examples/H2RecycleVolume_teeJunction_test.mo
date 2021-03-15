within NHES.Electrolysis.Fittings.Examples;
model H2RecycleVolume_teeJunction_test
  extends Modelica.Icons.Example;

  BaseClasses.MediumConverter mediumConverter(redeclare package Medium_port_b =
        Electrolysis.Media.Electrolysis.CathodeGas, redeclare package
      Medium_port_a = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-36,-38},{-16,-18}})));
  Modelica.Fluid.Sources.Boundary_pT feedWaterSink(
    use_p_in=false,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{106,-38},{86,-18}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedWaterIn(
    nPorts=1,
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=556.55)
    annotation (Placement(transformation(extent={{-66,-38},{-46,-18}})));
  Modelica.Blocks.Sources.Ramp feedWaterFlow(
    duration=0,
    offset=4.48467,
    height=-0.2,
    startTime=100)      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-20})));
  Modelica.Fluid.Sources.MassFlowSource_T H2Recycled(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X={1,0},
    m_flow=0.055756419,
    T=556.55,
    nPorts=1)
    annotation (Placement(transformation(extent={{64,42},{84,62}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume mixer_H2Recycled(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    X_start=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}),
    medium(X(start=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {
            Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,
            Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}))),
    use_T_start=true,
    V=0.125,
    p_start=2045000,
    T_start=556.55)
    annotation (Placement(transformation(extent={{50,-38},{70,-18}})));

  Modelica.Fluid.Sensors.MassFlowRate wSteam(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  Controllers.FFcontroller_XH2 FFctrl_yH2(initialOutput=0.055756419)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Constant yH2in_set(k=0.1)
    annotation (Placement(transformation(extent={{-34,-10},{-18,6}})));
  Modelica.Fluid.Sensors.MassFlowRate wH2_recycled(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,22})));
  Modelica.Blocks.Math.Feedback feedback_wSteam annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={0,22})));
  Modelica.Blocks.Continuous.PI FBctrl_yH2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.055756419,
    k=0.1,
    T=2,
    x_start=0.055756419/FBctrl_yH2.k)
    annotation (Placement(transformation(extent={{12,52},{28,68}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_yH2(
    k=1,
    T=10,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={46,60})));
equation
  connect(feedWaterFlow.y, feedWaterIn.m_flow_in) annotation (Line(points={
          {-79,-20},{-74,-20},{-66,-20}}, color={0,0,127}));
  connect(feedWaterIn.ports[1], mediumConverter.port_a)
    annotation (Line(points={{-46,-28},{-36.2,-28}}, color={0,127,255}));
  connect(mixer_H2Recycled.port_2, feedWaterSink.ports[1])
    annotation (Line(points={{70,-28},{86,-28}}, color={0,127,255}));
  connect(mediumConverter.port_b, wSteam.port_a)
    annotation (Line(points={{-16,-28},{-10,-28}}, color={0,127,255}));
  connect(wSteam.port_b, mixer_H2Recycled.port_1)
    annotation (Line(points={{10,-28},{50,-28}}, color={0,127,255}));
  connect(FFctrl_yH2.u_s_yH2in, yH2in_set.y) annotation (Line(points={{-9,-2},
          {-9,-2},{-17.2,-2}},      color={0,0,127}));
  connect(wSteam.m_flow, FFctrl_yH2.u_m)
    annotation (Line(points={{0,-17},{0,-11}}, color={0,0,127}));
  connect(feedback_wSteam.u1, FFctrl_yH2.y)
    annotation (Line(points={{0,14},{0,7}}, color={0,0,127}));
  connect(feedback_wSteam.u2, wH2_recycled.m_flow)
    annotation (Line(points={{8,22},{49,22}}, color={0,0,127}));
  connect(mixer_H2Recycled.port_3, wH2_recycled.port_b)
    annotation (Line(points={{60,-18},{60,12}}, color={0,127,255}));
  connect(feedback_wSteam.y, FBctrl_yH2.u)
    annotation (Line(points={{0,31},{0,60},{10.4,60}},color={0,0,127}));
  connect(FBctrl_yH2.y, actuator_yH2.u)
    annotation (Line(points={{28.8,60},{36.4,60}}, color={0,0,127}));
  connect(actuator_yH2.y, H2Recycled.m_flow_in)
    annotation (Line(points={{54.8,60},{64,60}}, color={0,0,127}));
  connect(H2Recycled.ports[1], wH2_recycled.port_a) annotation (Line(points=
         {{84,52},{90,52},{90,40},{60,40},{60,32}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=1000, Interval=1),
    __Dymola_experimentSetupOutput);
end H2RecycleVolume_teeJunction_test;
