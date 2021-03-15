within NHES.Electrolysis.Sources;
model PrescribedFrequency

  parameter SI.Frequency f "Frequancy";

  Electrolysis.Interfaces.ElectricalPowerPort_a portElec_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  portElec_a.f = f;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                       Ellipse(
              extent={{60,-60},{-60,60}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
                         Text(
              extent={{-28,26},{26,-26}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
          textString="F"),
        Line(points={{-60,0},{-68,0},{-90,0}}, color={255,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PrescribedFrequency;
