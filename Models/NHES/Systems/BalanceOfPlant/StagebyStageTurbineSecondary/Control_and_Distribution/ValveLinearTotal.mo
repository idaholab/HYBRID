within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
model ValveLinearTotal
  "Valve for water/steam flows with a linear pressure drop"
  extends TRANSFORM.Fluid.Valves.BaseClasses.PartialTwoPortTransport;
  parameter Modelica.Units.SI.AbsolutePressure dp_nominal
    "Nominal pressure drop at full opening"
    annotation (Dialog(group="Nominal operating point"));
  parameter Medium.MassFlowRate m_flow_nominal
    "Nominal mass flowrate at full opening";
  final parameter Modelica.Fluid.Types.HydraulicConductance k=m_flow_nominal/
      dp_nominal "Hydraulic conductance at full opening";
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

  opening_actual =opening;
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
<p>A linear valve, identical to TRANSFORM.Fluid.Valves.ValveLinear. Likely will replace in models and eliminate this. The renaming confused the author. </p>
</html>",
    revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
end ValveLinearTotal;
