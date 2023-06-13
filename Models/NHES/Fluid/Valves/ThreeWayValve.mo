within NHES.Fluid.Valves;
model ThreeWayValve
 replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
    Real v1pos;
    Real v2pos;
    parameter Real switch_start "Value for when the valves begin to switch";
    parameter Real switch_end "Value for when the valves finnish switching";

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput    y annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  ValveLinear valveLinear1(
    redeclare package Medium = Medium,
    dp_nominal=v1_dp_nominal,
    m_flow_nominal=v1_m_flow_nominal)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ValveLinear valveLinear2(
    redeclare package Medium = Medium,
    dp_nominal=v2_dp_nominal,
    m_flow_nominal=v2_m_flow_nominal)
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Modelica.Blocks.Sources.RealExpression v1(y=v1pos)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.RealExpression v2(y=v2pos)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    v1_m_flow_nominal "Nominal mass flowrate at full opening";
  parameter SI.AbsolutePressure v1_dp_nominal
    "Nominal pressure drop at full opening";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    v2_m_flow_nominal "Nominal mass flowrate at full opening";
  parameter SI.AbsolutePressure v2_dp_nominal
    "Nominal pressure drop at full opening";
  parameter Real n1=1 "exp close/open rate for valve1";
  parameter Real n2=1 "exp close/open rate for valve2";
equation
 if switch_end>switch_start then
   if y>=switch_end then
     v1pos=0;
     v2pos=1;
   elseif y<switch_end and y>switch_start then
     v1pos=((switch_end-y)/(switch_end-switch_start))^n1;
     v2pos=((y-switch_start)/(switch_end-switch_start))^n2;
   else
     v1pos=1;
     v2pos=0;
   end if;
 else
   if y<=switch_end then
     v1pos=0;
     v2pos=1;
   elseif y>switch_end and y<switch_start then
     v2pos=((switch_start-y)/(switch_start-switch_end))^n2;
     v1pos=((y-switch_end)/(switch_start-switch_end))^n1;
   else
     v1pos=1;
     v2pos=0;
   end if;
 end if;

  connect(port_a2,valveLinear2. port_a) annotation (Line(points={{0,-100},{0,-80},
          {-5.55112e-16,-80},{-5.55112e-16,-60}}, color={0,127,255}));
  connect(port_a1, valveLinear1.port_a)
    annotation (Line(points={{-100,0},{-60,0}}, color={0,127,255}));
  connect(v1.y, valveLinear1.opening)
    annotation (Line(points={{-59,30},{-50,30},{-50,8}}, color={0,0,127}));
  connect(v2.y,valveLinear2. opening)
    annotation (Line(points={{-39,-50},{-8,-50}}, color={0,0,127}));
  connect(valveLinear1.port_b, valveLinear2.port_b) annotation (Line(points={{-40,
          0},{6.10623e-16,0},{6.10623e-16,-40}}, color={0,127,255}));
  connect(valveLinear1.port_b, port_b)
    annotation (Line(points={{-40,0},{100,0}}, color={0,127,255}));
annotation (
  Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
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
          points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
              0}}, {{-100,50*opening},{-100,50*opening},{100,-50*opening},{
              100,50*opening},{0,0},{-100,-50*opening},{-100,50*opening}}),
          fillColor={0,255,0},
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
              50}}, lineColor={0,0,0}),
        Polygon(
          points={{-48,-100},{48,-100},{0,0},{0,0},{-48,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-194,50}}, color={0,0,0}),
        Line(
          points={{-68,0},{-22,0}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Line(
          points={{-23,0},{23,0}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5,
          origin={1,-44},
          rotation=90),
        Line(
          points={{-23,0},{23,0}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5,
          origin={45,0},
          rotation=360)}),
  Documentation(info="<html>
<p>This very simple model provides a pressure drop which is proportional to the flowrate and to the <code>opening</code> input, without computing any fluid property. It can be used for testing purposes, when
a simple model of a variable pressure loss is needed.</p>
<p>A medium model must be nevertheless be specified, so that the fluid ports can be connected to other components using the same medium model.</p>
<p>The model is adiabatic (no heat losses to the ambient) and neglects changes in kinetic energy from the inlet to the outlet.</p>
</html>",
    revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
end ThreeWayValve;
