within NHES.Systems;
package HeatTransport
  extends Modelica.Icons.Package;

  annotation (            Icon(graphics={
        Rectangle(
          extent={{-70,-30},{30,40}},
          lineColor={0,0,0},
          fillColor={145,145,145},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{-60,-40},{-40,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-30},{72,-30},{72,-2},{50,24},{38,24},{30,24},{30,24},{30,
              -30}},
          lineColor={0,0,0},
          fillColor={145,145,145},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{40,-40},{60,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{44,20},{44,-2},{66,-2}},
          color={0,0,0},
          thickness=1),          Bitmap(extent={{-70,-20},{28,34}},   fileName="modelica://NHES/Resources/Images/Systems/Fire.jpg")}));
end HeatTransport;
