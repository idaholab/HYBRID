within NHES.Electrolysis.Examples;
model HTSE_FY17
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Electrolysis.HTSE.HTSEplant_FY17 hTSEplant
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Fluid.Sources.Boundary_pT steamSource(
    use_p_in=false,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5800000,
    T=591.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,6},{-60,26}})));
  Modelica.Fluid.Sources.Boundary_pT steamSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5130420,
    T=497.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-16})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,0})));
  Modelica.Blocks.Sources.Ramp power_set(
    startTime=100,
    offset=9.10627*1e6*5 + 7771944.2,
    duration=0,
    height=-1.929*1e6*5*1 + 1613748*1 + 1658789.33*0 - 339049.79*0)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,0})));
equation
  connect(steamSink.ports[1], hTSEplant.port_b)
    annotation (Line(points={{-60,-16},{-40,-16}}, color={0,127,255}));
  connect(steamSource.ports[1], hTSEplant.port_a)
    annotation (Line(points={{-60,16},{-40,16}}, color={0,127,255}));
  connect(prescribedPowerFlow.port_b, hTSEplant.portElec_a) annotation (
      Line(
      points={{50,0},{50,0},{40,0}},
      color={255,0,0},
      thickness=0.5));
  connect(prescribedPowerFlow.P_flow, power_set.y)
    annotation (Line(points={{68,0},{68,0},{79,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=3600,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_FY17;
