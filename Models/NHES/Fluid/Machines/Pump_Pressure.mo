within NHES.Fluid.Machines;
model Pump_Pressure "Pressure Booster Pump"
  extends TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple;

  parameter Boolean use_input=false "Use connector input for outlet pressure" annotation(choices(checkBox=true));
  parameter Modelica.Units.SI.Pressure p_nominal=1e5
    "Nominal outlet pressure (port_b.p)"
    annotation (Dialog(enable=not use_input));
   parameter Real eta=1 "Thermodynamic Efficiency of the pump";

  Modelica.Units.SI.Pressure p "Outlet pressure (port_b.p)";
  Modelica.Blocks.Interfaces.RealInput inputSignal(value=p_internal)
                                             if use_input annotation (Placement(
        transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={0,73})));
protected
  Modelica.Units.SI.Pressure p_internal;
equation
  eta_is=eta;
  if not use_input then
    p_internal =p_nominal;
  end if;
  p = p_internal;
  //port_a.m_flow + port_b.m_flow = 0;
  port_b.p = p;
  // Balance Equations
  //port_a.h_outflow = inStream(port_b.h_outflow);
  //port_b.h_outflow = inStream(port_a.h_outflow);
  //port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  //port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  //port_a.C_outflow = inStream(port_b.C_outflow);
  //port_b.C_outflow = inStream(port_a.C_outflow);

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
          lineColor={0,0,0},
          textString="p")}),
    Documentation(info="<html>
<p>This component prescribes the exit pressure. </p>
<p><b><span style=\"font-family: Arial; font-size: 18pt;\">Contact Deatils</span></b></p>
<p><span style=\"font-family: Arial;\">This model was designed by Logan Williams (<a href=\"mailto:Logan.Williams@inl.gov\">Logan.Williams@inl.gov</a>). All initial questions should be directed to Daniel Mikkelson (<a href=\"mailto:Daniel.Mikkelson@inl.gov\">Daniel.Mikkelson@inl.gov</a>).</span></p>
</html>",
        revisions="<html>
<ul>
<li><i>18 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end Pump_Pressure;
