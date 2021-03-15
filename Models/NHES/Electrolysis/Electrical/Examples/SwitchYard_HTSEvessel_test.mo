within NHES.Electrolysis.Electrical.Examples;
model SwitchYard_HTSEvessel_test
  extends Modelica.Icons.Example;

  Sources.PrescribedPowerFlow powerSource
    annotation (Placement(transformation(extent={{40,-2},{20,18}})));
  Sources.PowerSink SOECelec_sink
    annotation (Placement(transformation(extent={{20,-18},{40,2}})));
  Modelica.Blocks.Sources.Ramp powerSP(
    duration=0,
    startTime=100,
    offset=9.10627*1e6*5,
    height=-2*1e6*3)
    annotation (Placement(transformation(extent={{70,-2},{50,18}})));
  SwitchYard_vessel switchYard
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sources.PrescribedLoad load_catElecHeater
    annotation (Placement(transformation(extent={{-20,-2},{-40,18}})));
  Modelica.Blocks.Sources.Ramp load_catElecHeaterSignal(
    duration=0,
    offset=2*1e6,
    height=-1*1e6,
    startTime=150)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Ramp load_anElecHeaterSignal(
    duration=0,
    startTime=100,
    height=0,
    offset=3*1e6)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Sources.PrescribedLoad load_anElecHeater
    annotation (Placement(transformation(extent={{-40,-18},{-60,2}})));
equation
  connect(powerSP.y, powerSource.P_flow)
    annotation (Line(points={{49,8},{38,8}},   color={0,0,127}));
  connect(load_catElecHeaterSignal.y, load_catElecHeater.powerConsumption)
    annotation (Line(points={{-39,50},{-28,50},{-28,11}}, color={0,0,127}));
  connect(load_anElecHeaterSignal.y, load_anElecHeater.powerConsumption)
    annotation (Line(points={{-57,10},{-48,10},{-48,-5}}, color={0,0,127}));
  connect(load_catElecHeater.load, switchYard.load_catElecHeater)
    annotation (Line(points={{-20,8},{-14,8},{-8,8}}, color={255,0,0}));
  connect(load_anElecHeater.load, switchYard.load_anElecHeater)
    annotation (Line(points={{-40,-8},{-24,-8},{-8,-8}}, color={255,0,0}));
  connect(switchYard.load_SOEC, SOECelec_sink.port_a)
    annotation (Line(points={{8,-8},{14,-8},{20,-8}}, color={255,0,0}));
  connect(powerSource.port_b, switchYard.totalElecPower)
    annotation (Line(points={{20,8},{14,8},{8,8}}, color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=200, Interval=1),
    __Dymola_experimentSetupOutput);
end SwitchYard_HTSEvessel_test;
