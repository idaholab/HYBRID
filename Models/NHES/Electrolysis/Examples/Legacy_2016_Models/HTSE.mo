within NHES.Electrolysis.Examples.Legacy_2016_Models;
model HTSE
  import NHES.Electrolysis;
  extends Modelica.Icons.Example;

  Electrolysis.HTSE.HTSEplant hTSEplant
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-80,6},{-62,24}})));
  Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=488.293) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-71,-15})));
  Modelica.Blocks.Sources.Ramp We_set(
    offset=9.10627*1e6*5,
    duration=0,
    startTime=100,
    height=-1.929*1e6*5*1)
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,20})));
  Electrolysis.Sensors.PowerSensor We_SOEC annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={56,0})));
  Interfaces.SignalBus signalBus annotation (Placement(transformation(extent={{-20,
            40},{20,80}}), iconTransformation(extent={{-20,40},{20,80}})));
equation
  connect(heatingMedium_out.ports[1], hTSEplant.port_b) annotation (Line(
        points={{-62,-15},{-58,-15},{-40,-15}}, color={0,127,255}));
  connect(heatingMedium_in.ports[1], hTSEplant.port_a) annotation (Line(
        points={{-62,15},{-40,15}},            color={0,127,255}));
  connect(We_SOEC.port_b, hTSEplant.portElec_a) annotation (Line(
      points={{48,9.71445e-016},{45,9.71445e-016},{45,0},{40,0}},
      color={255,0,0},
      thickness=0.3));
  connect(We_set.y, prescribedPowerFlow.P_flow)
    annotation (Line(points={{79,40},{70,40},{70,28}},   color={0,0,127}));
  connect(hTSEplant.signalBus, signalBus.Signals_IP) annotation (Line(
      points={{0,40},{0,60}},
      color={255,204,51},
      thickness=0.5));
  connect(We_SOEC.W, signalBus.Signals_IP.c_We_SOEC)
    annotation (Line(points={{56,7.52},{56,60},{0,60}}, color={255,204,51},
      thickness=0.5));
  connect(We_SOEC.port_a, prescribedPowerFlow.port_b) annotation (Line(
      points={{64,0},{70,0},{70,10}},
      color={255,0,0},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=6100, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE;
