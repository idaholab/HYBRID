within NHES.Fluid.Valves;
model Pressure_Control_Valve_Simple
  "Linear Valve Controlled by PI controller to mantain a set inlet pressure"

parameter Modelica.Units.SI.Pressure P_sys=1e5 "Pressure";
parameter Modelica.Units.SI.PressureDifference Nominal_dp=0.5e5
                                                               "Nominal Pressure drop";
parameter Modelica.Units.SI.MassFlowRate Nominal_Flow=1 "Nominal Mass Flow Rate";
parameter Real k=-0.000003 "Controller Gain";
parameter Real Ti=0.5
                     "Controller Integrator Time Constant";
parameter Real Td=0.1
                     "Controller Derivative Time Constant";
parameter Real wp(min=0) = 1 "Set-point weight for Proportional block (0..1)";
parameter Real wd(min=0) = 0.1
                              "Set-point weight for Derivative block (0..1)";
parameter Real ni=0.9;
parameter Real Nd=10;


  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
                                                 dp_nominal=Nominal_dp, m_flow_nominal=Nominal_Flow)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  TRANSFORM.Controls.LimPID         PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    Td=Td,
    yMax=1,
    yMin=0,
    wp=wp,
    wd=wd,
    Ni=ni,
    Nd=Nd,
    y_reset=0)
           annotation (Placement(transformation(extent={{-20,44},{0,64}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Level(y=P_sys) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    precision=2,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_Pa)
                                            annotation (Placement(transformation(extent={{-96,6},{-76,26}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Modelica.Media.Water.StandardWater)    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Modelica.Media.Water.StandardWater)    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(Pressure_Level.y, PID.u_s) annotation (Line(points={{-29,50},{-26,50},
          {-26,54},{-22,54}},                                                   color={0,0,127}));
  connect(port_a, sensor_p.port) annotation (Line(points={{-100,0},{-86,0},{-86,6}},           color={0,127,255}));
  connect(sensor_p.port, valveLinear.port_a) annotation (Line(points={{-86,6},{-86,-40},{-10,-40}},           color={0,127,255}));
  connect(valveLinear.port_b, port_b) annotation (Line(points={{10,-40},{78,-40},{78,0},{100,0}}, color={0,127,255}));
  connect(port_a, port_a) annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(sensor_p.p, PID.u_m)
    annotation (Line(points={{-80,16},{-10,16},{-10,42}}, color={0,0,127}));
  connect(PID.y, valveLinear.opening) annotation (Line(points={{1,54},{6,54},{6,
          -26},{0,-26},{0,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{20,-47},{60,-62},{20,-77},{20,-47}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true, showDesignFlowDirection)),
        Polygon(
          points={{20,-52},{50,-62},{20,-72},{20,-52}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true, showDesignFlowDirection)),
        Line(
          points={{55,-62},{-60,-62}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=DynamicSelect(true, showDesignFlowDirection)),
        Text(
          extent={{-149,-70},{151,-110}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true, showName)),
        Line(points={{0,48},{0,-2}}),
        Rectangle(
          extent={{-20,50},{20,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,48},{100,-52},{100,48},{0,-2},{-100,-52},{-100,48}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-2},{100,-2},{100,-2},{0,-2},{-100,-2},{-100,-2}},
          fillColor={0,255,0},
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-100,48},{100,-52},{100,48},{0,-2},{-100,-52},{-100,48}},
                    lineColor={0,0,0}),
        Rectangle(extent={{-58,76},{4,72}}, pattern=LinePattern.None)}),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
end Pressure_Control_Valve_Simple;
