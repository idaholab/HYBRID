within NHES.Systems.EnergyStorage.LithiumIonBattery.Examples;
model LiIonBattery_Level_1_Test
  "Example test of the Level_1 battery model."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,70},{-76,90}})));

  BatteryModels.BatteryLevel_1
                             battery
    annotation (Placement(transformation(extent={{-20,-22},{24,22}})));
  Electrical.Sources.FrequencySource      boundary
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=200e3,
    f=1e-4,
    startTime=1000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(battery.powerConnection,boundary. portElec_b)
    annotation (Line(points={{24,0},{54,0},{54,-50},{60,-50}},
                                             color={255,0,0}));
  connect(sine.y, battery.pSetPoint) annotation (Line(points={{-59,50},{-30,50},
          {-30,0},{-20,0}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=20000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
    <p>This battery has built-in input/output power regulator. </p>
    <p>The constraints of max charging power and max discharging power can be specified in the battery model. </p>
    <p>In addition to the hard constraints, </p>
    <p>When charging, the input power will gradually decrease when the charging level is approaching the max capacity. </p>
    <p>When discharging, the output power will gradually decrease when the capacity is approaching the emptyness. </p>

</html>"));
end LiIonBattery_Level_1_Test;
