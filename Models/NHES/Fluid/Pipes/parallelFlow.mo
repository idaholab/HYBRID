within NHES.Fluid.Pipes;
model parallelFlow "Scales mass flow rate: simulates parallel flow streams"
  extends NHES.Fluid.Interfaces.PartialTwoPort(
    showDesignFlowDirection=false);

  parameter Real nParallel = 1 "port_a.m_flow is divided into nParallel flow streams";

equation
  // mass balance
  0 = port_a.m_flow + port_b.m_flow*nParallel;

  // momentum equation (no pressure loss)
  port_a.p = port_b.p;

  // isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  annotation (defaultComponentName="nFlow",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-88,60},{88,-60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{80,3},{0,3},{0,34},{80,34},{80,40},{-6,40},{-6,-40},{80,-40},
              {80,-34},{0,-34},{0,-3},{80,-3},{80,3}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-6,3},{-80,3},{-80,-3},{-6,-3},{-6,3}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end parallelFlow;
