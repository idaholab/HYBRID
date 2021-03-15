within NHES.Electrolysis.Fittings.Examples;
model H2RecycleIdeal_teeJunction_test
  extends Modelica.Icons.Example;

  BaseClasses.MediumConverter mediumConverter(redeclare package Medium_port_b =
        Electrolysis.Media.Electrolysis.CathodeGas, redeclare package
      Medium_port_a = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,-38},{-18,-18}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedWaterIn(
    nPorts=1,
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=556.55)
    annotation (Placement(transformation(extent={{-68,-38},{-48,-18}})));
  Modelica.Blocks.Sources.Ramp feedWaterFlow(
    duration=0,
    offset=4.48467,
    height=-0.2,
    startTime=100)      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-88,-20})));
  Modelica.Fluid.Sources.MassFlowSource_T H2Recycled(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    X={1,0},
    T=556.55,
    nPorts=1)
    annotation (Placement(transformation(extent={{66,44},{86,64}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package
      Medium =         Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{52,-38},{72,-18}})));
  Modelica.Fluid.Sensors.MassFractions cathode_XH2_in(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas, substanceName=
        "H2")
    annotation (Placement(transformation(extent={{72,-6},{92,14}})));
  Controllers.FFcontroller_XH2 FFctrl_yH2(initialOutput=0.055756419)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Fluid.Sensors.MassFlowRate wSteam(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  Modelica.Blocks.Sources.Constant yH2in_set(k=0.1)
    annotation (Placement(transformation(extent={{-34,-10},{-18,6}})));
  Modelica.Blocks.Math.Feedback feedback_wSteam annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={0,26})));
  Modelica.Fluid.Sensors.MassFlowRate wH2_recycled(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={62,26})));
  Modelica.Blocks.Continuous.PI FBctrl_yH2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.055756419,
    k=0.1,
    T=2,
    x_start=0.055756419/FBctrl_yH2.k)
    annotation (Placement(transformation(extent={{10,54},{26,70}})));
  Modelica.Fluid.Sources.Boundary_pT feedWaterSink(
    use_p_in=false,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{112,-38},{92,-18}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_yH2(
    k=1,
    T=10,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={46,62})));
equation
  connect(feedWaterFlow.y, feedWaterIn.m_flow_in)
    annotation (Line(points={{-77,-20},{-68,-20}}, color={0,0,127}));
  connect(feedWaterIn.ports[1], mediumConverter.port_a)
    annotation (Line(points={{-48,-28},{-38.2,-28}}, color={0,127,255}));
  connect(mediumConverter.port_b, wSteam.port_a)
    annotation (Line(points={{-18,-28},{-10,-28}}, color={0,127,255}));
  connect(wSteam.port_b, teeJunctionIdeal.port_1) annotation (Line(points={{10,-28},
          {52,-28}},                   color={0,127,255}));
  connect(wSteam.m_flow, FFctrl_yH2.u_m)
    annotation (Line(points={{0,-17},{0,-11}},color={0,0,127}));
  connect(FFctrl_yH2.u_s_yH2in, yH2in_set.y)
    annotation (Line(points={{-9,-2},{-14,-2},{-17.2,-2}},
                                                        color={0,0,127}));
  connect(FFctrl_yH2.y, feedback_wSteam.u1)
    annotation (Line(points={{0,7},{0,7},{0,18}},   color={0,0,127}));
  connect(wH2_recycled.m_flow, feedback_wSteam.u2)
    annotation (Line(points={{51,26},{51,26},{8,26}}, color={0,0,127}));
  connect(wH2_recycled.port_b, teeJunctionIdeal.port_3)
    annotation (Line(points={{62,16},{62,2},{62,-18}}, color={0,127,255}));
  connect(feedback_wSteam.y, FBctrl_yH2.u)
    annotation (Line(points={{0,35},{0,62},{8.4,62}}, color={0,0,127}));
  connect(cathode_XH2_in.port, teeJunctionIdeal.port_2) annotation (Line(
        points={{82,-6},{82,-26},{82,-28},{72,-28}}, color={0,127,255}));
  connect(feedWaterSink.ports[1], teeJunctionIdeal.port_2) annotation (Line(
        points={{92,-28},{82,-28},{72,-28}},  color={0,127,255}));
  connect(FBctrl_yH2.y, actuator_yH2.u) annotation (Line(points={{26.8,62},
          {34,62},{36.4,62}}, color={0,0,127}));
  connect(actuator_yH2.y, H2Recycled.m_flow_in)
    annotation (Line(points={{54.8,62},{66,62}}, color={0,0,127}));
  connect(H2Recycled.ports[1], wH2_recycled.port_a) annotation (Line(points=
         {{86,54},{92,54},{92,42},{62,42},{62,36}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=1000, Interval=1),
    __Dymola_experimentSetupOutput);
end H2RecycleIdeal_teeJunction_test;
