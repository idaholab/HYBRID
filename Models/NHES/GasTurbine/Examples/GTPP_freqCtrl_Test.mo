within NHES.GasTurbine.Examples;
model GTPP_freqCtrl_Test
  extends Modelica.Icons.Example;

  PowerPlant.GTPP_freqCtrl GTPP "Natural-gas fired gas turbine power plant"
    annotation (Placement(transformation(extent={{-48,-48},{48,48}})));
  Sources.PrescribedLoad elecLoad
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Ramp loadSignal1(
      duration=0,
      offset=35*1e6,
      startTime=10,
      height=-3.5*1e6*5) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={90,74})));
  Modelica.Blocks.Math.Add sumLoads annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={68,18})));
  Modelica.Blocks.Sources.Ramp loadSignal2(
    duration=0,
    offset=0,
    startTime=40,
    height=3.5*1e6*3.1)        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,40})));
  Interfaces.SignalBus signalBus
    annotation (Placement(transformation(extent={{-20,50},{20,90}})));
equation
    connect(elecLoad.powerConsumption, sumLoads.y)
      annotation (Line(points={{68,3},{68,9.2}}, color={0,0,127}));
    connect(loadSignal1.y, sumLoads.u2) annotation (Line(points={{79,74},{
            63.2,74},{63.2,27.6}}, color={0,0,127}));
    connect(loadSignal2.y, sumLoads.u1) annotation (Line(points={{79,40},{
            72.8,40},{72.8,27.6}}, color={0,0,127}));
    connect(elecLoad.load, GTPP.portElec_b) annotation (Line(
        points={{60,0},{48,0}},
        color={255,0,0},
        thickness=0.5));
    connect(GTPP.signalBus, signalBus.Signals_ESE) annotation (Line(
        points={{0,48},{0,59},{0,70}},
        color={255,204,51},
        thickness=0.5));
  annotation (
    experiment(StopTime=80, Interval=0.1),
    experimentSetupOutput,
    Documentation(info="<html>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end GTPP_freqCtrl_Test;
