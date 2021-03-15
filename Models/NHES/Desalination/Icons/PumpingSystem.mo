within NHES.Desalination.Icons;
partial model PumpingSystem
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                             Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={240,240,240},
                fillPattern=FillPattern.Solid),
                                    Ellipse(
                extent={{-60,60},{60,-60}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
          fillColor={0,0,255}), Line(points={{0,94},{0,94},{0,60}},
          color={0,0,127}),                     Polygon(
                points={{-30,32},{-30,-28},{48,0},{-30,32}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={255,255,255}),
                           Line(
                points={{-60,0},{-90,0}},
                color={0,0,255},
                thickness=0.5),
                           Line(
                points={{90,0},{60,0}},
                color={0,0,255},
                thickness=0.5),
                Text(
          extent={{-154,-110},{154,-165}},
          lineColor={0,0,255},
          textString="%name"),  Line(points={{-90,40},{-90,40},{-44,40}},
          color={0,0,127})}),    Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end PumpingSystem;
