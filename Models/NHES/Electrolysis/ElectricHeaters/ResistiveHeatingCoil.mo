within NHES.Electrolysis.ElectricHeaters;
model ResistiveHeatingCoil
  "Lumped thermal element for a resistive heating coil"

  parameter Modelica.Units.SI.HeatCapacity C
    "Heat capacity of a resistive heating coil (= cp*m)";
  parameter Modelica.Units.SI.Temperature T_start=850 + 10 + 273.15
    annotation (Dialog(tab="Initialisation"));
  Modelica.Units.SI.HeatFlowRate Q_flow_a "Heat flow rate from port_a";
  Modelica.Units.SI.HeatFlowRate Q_flow_b "Heat flow rate from port_a";
  Modelica.Units.SI.Temperature T(
    min=273.15,
    start=T_start,
    displayUnit="degC") "Temperature of a resistive heating coil";
  //Modelica.SIunits.TemperatureSlope der_T(start=0)
  //  "Time derivative of temperature (= der(T))";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation

  Q_flow_a = port_a.Q_flow;
  Q_flow_b = -port_b.Q_flow;
  T = port_a.T;
  T = port_b.T;

  //der_T = der(T);
  C*der(T) = Q_flow_a - Q_flow_b;

initial equation
  der(T) = 0;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,100}}),
                        graphics={
        Rectangle(
          extent={{-90,80},{-60,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-140,-94},{160,-134}},
          textString="%name",
          lineColor={0,0,255}),
        Line(points={{120,0},{120,0}}, color={0,127,255}),
        Ellipse(extent={{40,66},{80,46}}, lineColor={238,46,47}),
        Ellipse(extent={{40,50},{80,30}}, lineColor={238,46,47}),
        Polygon(
          points={{58,46},{54,44},{54,48},{58,46}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,50},{54,48},{54,52},{58,50}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,46},{56,50}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,50},{60,46}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(points={{58,50},{58,50},{60,50}}, color={238,46,47}),
        Line(points={{58,46},{60,46}}, color={238,46,47}),
        Ellipse(extent={{40,34},{80,14}}, lineColor={238,46,47}),
        Ellipse(extent={{40,18},{80,-2}}, lineColor={238,46,47}),
        Polygon(
          points={{58,14},{54,12},{54,16},{58,14}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,18},{54,16},{54,20},{58,18}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,14},{56,18}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,18},{60,14}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(points={{58,18},{58,18},{60,18}}, color={238,46,47}),
        Line(points={{58,14},{60,14}}, color={238,46,47}),
        Ellipse(extent={{40,2},{80,-18}}, lineColor={238,46,47}),
        Ellipse(extent={{40,-14},{80,-34}}, lineColor={238,46,47}),
        Polygon(
          points={{58,-18},{54,-20},{54,-16},{58,-18}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,-14},{54,-16},{54,-12},{58,-14}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent={{58,-14},{60,-18}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(points={{58,-14},{58,-14},{60,-14}}, color={238,46,47}),
        Line(points={{58,-18},{60,-18}}, color={238,46,47}),
        Ellipse(extent={{40,-30},{80,-50}}, lineColor={238,46,47}),
        Ellipse(extent={{40,-46},{80,-66}}, lineColor={238,46,47}),
        Polygon(
          points={{58,-50},{54,-52},{54,-48},{58,-50}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,-46},{54,-48},{54,-44},{58,-46}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,-50},{56,-46}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,-46},{60,-50}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(points={{58,-46},{58,-46},{60,-46}}, color={238,46,47}),
        Line(points={{58,-50},{60,-50}}, color={238,46,47}),
        Polygon(
          points={{68,60},{64,58},{64,62},{68,60}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{68,56},{64,54},{64,58},{68,56}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent={{68,60},{70,56}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent={{58,34},{60,30}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,30},{54,28},{54,32},{58,30}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,34},{54,32},{54,36},{58,34}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,2},{54,0},{54,4},{58,2}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,-2},{54,-4},{54,0},{58,-2}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,-30},{54,-32},{54,-28},{58,-30}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Polygon(
          points={{58,-34},{54,-36},{54,-32},{58,-34}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent={{68,60},{70,56}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,30},{56,34}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,34},{60,30}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,-2},{56,2}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,2},{60,-2}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,-18},{56,-14}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,-14},{60,-18}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Ellipse(extent={{60,-34},{56,-30}}, lineColor={238,46,47}),
        Rectangle(
          extent={{58,-30},{60,-34}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(points={{58,34},{58,34},{60,34}}, color={238,46,47}),
        Line(points={{58,30},{58,30},{60,30}}, color={238,46,47}),
        Line(points={{58,2},{58,2},{60,2}}, color={238,46,47}),
        Line(points={{58,-14},{58,-14},{60,-14}}, color={238,46,47}),
        Line(points={{58,-2},{60,-2}}, color={238,46,47}),
        Line(points={{58,-18},{60,-18}}, color={238,46,47}),
        Line(points={{58,-30},{60,-30}}, color={238,46,47}),
        Line(points={{58,-34},{60,-34}}, color={238,46,47}),
        Rectangle(
          extent={{50,66},{60,64}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{50,-64},{60,-66}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{90,0},{72,0}},    color={191,0,0}),
        Rectangle(
          extent={{-58,66},{54,-66}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None,
          lineColor={238,46,47}),
        Line(points={{60,66},{56,66},{-60,66}}, color={238,46,47}),
        Line(points={{60,-66},{52,-66},{-60,-66}}, color={238,46,47}),
                  Text(
          extent={{-67,15},{73,-16}},
          lineColor={0,0,0},
          textString="%C")}),
 Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255})}));
end ResistiveHeatingCoil;
