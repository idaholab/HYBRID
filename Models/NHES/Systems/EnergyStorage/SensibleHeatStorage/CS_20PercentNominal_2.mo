within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model CS_20PercentNominal_2
  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,-64491675.7;
        3600,-101392394.116; 7200,-57351374.5056; 10800,-70313172.8728; 14400,-78991527.836;
        18000,-27459855.0136; 21600,0; 25200,0; 28800,55574670.3912; 32400,
        118856922.395; 36000,133776778.5; 39600,200000000.0; 43200,200000000.0;
        46800,91791628.7136; 50400,0; 54000,0; 57600,0; 61200,0; 64800,0; 68400,
        0; 72000,0; 75600,0; 79200,0; 82800,-181977103.043; 86400,115; 90000,
        100; 93600,100; 97200,120; 100800,120; 104400,120; 108000,120; 111600,
        120])
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
end CS_20PercentNominal_2;
