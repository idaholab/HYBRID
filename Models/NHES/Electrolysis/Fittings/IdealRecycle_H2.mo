within NHES.Electrolysis.Fittings;
model IdealRecycle_H2 "Split H2 ideally"
  import      Modelica.Units.SI;

  // ---------- Fluid package -------------------------------------------------
  replaceable package Medium = Electrolysis.Media.Electrolysis.CathodeGas
    constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model in the splitter"
                                                annotation (choicesAllMatching = true, Dialog(group="Working fluid (Medium)"));

  Modelica.Fluid.Interfaces.FluidPort_a H2_feed(redeclare package Medium = Medium, m_flow(
        min=0)) annotation (Placement(transformation(extent={{70,-10},{90,10}}),
        iconTransformation(extent={{70,-10},{90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b H2_recycle(redeclare package Medium = Medium,m_flow(max=0))
    annotation (Placement(transformation(extent={{-90,40},{-70,60}}), iconTransformation(
          extent={{-90,40},{-70,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b H2_prod(redeclare package Medium = Medium, m_flow(
        max=0)) annotation (Placement(transformation(extent={{-90,-60},{-70,-40}}),
        iconTransformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Interfaces.RealInput c_yH2(final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s") annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,100}),iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={40,22})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wH2_in(
    k=1,
    y_start=0.055756419,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=8)                                             annotation (
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=90,
        origin={0,74})));
  Modelica.Fluid.Sources.MassFlowSource_T H2Recycled(
    X={1,0},
    m_flow=0.055756419,
    use_m_flow_in=true,
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1,
    T=556.55) annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  Modelica.Fluid.Sources.Boundary_pT H2_sink(
    redeclare package Medium = Medium,
    nPorts=1,
    p=1960350,
    T=618.331)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={10,0})));
  Modelica.Fluid.Sources.MassFlowSource_T H2Produced(
    X={1,0},
    m_flow=0.055756419,
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=556.55)
    annotation (Placement(transformation(extent={{-20,-40},{-40,-60}})));
  Modelica.Blocks.Sources.Constant T_H2_sep_out(k=283.4 + 273.15)
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Modelica.Blocks.Math.Add mH2_prod(k1=-1)
    annotation (Placement(transformation(extent={{16,-66},{0,-50}})));
  Modelica.Fluid.Sensors.MassFlowRate mH2_recycled(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-50,60},{-70,40}})));
  Modelica.Fluid.Sensors.MassFlowRate mH2_total(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{68,10},{48,-10}})));
equation
  connect(c_yH2, actuator_wH2_in.u)
    annotation (Line(points={{0,100},{0,83.6}}, color={0,0,127}));
  connect(actuator_wH2_in.y, H2Recycled.m_flow_in)
    annotation (Line(points={{0,65.2},{0,58},{-20,58}}, color={0,0,127}));
  connect(H2Produced.ports[1], H2_prod)
    annotation (Line(points={{-40,-50},{-80,-50}}, color={0,127,255}));
  connect(T_H2_sep_out.y, H2Recycled.T_in) annotation (Line(points={{-1,30},
          {-10,30},{-10,54},{-18,54}}, color={0,0,127}));
  connect(H2_recycle, H2_recycle) annotation (Line(points={{-80,50},{-80,50},
          {-80,50}}, color={0,127,255}));
  connect(mH2_recycled.port_b, H2_recycle)
    annotation (Line(points={{-70,50},{-80,50}}, color={0,127,255}));
  connect(mH2_recycled.port_a, H2Recycled.ports[1]) annotation (Line(points=
         {{-50,50},{-45,50},{-40,50}}, color={0,127,255}));
  connect(H2Produced.T_in, T_H2_sep_out.y) annotation (Line(points={{-18,
          -54},{-10,-54},{-10,30},{-1,30}}, color={0,0,127}));
  connect(H2Produced.m_flow_in, mH2_prod.y) annotation (Line(points={{-20,-58},
          {-0.8,-58}},                 color={0,0,127}));
  connect(mH2_recycled.m_flow, mH2_prod.u1) annotation (Line(points={{-60,
          39},{-60,-30},{30,-30},{30,-53.2},{17.6,-53.2}}, color={0,0,127}));
  connect(mH2_total.port_b, H2_sink.ports[1])
    annotation (Line(points={{48,0},{20,0}}, color={0,127,255}));
  connect(mH2_total.port_a, H2_feed)
    annotation (Line(points={{68,0},{80,0}}, color={0,127,255}));
  connect(mH2_total.m_flow, mH2_prod.u2) annotation (Line(points={{58,-11},
          {58,-62.8},{17.6,-62.8}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                      graphics={Polygon(
          points={{-70,70},{0,18},{70,18},{70,-18},{0,-18},{-70,-70},{-70,-30},{
              -30,0},{-70,30},{-70,70}},
          lineColor={128,128,128},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
                   Text(extent={{-92,-56},{112,-98}},  textString="%name",lineColor={0,0,255})}));
end IdealRecycle_H2;
