within NHES.HydrogenTurbine.Sensors;
model PowerSensor "Measures power flow through the component"

  Interfaces.ElectricalPowerPort_a port_a annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.ElectricalPowerPort_b port_b annotation (Placement(
        transformation(extent={{90,-12},{110,8}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput W "Power flowing from port_a to port_b"
                                          annotation (Placement(
        transformation(
        origin={0,-94},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  port_a.W + port_b.W = 0;
  port_a.f = port_b.f;
  W = port_a.W;
  annotation (Diagram(graphics), Icon(graphics={
                              Line(points={{-70,0},{-90,0}}, color={0,0,0}),
          Line(points={{100,0},{70,0}}, color={0,0,0}),
                                          Line(points={{0,-70},{0,-84}},
          color={0,0,0}),                              Text(
          extent={{-148,88},{152,128}},
          textString="%name",
          lineColor={0,0,255}),                 Ellipse(
          extent={{-70,70},{70,-70}},
          lineColor={0,0,0},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid),
        Polygon(
          origin={0,0},
          rotation=-17.5,
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-7,-7},{7,7}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={255,255,255},
          extent={{-12,-12},{12,12}}),       Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
          textString="W"),                           Line(points={{-37.6,
              13.7},{-65.8,23.9}},
                         color={0,0,0}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
                                             Line(points={{0,70},{0,40}},
          color={0,0,0}),Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
                                                                  Line(points={{
              37.6,13.7},{65.8,23.9}},color={0,0,0})}));
end PowerSensor;
