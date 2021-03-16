within NHES.Electrolysis.Sources;
model PrescribedLoad
  import      Modelica.Units.SI;
  SI.Power W "Electric load";
  SI.Frequency f "Electrical frequency";

  Electrolysis.Interfaces.ElectricalPowerPort_a load annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(
          extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput powerConsumption(quantity="Power", unit="W", displayUnit="MW") annotation (Placement(
      transformation(
      extent={{-20,-20},{20,20}},
      rotation=-90,
      origin={-20,40}), iconTransformation(
      extent={{-10,-10},{10,10}},
      rotation=-90,
      origin={-20,30})));
equation
  load.W = W;
  load.f = f;

  W = powerConsumption;

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
          thickness=0.5),
                 Text(
        extent={{-124,-38},{84,-78}},
        lineColor={0,0,255},
        textString="%name")}));
end PrescribedLoad;
