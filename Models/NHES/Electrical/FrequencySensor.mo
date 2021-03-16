within NHES.Electrical;
model FrequencySensor "Measures the frequency at the connector"

  NHES.Electrical.Interfaces.ElectricalPowerPort_b port annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput f "Frequency at the connector"
    annotation (Placement(transformation(extent={{92,-10},{112,10}}, rotation=
           0)));
equation
  port.W = 0;
  f = port.f;
  annotation (Diagram(graphics), Icon(graphics={Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,70},{0,40}},
          color={0,0,0}),Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),Line(points=
           {{37.6,13.7},{65.8,23.9}}, color={0,0,0}),Line(points={{-37.6,13.7},
          {-65.8,23.9}}, color={0,0,0}),Line(points={{0,0},{9.02,28.6}},
          color={0,0,0}),Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="f"),Line(points={{-70,0},{-90,0}}, color={0,0,0}),
          Line(points={{100,0},{70,0}}, color={0,0,0}),Text(extent={{-148,88},
          {152,128}}, textString="%name")}));
end FrequencySensor;
