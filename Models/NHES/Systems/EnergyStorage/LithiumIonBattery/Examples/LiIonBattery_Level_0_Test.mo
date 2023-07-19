within NHES.Systems.EnergyStorage.LithiumIonBattery.Examples;
model LiIonBattery_Level_0_Test
  "Example test of the Level_0 battery model."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,70},{-76,90}})));

  Models.BatteryLevel_0 battery
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
<p><b><span style=\"font-size: 16pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">Simple Litium-Ion Battery model (ver.0)</span></p>
<p><br><b><span style=\"font-size: 16pt;\">Design Purpose of Exampe</span></b></p>
<p><span style=\"font-size: 12pt;\">Assuming an ideal battery, whose output power echoes the demanded power. </span></p>
<p><br><b><span style=\"font-size: 16pt;\">What Users Can Do </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 16pt;\">Reference </span></b></p>
<p><span style=\"font-size: 12pt;\">[1] <span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Wang, Haoyu, Roberto Ponciroli, and Richard B. Vilim.&nbsp;<i>Development of Electro-chemical Battery Model for Plug-and-Play Eco-system Library</i>. No. ANL/NSE-21/26. Argonne National Lab.(ANL), Argonne, IL (United States), 2021.</span></p>
<p><b><span style=\"font-size: 16pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Haoyu Wang.</span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Haoyu Wang (haoyuwang@anl.gov). </span></p>
</html>"));
end LiIonBattery_Level_0_Test;
