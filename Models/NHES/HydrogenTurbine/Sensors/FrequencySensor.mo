within NHES.HydrogenTurbine.Sensors;
model FrequencySensor "Measures the electrical frequency at the connector"

  Interfaces.ElectricalPowerPort_a elecPort annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput f(unit="Hz", min=0)
    "Electrical frequency"
    annotation (Placement(transformation(extent={{92,-10},{112,10}}, rotation=
           0)));
equation
  elecPort.W = 0;
  f = elecPort.f;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={Ellipse(
          extent={{-70,70},{70,-70}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid),    Line(points={{0,70},{0,40}},
          color={0,0,0}),Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),Line(points=
           {{37.6,13.7},{65.8,23.9}}, color={0,0,0}),Line(points={{-37.6,13.7},
          {-65.8,23.9}}, color={0,0,0}),     Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="f"),Line(points={{-70,0},{-90,0}}, color={0,0,0}),
          Line(points={{100,0},{70,0}}, color={0,0,0}),Text(
          extent={{-148,88},{152,128}},
          textString="%name",
          lineColor={0,0,255}),
        Polygon(
          origin={0,0},
          rotation=-17.5,
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={255,255,255},
          extent={{-12,-12},{12,12}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-7,-7},{7,7}})}));
end FrequencySensor;
