within NHES.GasTurbine.PowerPlant.Intermediate_ExamplesAndModels;
block Feedback_droopCtrl
  "Output difference between commanded and feedback inputs"

Modelica.Blocks.Interfaces.RealInput u1( unit="1") annotation (Placement(
  transformation(extent={{100,-20},{60,20}}, rotation=0)));
Modelica.Blocks.Interfaces.RealInput u2( unit="1") annotation (Placement(
  transformation(
  origin={0,-80},
  extent={{-20,-20},{20,20}},
  rotation=90)));
Modelica.Blocks.Interfaces.RealInput u3( unit="1") annotation (Placement(
  transformation(extent={{-20,20},{20,-20}}, rotation=-90,
      origin={0,80})));
Modelica.Blocks.Interfaces.RealOutput y( unit="1") annotation (Placement(
  transformation(extent={{-80,-10},{-100,10}}, rotation=0)));

equation
y = u1 - u2 + u3;
annotation (
  Documentation(info="<html>


</html>"),
         Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, initialScale = 0.1), graphics={
    Ellipse(
      lineColor = {0,0,127},
      fillColor = {235,235,235},
      fillPattern = FillPattern.Solid,
      extent = {{-20,-20},{20,20}}),
    Line(points={{-80,0},{-20,0}},   color = {0,0,127}),
    Line(points = {{20,0},{80,0}}, color = {0,0,127}),
    Line(points = {{0,-20},{0,-60}}, color = {0,0,127}),
    Text(extent={{-26,-98},{70,-4}},  textString = "-"),
    Line(points={{-10,-2.80682e-015},{30,0}},
                                     color = {0,0,127},
    origin={0,50},
    rotation=-90),
  Text(
    extent={{-62,78},{16,12}},
    lineColor={0,0,0},
    textString="+"),
  Text(
    extent={{8,54},{86,-12}},
    lineColor={0,0,0},
    textString="+")}),
  Diagram(coordinateSystem(
  preserveAspectRatio=false,
  extent={{-100,-100},{100,100}}), graphics={
  Ellipse(
    extent={{-20,20},{20,-20}},
    pattern=LinePattern.Solid,
    lineThickness=0.25,
    fillColor={235,235,235},
    fillPattern=FillPattern.Solid,
    lineColor={0,0,255}),
  Line(points={{-20,0},{20,0}},  color={0,0,255},
    origin={0,-40},
    rotation=-90),
  Line(points={{-80,0},{-20,0}},
                               color={0,0,255}),
  Line(points={{0,60},{0,20}},   color={0,0,255}),
  Line(points={{0,20},{0,-20}},  color={0,0,255},
    origin={40,0},
    rotation=-90)}));
end Feedback_droopCtrl;
