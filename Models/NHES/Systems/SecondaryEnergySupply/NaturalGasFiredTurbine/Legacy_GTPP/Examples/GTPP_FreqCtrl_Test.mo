within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Legacy_GTPP.Examples;
model GTPP_FreqCtrl_Test
  extends Modelica.Icons.Example;

  Legacy_GTPP.GTPP_FreqCtrl SES
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  GasTurbine.Sources.PrescribedLoad elecLoad
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  Modelica.Blocks.Sources.Ramp loadSignal1(
      duration=0,
      offset=35*1e6,
      startTime=10,
      height=-3.5*1e6*5) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={80,74})));
  Modelica.Blocks.Math.Add sumLoads annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={56,18})));
  Modelica.Blocks.Sources.Ramp loadSignal2(
    duration=0,
    offset=0,
    startTime=40,
    height=3.5*1e6*3.1)        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,40})));
equation

    connect(elecLoad.powerConsumption,sumLoads. y)
      annotation (Line(points={{56,3},{56,9.2}}, color={0,0,127}));
    connect(loadSignal1.y,sumLoads. u2) annotation (Line(points={{69,74},
          {51.2,74},{51.2,27.6}},  color={0,0,127}));
    connect(loadSignal2.y,sumLoads. u1) annotation (Line(points={{69,40},
          {60.8,40},{60.8,27.6}},  color={0,0,127}));
  connect(SES.portElec_b, elecLoad.load)
    annotation (Line(points={{30,0},{30,0},{48,0}},       color={255,0,0}));
  annotation (experiment(StopTime=80, Interval=0.1));
end GTPP_FreqCtrl_Test;
