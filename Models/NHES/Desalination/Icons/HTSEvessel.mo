within NHES.Desalination.Icons;
partial model HTSEvessel

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(extent={{-80,-100},{80,-20}},lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(extent={{-80,20},{80,100}},lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(extent={{-80,54},{80,-58}}, lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255}),
        Rectangle(extent={{-84,64},{84,54}},  lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
                Text(
          extent={{-150,20},{150,-20}},
          lineColor={0,0,255},
          textString="%name",
          origin={140,143},
          rotation=0),
        Rectangle(extent={{-84,-54},{84,-64}},lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215})}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end HTSEvessel;
