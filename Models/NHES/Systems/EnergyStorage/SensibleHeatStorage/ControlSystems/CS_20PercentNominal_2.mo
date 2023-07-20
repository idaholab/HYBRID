within NHES.Systems.EnergyStorage.SensibleHeatStorage.ControlSystems;
model CS_20PercentNominal_2
  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,-64491675.7;
        3600,-101392394.116; 7200,-57351374.5056; 10800,-70313172.8728; 14400,-78991527.836;
        18000,-27459855.0136; 21600,0; 25200,0; 28800,55574670.3912; 32400,
        118856922.395; 36000,133776778.5; 39600,200000000.0; 43200,200000000.0;
        46800,91791628.7136; 50400,0; 54000,0; 57600,0; 61200,0; 64800,0; 68400,
        0; 72000,0; 75600,0; 79200,0; 82800,-181977103.043; 86400,115; 90000,
        100; 93600,100; 97200,120; 100800,120; 104400,120; 108000,120; 111600,
        120])
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
end CS_20PercentNominal_2;
