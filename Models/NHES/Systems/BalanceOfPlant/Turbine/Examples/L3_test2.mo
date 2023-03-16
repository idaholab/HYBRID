within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L3_test2
  extends Modelica.Icons.Example;
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(redeclare package Medium =
        Modelica.Media.Water.StandardWater, Q_gen=35e6)
    annotation (Placement(transformation(extent={{-148,8},{-128,28}})));
equation
  connect(BOP.port_a_elec, boundary.port)
    annotation (Line(points={{42,0},{60,0}}, color={255,0,0}));
  connect(volume.port_b, BOP.port_a_steam) annotation (Line(points={{-132,18},{
          -48,18},{-48,24},{-38,24}}, color={0,127,255}));
  connect(BOP.port_b_feed, volume.port_a) annotation (Line(points={{-38,-24},{
          -154,-24},{-154,18},{-144,18}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2500,
      Interval=17.87,
      __Dymola_Algorithm="Esdirk45a"));
end L3_test2;
