within NHES.Fluid.Valves;
model PressureReliefValve "Pressure Relief Valve"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);

  parameter Modelica.Units.SI.AbsolutePressure Over_Pressure=160e5;
  parameter Modelica.Units.SI.AbsolutePressure Reset_Pressure=150e5;
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_nominal=10
    "Nominal mass flowrate at full opening" annotation(Dialog(group="Valve Nominal Values"));
  parameter Modelica.Units.SI.AbsolutePressure dp_nominal=1e5
    "Nominal pressure drop at full opening" annotation(Dialog(group="Valve Nominal Values"));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(redeclare package Medium =
        Medium,
    dp_nominal=dp_nominal,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TRANSFORM.Fluid.Sensors.Pressure     sensor_p(     redeclare package Medium
      = Medium)
    annotation (Placement(transformation(extent={{-76,0},{-56,-20}})));

  Modelica.Blocks.Sources.RealExpression One(y=1)
    annotation (Placement(transformation(extent={{-118,30},{-98,50}})));

  Modelica.Blocks.Logical.Switch inputSwitch annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,70})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Sources.RealExpression zero(y=0)
    annotation (Placement(transformation(extent={{-120,94},{-100,114}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=Reset_Pressure, uHigh=
        Over_Pressure)
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
equation

  connect(sensor_p.p, hysteresis.u) annotation (Line(points={{-60,-10},{-52,-10},
          {-52,54},{-152,54},{-152,70},{-142,70}}, color={0,0,127}));
  connect(port_a, sensor_p.port)
    annotation (Line(points={{-100,0},{-66,0}}, color={0,127,255}));
  connect(sensor_p.port, valveLinear.port_a) annotation (Line(points={{-66,0},{-66,
          2},{-80,2},{-80,-24},{-16,-24},{-16,0},{-10,0}}, color={0,127,255}));
  connect(valveLinear.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(inputSwitch.y, valveLinear.opening)
    annotation (Line(points={{-59,70},{0,70},{0,8}}, color={0,0,127}));
  connect(One.y, inputSwitch.u1) annotation (Line(points={{-97,40},{-92,40},{-92,
          62},{-82,62}}, color={0,0,127}));
  connect(inputSwitch.u3, zero.y) annotation (Line(points={{-82,78},{-94,78},{-94,
          104},{-99,104}}, color={0,0,127}));
  connect(hysteresis.y, inputSwitch.u2)
    annotation (Line(points={{-119,70},{-82,70}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{20,-45},{60,-60},{20,-75},{20,-45}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true, showDesignFlowDirection)),
        Polygon(
          points={{20,-50},{50,-60},{20,-70},{20,-50}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true, showDesignFlowDirection)),
        Line(
          points={{55,-60},{-60,-60}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=DynamicSelect(true, showDesignFlowDirection)),
        Text(
          extent={{-149,-68},{151,-108}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true, showName)),
        Line(points={{0,30},{0,0}}),
        Rectangle(
          extent={{-20,40},{20,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,0},{100,0},{100,0},{0,0},{-100,0},{-100,0}},
          fillColor={0,255,0},
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
                    lineColor={0,0,0}),
        Polygon(points={{-140,100},{-140,100}}, lineColor={28,108,200}),
        Polygon(
          points={{-20,32},{-20,44},{-14,54},{-2,58},{0,58},{2,58},{14,54},{20,44},
              {20,32},{-20,32}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,100},{-80,60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-40,100},{-80,60}},
          textColor={0,0,0},
          textString="P"),
        Line(
          points={{-18,44},{-44,68}},
          color={0,0,0},
          thickness=0.5)}),                 Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end PressureReliefValve;
