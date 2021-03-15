within NHES.Electrical;
model Grid "Ideal grid with finite droop"

  parameter Integer n=0 "Number of ports" annotation(Dialog(connectorSizing=true));

  parameter SI.Frequency f_nominal=60 "Nominal frequency";
  parameter SI.Power Q_nominal "Nominal power installed on the network";
  parameter Real droop=0.05 "Network droop";

  SI.Power W_total "Total power";

  Interfaces.ElectricalPowerPorts_b ports[n]
    annotation (Placement(transformation(extent={{-110,-40},{-90,40}}),
        iconTransformation(extent={{-110,40},{-90,-40}})));

equation

  for i in 1:n loop
    ports[i].f = f_nominal + droop*f_nominal*ports[i].W/Q_nominal;
  end for;

  W_total = sum(ports.W);
  annotation (defaultComponentName="grid",
                   Icon(graphics={
          Ellipse(
              extent={{100,-68},{-40,68}},
              lineColor={0,0,0},
              lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                  Line(points={{16,-16},{0,-38}},
          color={0,0,0}),Line(points={{-90,0},{-40,0}}, color={255,0,0},
          thickness=0.5),        Line(points={{-40,0},{-4,0},{22,36},{54,50}},
          color={0,0,0}),Line(points={{24,36},{36,-6}}, color={0,0,0}),Line(
          points={{-6,0},{16,-14},{40,-52}}, color={0,0,0}),Line(points={{18,
          -14},{34,-6},{70,-22}}, color={0,0,0}),Line(points={{68,18},{36,-4},
          {36,-4}}, color={0,0,0}),Ellipse(
              extent={{-8,2},{-2,-4}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{20,38},{26,32}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{52,54},{58,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{14,-12},{20,-18}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{66,22},{72,16}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{32,-2},{38,-8}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{38,-50},{44,-56}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{66,-18},{72,-24}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-2,-34},{4,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
end Grid;
