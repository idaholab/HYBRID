within NHES.Fluid.Valves;
model TeslaValve
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
    Real k;

equation
  m_flow = dp/k;
  if dp <1e-3 and dp>-1e-3 then
    k=1;
    else
  k=0.01
       +(1e7/(1+exp(10*dp)));
  end if;
  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,60},{-40,75},{0,90},{0,60}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{0,65},{-30,75},{0,85},{0,65}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{75,75},{-40,75}},
          color={0,128,255},
          visible=showDesignFlowDirection),
        Line(
          points={{-126,96}},
          color={0,0,0},
          pattern=LinePattern.None,
          thickness=0.5),
        Line(
          points={{-120,108}},
          color={0,0,0},
          pattern=LinePattern.None,
          thickness=0.5),
        Line(
          points={{40,90},{20,61}},
          color={0,128,255},
          visible=showDesignFlowDirection,
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TeslaValve;
