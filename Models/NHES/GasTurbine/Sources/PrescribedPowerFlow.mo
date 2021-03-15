within NHES.GasTurbine.Sources;
model PrescribedPowerFlow "Prescribed power flow boundary condition"
  import      Modelica.Units.SI;

  NHES.GasTurbine.Interfaces.ElectricalPowerPort_b port_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
          extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput P_flow( quantity="Power", unit="W", displayUnit="MW") annotation (Placement(
        transformation(extent={{-100,-20},{-60,20}}), iconTransformation(extent=
           {{-100,-20},{-60,20}})));
equation
  port_b.W = -P_flow;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
                                       Ellipse(
              extent={{60,-60},{-60,60}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
                         Text(
              extent={{-28,26},{26,-26}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="G"),
        Line(points={{60,0},{70,0},{90,0}}, color={255,0,0})}));
end PrescribedPowerFlow;
