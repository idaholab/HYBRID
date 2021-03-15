within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model CS_Typical_Summer_Day

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
        100; 7200,88.63; 10800,83.26; 14400,76.54; 18000,73.86; 21600,76.55;
        25200,85.51; 28800,87.59; 32400,86.62; 36000,86.32; 39600,93.37; 43200,
        93.09; 46800,96.5; 50400,97.78; 54000,100.15; 57600,102.24; 61200,
        105.44; 64800,107.97; 68400,115.02; 72000,116.83; 75600,112.8; 79200,
        111.46; 82800,102.06; 86400,95.34; 90000,91.31; 93600,88.63])
    annotation (Placement(transformation(extent={{-48,-26},{-28,-6}})));
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
end CS_Typical_Summer_Day;
