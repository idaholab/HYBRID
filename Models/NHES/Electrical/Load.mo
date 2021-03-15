within NHES.Electrical;
model Load "Electrical load"
  parameter SI.Power Wn "Nominal active power consumption";
  parameter SI.Frequency fn=50 "Nominal frequency";

  SI.Power W "Actual power consumption";
  SI.Frequency f "Frequency";
  Modelica.Blocks.Interfaces.RealInput powerConsumption annotation (Placement(
        transformation(
        origin={-33,0},
        extent={{13,12},{-13,-12}},
        rotation=180)));
  Interfaces.ElectricalPowerPort_a portElec_a annotation (Placement(
        transformation(extent={{-10,70},{10,90}}), iconTransformation(extent={{-10,
            70},{10,90}})));
equation
  if cardinality(powerConsumption) == 1 then
    W = powerConsumption*((f - fn)/fn)
      "Power consumption determined by connector";
  else
    powerConsumption = Wn "Set the connector value (not used)";
    W = Wn*((f - fn)/fn)
      "Power consumption determined by parameter";
  end if;
  portElec_a.f = f;
  portElec_a.W = W;
  annotation (
    extent=[-20, 80; 0, 100],
    rotation=-90,
    Icon(graphics={Line(points={{0,40},{0,74}}, color={0,0,0}),Rectangle(
              extent={{-20,40},{20,-40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,-40},{0,-68}},
          color={0,0,0}),Line(points={{16,-68},{-16,-68}}, color={0,0,0}),
          Line(points={{8,-76},{-8,-76}}, color={0,0,0}),Line(points={{-2,-84},
          {4,-84}}, color={0,0,0})}),
    Placement(transformation(
        origin={-10,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
end Load;
