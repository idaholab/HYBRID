within NHES.Electrical.Sources;
model FrequencySource

parameter SI.Frequency f=60 "Frequency";

Interfaces.ElectricalPowerPort_b portElec_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  portElec_b.f = f;

   annotation (defaultComponentName="boundary",
Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,108},{150,148}},
          lineColor={0,140,72},
          textString="%name"),
        Text(
          extent={{-64,16},{74,-14}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="Frequency")}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FrequencySource;
