within NHES.Systems.BalanceOfPlant.Control_and_Distribution;
model ValveLineartanh
  "Valve for water/steam flows with near-linear pressure drop as a hyperbolic tangent function"
  extends TRANSFORM.Fluid.Valves.BaseClasses.PartialTwoPortTransport;
  parameter Modelica.Units.SI.AbsolutePressure dp_nominal
    "Nominal pressure drop at full opening"
    annotation (Dialog(group="Nominal operating point"));
  parameter Medium.MassFlowRate m_flow_nominal
    "Nominal mass flowrate at full opening";
  final parameter Modelica.Fluid.Types.HydraulicConductance k=m_flow_nominal/
      dp_nominal/0.93055 "Hydraulic conductance at full opening";
      Real opening_actual;
  Modelica.Blocks.Interfaces.RealInput opening
    "=1: completely open, =0: completely closed"
  annotation (Placement(transformation(
        origin={0,90},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
equation
  opening_actual = 0.5 + 0.5*tanh((opening-0.5)/0.379564427300032);
  //Note that this method allows for 6.5% overflow of nominal design points.
  m_flow = opening_actual*k*dp;

  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
annotation (
  Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{0,50},{0,0}}),
        Rectangle(
          extent={{-20,60},{20,50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
              0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50*opening_actual},{
              100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50*opening_actual}}),
          fillColor={0,255,0},
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
              50}}, lineColor={0,0,0})}),
  Documentation(info="<html>
<p>This very simple model provides a pressure drop which is proportional to the flowrate and to the <span style=\"font-family: Courier New;\">opening</span> input, without computing any fluid property. It can be used for testing purposes, when a simple model of a variable pressure loss is needed. A linear hyperbolic tangent function uses the opening input and converts it to opening_actual, which is now used in the calculations. </p>
<p>A medium model must be nevertheless be specified, so that the fluid ports can be connected to other components using the same medium model.</p>
<p>The model is adiabatic (no heat losses to the ambient) and neglects changes in kinetic energy from the inlet to the outlet.</p>
</html>",
    revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
end ValveLineartanh;
