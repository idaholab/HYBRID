within NHES.Systems.EnergyStorage.LithiumIonBattery.Examples;
model LiIonBattery_Level_0_Test
  "Example test of the Level_0 battery model."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,70},{-76,90}})));

  BatteryModels.BatteryLevel_0
                             battery
    annotation (Placement(transformation(extent={{-20,-22},{24,22}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1e4,
    f=0.001,
    offset=5000,
    startTime=100)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Electrical.Sources.FrequencySource      boundary
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
equation
  connect(sine.y,battery. pSetPoint)
    annotation (Line(points={{-59,50},{-30,50},{-30,0},{-20,0}},
                                               color={0,0,127}));
  connect(battery.powerConnection,boundary. portElec_b)
    annotation (Line(points={{24,0},{54,0},{54,-50},{60,-50}},
                                             color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=2000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
    <p>Assuming an ideal battery, whose output power echoes the demanded power. </p>

</html>"));
end LiIonBattery_Level_0_Test;
