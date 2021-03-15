within NHES.Electrical;
model BreakerOrig "Circuit breaker _ original eqns from ThermoPower"

  NHES.Electrical.Interfaces.ElectricalPowerPort_b port_a annotation (Placement(
        transformation(extent={{-114,-14},{-86,14}}, rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  NHES.Electrical.Interfaces.ElectricalPowerPort_b port_b annotation (Placement(
        transformation(extent={{86,-14},{114,14}}, rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput closed annotation (Placement(
        transformation(
        origin={0,80},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  port_a.W + port_b.W = 0;
  if closed then
    port_a.f = port_b.f;
  else
    port_a.W = 0;
  end if;
  annotation (defaultComponentName="breaker",
    Icon(graphics={Line(points={{-90,0},{-40,0}}, color={0,0,0}),Line(points={{
              40,0},{90,0}},
                           color={0,0,0}),Line(
              points={{-40,0},{30,36},{30,34}},
              color={0,0,0},
              thickness=0.5),Ellipse(
              extent={{-42,4},{-34,-4}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{36,4},{44,-4}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,60},{0,20}},
          color={255,85,255})}),
    Documentation(info="<html>
Ideal breaker model. Can only be used to connect a generator to a grid with finite droop. Otherwise, please consider the other models in this package.
</html>"));
end BreakerOrig;
