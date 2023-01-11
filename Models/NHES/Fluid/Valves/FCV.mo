within NHES.Fluid.Valves;
model FCV "Flow Control Valve"
  replaceable package Medium =Modelica.Media.Interfaces.PartialMedium
  annotation (__Dymola_choicesAllMatching=true);
  parameter SI.MassFlowRate m_target=4;

  parameter SI.PressureDifference dp_nom=1e3
  annotation(Dialog(Group="Valve Parameters"));
  parameter SI.MassFlowRate m_nom=1
  annotation(Dialog(Group="Valve Parameters"));
  parameter Real k=-0.3
   annotation(Dialog(Group="PI Parameters"));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Medium,           dp_nominal=dp_nom,
      m_flow_nominal=m_nom)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Medium, precision=3)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=2,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{40,20},{20,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_target)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a( redeclare package Medium =Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b( redeclare package Medium =Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(valveLinear.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,127,255}));
  connect(sensor_m_flow.m_flow, PID.u_m)
    annotation (Line(points={{30,3.6},{30,18}}, color={0,0,127}));
  connect(PID.y, valveLinear.opening)
    annotation (Line(points={{19,30},{0,30},{0,8}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{59,30},{42,30}}, color={0,0,127}));
  connect(sensor_m_flow.port_b, port_b)
    annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));
  connect(valveLinear.port_a, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
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
        Line(points={{0,50},{0,0}}),
        Rectangle(
          extent={{-20,60},{20,50}},
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
        Polygon(
          points={{-22,54},{24,56},{14,68},{-4,72},{-16,66},{-22,54}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{22,54},{-24,56},{-14,68},{4,72},{16,66},{22,54}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FCV;
