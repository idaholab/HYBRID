within NHES.GasTurbine.Icons;
partial model GasTurbineUnit

  annotation (Icon(graphics={
        Line(
          points={{-22,26},{-22,48},{22,48},{22,28}},
          color={0,0,255},
          thickness=2.5),
        Rectangle(
          extent={{-100,8},{100,-8}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Polygon(
          points={{-80,60},{-80,-60},{-20,-26},{-20,26},{-80,60}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,28},{20,-26},{80,-60},{80,60},{20,28}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,64},{16,32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0})}), Diagram(graphics));
end GasTurbineUnit;
