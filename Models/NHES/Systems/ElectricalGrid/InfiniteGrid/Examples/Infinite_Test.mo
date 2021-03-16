within NHES.Systems.ElectricalGrid.InfiniteGrid.Examples;
model Infinite_Test
  extends Modelica.Icons.Example;
  Infinite EG annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  Electrical.Sources.PowerSource boundary(W=1e7)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
equation

  connect(boundary.portElec_a, EG.portElec_a)
    annotation (Line(points={{-50,0},{-50,0},{-30,0}},
                                             color={255,0,0}));
  annotation (experiment(StopTime=10, __Dymola_NumberOfIntervals=10));
end Infinite_Test;
