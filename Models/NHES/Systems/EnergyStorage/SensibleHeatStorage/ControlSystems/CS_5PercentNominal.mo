within NHES.Systems.EnergyStorage.SensibleHeatStorage.ControlSystems;
model CS_5PercentNominal
  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
        81.9; 7200,76.9; 10800,70.7; 14400,68.2; 18000,70.7; 21600,84.38; 25200,
        93.06; 28800,95.5; 32400,96.78; 36000,101.75; 39600,102.99; 43200,
        106.71; 46800,107.95; 50400,109.2; 54000,110.43; 57600,112.9; 61200,
        111.67; 64800,109.195; 68400,107.95; 72000,104.23; 75600,103; 79200,
        94.3; 82800,88.1; 86400,84.37; 90000,81.9; 93600,100])
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
equation

  connect(actuatorBus.Demand, ReactorDemandSimulator.y) annotation (Line(
      points={{30.1,-99.9},{122,-99.9},{122,0},{101,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_balance, W_balance.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="ES_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_5PercentNominal;
