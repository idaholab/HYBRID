within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
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
      Real opening_actual "Actual valve open amount";
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
<p>This valve is a standard linear valve with one notable exception. The controlled opening value is not applied to the pressure drop equation. Instead, the hyperbolic tangent of the opening value is named opening_actual and that value is applied to the pressure drop equation. </p>
<p>The hyperbolic tangent function appears as a horizontal tangent function, changing from one extreme value to another over a small range. The advantage of a hyperbolic tangent function as opposed to a logical switch or even a linear switch between two values is that the function has a continuous derivative that can be evaluated within Modelica models. </p>
<p>The purpose of using this filter is to allow controllers to span any real value as an input while the valve will actually operate on [0,1]. (If allowed to go negative, the valve will increase pressure of fluid moving across it. </p>
</html>",
    revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
end ValveLineartanh;
