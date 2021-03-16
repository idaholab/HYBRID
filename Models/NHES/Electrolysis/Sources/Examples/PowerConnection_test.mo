within NHES.Electrolysis.Sources.Examples;
model PowerConnection_test
  extends Modelica.Icons.Example;

  PrescribedPowerFlow powerSource
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  PowerSink powerSink
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Sources.Ramp powerSP(
    duration=0,
    startTime=100,
    height=-2*1e6*5,
    offset=9.10627*1e6*5)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
equation
  connect(powerSP.y, powerSource.P_flow)
    annotation (Line(points={{-23,0},{-10,0}}, color={0,0,127}));
  connect(powerSource.port_b, powerSink.port_a) annotation (Line(
      points={{8,0},{19,0},{30,0}},
      color={255,0,0},
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(StopTime=1000, Interval=1),
    __Dymola_experimentSetupOutput);
end PowerConnection_test;
