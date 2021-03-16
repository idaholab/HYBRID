within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model CS_20PercentNominal
  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
        100; 7200,95; 10800,85; 14400,80; 18000,80; 21600,80; 25200,80; 28800,
        95; 32400,100; 36000,105; 39600,115; 43200,120; 46800,120; 50400,120;
        54000,120; 57600,120; 61200,115; 64800,105; 68400,110; 72000,100; 75600,
        105; 79200,95; 82800,100; 86400,115; 90000,100; 93600,100; 97200,120;
        100800,120; 104400,120; 108000,120; 111600,120])
    annotation (Placement(transformation(extent={{-48,-26},{-28,-6}})));

  extends BaseClasses.Partial_ControlSystem;

equation

  connect(ReactorDemandSimulator.y, actuatorBus.Demand)
    annotation (Line(points={{-27,-16},{30.1,-16},{30.1,-99.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
annotation(defaultComponentName="ES_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_20PercentNominal;
