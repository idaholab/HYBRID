within NHES.Systems.EnergyStorage.SensibleHeatStorage.ControlSystems;
model CS_20PercentNominal
  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
        100; 7200,95; 10800,85; 14400,80; 18000,80; 21600,80; 25200,80; 28800,
        95; 32400,100; 36000,105; 39600,115; 43200,120; 46800,120; 50400,120;
        54000,120; 57600,120; 61200,115; 64800,105; 68400,110; 72000,100; 75600,
        105; 79200,95; 82800,100; 86400,115; 90000,100; 93600,100; 97200,120;
        100800,120; 104400,120; 108000,120; 111600,120])
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
equation

  connect(actuatorBus.Demand, ReactorDemandSimulator.y) annotation (Line(
      points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
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
end CS_20PercentNominal;
