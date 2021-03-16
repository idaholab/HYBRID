within NHES.Electrolysis.HeatExchangers.Examples;
model Valve_cathodeGasVessel
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=5220000,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,10})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_C_in=false,
    m_flow=6.47968,
    use_m_flow_in=true,
    T=591.15)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.Ramp steamNukeCathodeFeed_signal(
    duration=0,
    startTime=100,
    height=0,
    offset=6.46077) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,48})));
  Modelica.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    dp_nominal=0.8*((58 - 52.2)*1e5),
    m_flow_start=6.46077,
    m_flow_nominal=6.46077,
    dp_start=(58 - 52.2)*1e5)
                            annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,40})));
  Modelica.Blocks.Sources.Ramp valveOpening(
    offset=0.8,
    duration=10,
    startTime=100,
    height=-0.1*0)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,100})));
  Modelica.Fluid.Sensors.Temperature tempIn(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,44},{0,64}})));
  Modelica.Fluid.Sensors.Temperature tempOut(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{22,44},{42,64}})));
equation
  connect(steamNukeCathodeFeed_signal.y, steamNukeFeed_cathodeGas.m_flow_in)
    annotation (Line(points={{-99,48},{-99,48},{-80,48}}, color={0,0,127}));
  connect(steamNukeFeed_cathodeGas.ports[1], TCV.port_a) annotation (Line(
        points={{-60,40},{-60,40},{0,40}}, color={0,127,255}));
  connect(valveOpening.y, TCV.opening) annotation (Line(points={{19,100},
          {10,100},{10,48}}, color={0,0,127}));
  connect(tempIn.port, TCV.port_a) annotation (Line(points={{-10,44},{-10,
          40},{0,40}}, color={0,127,255}));
  connect(tempOut.port, TCV.port_b) annotation (Line(points={{32,44},{32,
          40},{20,40}}, color={0,127,255}));
  connect(steamNukeSink_cathodeGas.ports[1], TCV.port_b) annotation (Line(
        points={{80,20},{80,40},{20,40}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})),
    Icon(coordinateSystem(extent={{-120,-120},{120,120}})),
    experiment(StopTime=500, Interval=1),
    __Dymola_experimentSetupOutput);
end Valve_cathodeGasVessel;
