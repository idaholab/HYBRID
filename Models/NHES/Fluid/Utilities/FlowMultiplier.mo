within NHES.Fluid.Utilities;
model FlowMultiplier
  "Increases outlet flow by a capcity factor.  Used to correct flow rates for Gas Turbine"
  extends Modelica.Fluid.Interfaces.PartialTwoPort;
  parameter Real capacityScaler=1;

equation
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_a.p = port_b.p;
  port_b.m_flow = -port_a.m_flow*capacityScaler;
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);
  //port_a.Xi = port_b.Xi;

  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          textColor={0,0,0},
          textString="X",
          textStyle={TextStyle.Bold}), Line(
          points={{-100,0},{100,0}},
          color={0,0,0},
          thickness=0.5)}), Documentation(info="<html>
<p>Flow multiplier is used to scale flow with a constant scaling factor.</p>
<p>only the flow variable m_flow is changed with this componenet.</p>
<p><br><br><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p>
</html>"));
end FlowMultiplier;
