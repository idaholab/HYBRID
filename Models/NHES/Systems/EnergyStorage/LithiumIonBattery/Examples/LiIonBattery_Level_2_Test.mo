within NHES.Systems.EnergyStorage.LithiumIonBattery.Examples;
model LiIonBattery_Level_2_Test
  "Example test of the Level_2 battery model."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,70},{-76,90}})));

  BatteryModels.BatteryLevel_2
                             battery
    annotation (Placement(transformation(extent={{-20,-22},{24,22}})));
  Electrical.Sources.FrequencySource      boundary
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Blocks.Sources.Trapezoid
                                trapezoid(
    amplitude=10,
    rising=1,
    width=5000,
    falling=1,
    period=10000,
    offset=-5,
    startTime=1000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(battery.powerConnection,boundary. portElec_b)
    annotation (Line(points={{24,0},{54,0},{54,-50},{60,-50}},
                                             color={255,0,0}));
  connect(trapezoid.y, battery.pSetPoint) annotation (Line(points={{-59,50},{-30,
          50},{-30,0},{-20,0}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=30000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
    <p>This battery's EMF is specified by the charging and discharging curve, defined using the E0, K, A, InvB parameters.</p>
    <p>'_C' is for charging and '_D' is for discharging.</p>
    <p>The constraints of max charging power and max discharging power can be specified in the battery model. </p>
    <p>Four protection features are implimented in this model:</p>

    <p>1. Over-charge / Over-discharge protection;</p>
    <p>2. Over-current protection;</p>
    <p>3. Over-voltage protection;</p>
    <p>4. Over-power protection.</p>

</html>"));
end LiIonBattery_Level_2_Test;
