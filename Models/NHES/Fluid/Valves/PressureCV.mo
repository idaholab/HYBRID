within NHES.Fluid.Valves;
model PressureCV "Pressure Control Valve"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
  parameter Boolean Use_input=true "Constant output value";
  parameter Modelica.Units.SI.AbsolutePressure Pressure_target=2e5
    "Target Pressure" annotation(Dialog(enable= not Use_input));
  parameter Modelica.Blocks.Interfaces.RealOutput ValvePos_start=0.1
    "Initail Valve Position" annotation(Dialog(group="Initialization"));
  parameter Modelica.Units.SI.Time init_time=0 "Time instant of step start" annotation(Dialog(group="Initialization"));
  parameter Real PID_k=1e-2 "Controller gain: +/- for direct/reverse acting" annotation(Dialog(group="PI Parameters"));
  parameter Modelica.Units.SI.Time PID_Ti=0.5
    "Time constant of Integrator block" annotation(Dialog(group="PI Parameters"));
  parameter Real PID_wp=1 "Set-point weight for Proportional block (0..1)" annotation(Dialog(group="PI Parameters"));
  parameter Real PID_Ni=0.9
    "Ni*Ti is time constant of anti-windup compensation" annotation(Dialog(group="PI Parameters"));
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
  NHES.Controls.LimOffsetPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=PID_k,
    Ti=PID_Ti,
    yMax=1,
    yMin=0,
    wp=PID_wp,
    Ni=PID_Ni,
    offset=ValvePos_start,
    delayTime=init_time,
    init_output=ValvePos_start)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Modelica.Blocks.Sources.RealExpression Pressure_nom(y=Pressure_target)
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));

  Modelica.Blocks.Logical.Switch inputSwitch annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,70})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=Use_input)
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput target_value if Use_input annotation (
      Placement(transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  Modelica.Blocks.Sources.RealExpression zero(y=0) if not Use_input
    annotation (Placement(transformation(extent={{-120,28},{-100,48}})));
equation
  connect(booleanConstant.y, inputSwitch.u2)
    annotation (Line(points={{-99,70},{-82,70}}, color={255,0,255}));
  connect(Pressure_nom.y, inputSwitch.u3) annotation (Line(points={{-99,110},{-90,
          110},{-90,78},{-82,78}}, color={0,0,127}));
  connect(inputSwitch.y, PID.u_s) annotation (Line(points={{-59,70},{-50,70},{-50,
          50},{-42,50}}, color={0,0,127}));
  connect(port_a, valveLinear.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(target_value, inputSwitch.u1) annotation (Line(points={{0,80},{-52,80},
          {-52,68},{-58,68},{-58,52},{-82,52},{-82,62}}, color={0,0,127}));
  connect(zero.y, inputSwitch.u1)
    annotation (Line(points={{-99,38},{-82,38},{-82,62}}, color={0,0,127}));
  connect(valveLinear.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(sensor_p.port, valveLinear.port_a)
    annotation (Line(points={{-66,0},{-10,0}}, color={0,127,255}));
  connect(port_a, sensor_p.port)
    annotation (Line(points={{-100,0},{-66,0}}, color={0,127,255}));
  connect(sensor_p.p, PID.u_m) annotation (Line(points={{-60,-10},{-46,-10},{
          -46,32},{-30,32},{-30,38}}, color={0,0,127}));
  connect(PID.y, valveLinear.opening)
    annotation (Line(points={{-19,50},{0,50},{0,8}}, color={0,0,127}));
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
end PressureCV;
