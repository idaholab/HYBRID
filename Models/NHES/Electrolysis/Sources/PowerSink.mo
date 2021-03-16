within NHES.Electrolysis.Sources;
model PowerSink
  import      Modelica.Units.SI;
  SI.Power W;
  parameter SI.Frequency f0 = 60 "Nominal frequency";
  SI.Frequency f "Frequency";
  Electrolysis.Interfaces.ElectricalPowerPort_a port_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

equation
    port_a.W = W;
    port_a.f = f;

    f = f0 "Frequency set by parameter";

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={          Rectangle(
              extent={{-20,40},{20,-40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
          origin={-20,0},
          rotation=90),                      Line(points={{0,14},{0,-14}},
          color={0,0,0},
          origin={34,0},
          rotation=270), Line(points={{16,0},{-16,0}},     color={0,0,0},
          origin={48,0},
          rotation=270),
          Line(points={{8,0},{-8,0}},     color={0,0,0},
          origin={56,0},
          rotation=270),                                 Line(points={{-3,0},{3,
              0}},  color={0,0,0},
          origin={63,0},
          rotation=270),                     Line(
          points={{-3.30655e-015,16},{0,-14}},
          color={255,0,0},
          origin={-76,0},
          rotation=270,
          thickness=0.5)}));
end PowerSink;
