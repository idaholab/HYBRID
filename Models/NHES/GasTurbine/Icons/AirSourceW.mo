within NHES.GasTurbine.Icons;
partial model AirSourceW

annotation (
  Icon( coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),
    Text(extent={{-54,32},{16,-30}}, lineColor={255,0,0}, textString="m"),
        graphics={
        Rectangle(
          extent={{35,45},{100,-45}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={85,170,255}),
          Ellipse(
            extent={{-100,80},{60,-80}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,68},{60,0},{-60,-68},{-60,68}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,38},{16,-24}},
          lineColor={102,44,145},
            textString="m"),
        Ellipse(
            extent={{-28,34},{-20,26}},
            lineColor={102,44,145},
            fillColor={102,44,145},
            fillPattern=FillPattern.Solid)}));

end AirSourceW;
