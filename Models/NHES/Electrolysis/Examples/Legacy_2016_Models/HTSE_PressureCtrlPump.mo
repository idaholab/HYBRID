within NHES.Electrolysis.Examples.Legacy_2016_Models;
model HTSE_PressureCtrlPump
  import NHES.Electrolysis;
  extends Modelica.Icons.Example;

  Electrolysis.HTSE.HTSEplant_PressureCtrlPump hTSEplant
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
    p=4702500,
    T=488.896) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-91,-15})));
  Modelica.Blocks.Sources.Ramp We_set(
    offset=9.10627*1e6*5,
    duration=0,
    startTime=100,
    height=-1.929*1e6*5*3)
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
  Modelica.Fluid.Valves.ValveLinear PCV_heatingMedium_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    dp_nominal=0.85*((62.7 - 47.025)*1e5),
    dp_start=0.85*((62.7 - 47.025)*1e5),
    m_flow_start=9.0942,
    m_flow_nominal=9.0942) annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=180,
        origin={-61,-15})));
  Modelica.Blocks.Sources.Ramp valveOpening(
    offset=0.85,
    startTime=100,
    duration=0,
    height=(4.71597/9.0942 - 1)*0.85)
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-50})));
equation
  connect(heatingMedium_in.ports[1], hTSEplant.port_a) annotation (Line(
        points={{-62,15},{-62,15},{-40,15}},   color={0,127,255}));
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
  connect(heatingMedium_out.ports[1], PCV_heatingMedium_out.port_b)
    annotation (Line(points={{-82,-15},{-78,-15},{-70,-15}}, color={0,127,
          255}));
  connect(PCV_heatingMedium_out.port_a, hTSEplant.port_b) annotation (Line(
        points={{-52,-15},{-46,-15},{-40,-15}}, color={0,127,255}));
  connect(valveOpening.y, PCV_heatingMedium_out.opening) annotation (Line(
        points={{-79,-50},{-61,-50},{-61,-22.2}}, color={0,0,127}));
  connect(prescribedPowerFlow.port_b, We_SOEC.port_a) annotation (Line(
      points={{70,10},{70,0},{64,0}},
      color={255,0,0},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=8100, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_PressureCtrlPump;
