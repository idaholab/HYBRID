within NHES.Electrical.Examples;
model BatteryTest

  extends Modelica.Icons.Example;

  Battery battery(
    capacity_max=100,
    capacity_min=2,
    chargePower_max=0.5e4,
    chargePower_min=1e3,
    dischargePower_max=0.5e4,
    dischargePower_min=1e3,
    capacityFrac_start=0.5)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=100,
    startTime=10,
    height=1e4)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=200,
    height=-2e4,
    startTime=ramp.startTime + ramp.duration + 50)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Sources.FrequencySource boundary(f=60)
    annotation (Placement(transformation(extent={{92,-10},{72,10}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    startTime=ramp1.startTime + ramp1.duration + 50,
    height=2e4,
    duration=100)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(ramp1.y, add.u2) annotation (Line(points={{-79,-30},{-70,-30},{-70,-6},
          {-62,-6}}, color={0,0,127}));
  connect(ramp.y, add.u1) annotation (Line(points={{-79,30},{-70,30},{-70,6},{
          -62,6}}, color={0,0,127}));
  connect(battery.port, boundary.portElec_b)
    annotation (Line(points={{52,0},{62,0},{72,0}}, color={255,0,0}));
  connect(add.y, add1.u1) annotation (Line(points={{-39,0},{-30,0},{-30,6},{-12,
          6}}, color={0,0,127}));
  connect(ramp2.y, add1.u2) annotation (Line(points={{-29,-30},{-20,-30},{-20,
          -6},{-12,-6}}, color={0,0,127}));
  connect(add1.y, battery.W_setpoint)
    annotation (Line(points={{11,0},{31.2,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
end BatteryTest;
