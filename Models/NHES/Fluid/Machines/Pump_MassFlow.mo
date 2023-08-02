within NHES.Fluid.Machines;
model Pump_MassFlow "Mass Flow Pump"
  extends TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple;

  parameter Boolean use_input=false "Use connector input for the mass flow" annotation(choices(checkBox=true));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0
    "Nominal mass flowrate" annotation (Dialog(enable=not use_input));
  parameter Real eta=1 "Thermodynamic Efficiency of the pump";
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction" annotation(Dialog(tab="Advanced"));
  //SI.MassFlowRate m_flow "Mass flowrate";
  Modelica.Blocks.Interfaces.RealInput inputSignal(value=m_flow_internal)
                                             if use_input annotation (Placement(
        transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={0,73})));
protected
  Modelica.Units.SI.MassFlowRate m_flow_internal;
equation

eta_is=eta;
  if not use_input then
    m_flow_internal =m_flow_nominal;
  end if;
  m_flow = m_flow_internal;
  //port_a.m_flow + port_b.m_flow = 0;
  //port_a.m_flow = m_flow;
  // Balance Equations
  //port_a.h_outflow = inStream(port_b.h_outflow);
  //port_b.h_outflow = inStream(port_a.h_outflow);
 // port_a.Xi_outflow = inStream(port_b.Xi_outflow);
 // port_b.Xi_outflow = inStream(port_a.Xi_outflow);
 // port_a.C_outflow = inStream(port_b.C_outflow);
 // port_b.C_outflow = inStream(port_a.C_outflow);
  annotation (defaultComponentName="pump",
    Icon(graphics={
        Rectangle(
          extent={{-80,30},{-40,-30}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2,60},{80,0}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{60,60},{-60,-60}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-20,20},{-20,-22},{30,0},{-20,20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
                   Text(extent={{-22,18},{28,-14}},
          textString="m_flow",
          lineColor={0,0,0})}),
    Documentation(info="<html>
<p>This component prescribes the flow rate passing through it. </p>
<p><br><b><span style=\"font-family: Arial; font-size: 18pt;\">Contact Deatils</span></b></p>
<p><span style=\"font-family: Arial;\">This model was designed by Logan Williams (<a href=\"mailto:Logan.Williams@inl.gov\">Logan.Williams@inl.gov</a>). All initial questions should be directed to Daniel Mikkelson (<a href=\"mailto:Daniel.Mikkelson@inl.gov\">Daniel.Mikkelson@inl.gov</a>).</span></p>
</html>",
        revisions="<html>
<ul>
<li><i>18 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end Pump_MassFlow;
