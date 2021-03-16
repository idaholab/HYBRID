within NHES.Systems.EnergyStorage.Battery.Examples;
model Logical_Test

  extends Modelica.Icons.Example;
  Logical ES annotation (Placement(transformation(extent={{-32,-30},{28,30}})));
  Electrical.Sources.FrequencySource boundary(f=60)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
equation
  connect(ES.portElec_b, boundary.portElec_b)
    annotation (Line(points={{28,0},{50,0}}, color={255,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=10,
      __Dymola_Algorithm="Esdirk45a"));
end Logical_Test;
