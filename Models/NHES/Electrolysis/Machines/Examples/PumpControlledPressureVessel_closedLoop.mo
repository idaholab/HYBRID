within NHES.Electrolysis.Machines.Examples;
model PumpControlledPressureVessel_closedLoop
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT cathodeStreamSource(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = system.p_ambient,
    T=system.T_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=
        298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeStreamSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="bar") = 2045000)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Modelica.Fluid.Sensors.Temperature tempOut(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Fluid.Sensors.Temperature tempIn(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    m_flow(start=4.48466),
    dp_nominal=0.8*((23.702130533186 - 20.45)*1e5),
    m_flow_nominal=4.48466,
    m_flow_start=4.48466,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_start=((23.702130533186 - 20.45)*1e5))
                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,0})));
  Modelica.Blocks.Sources.Ramp valveOpening(
    duration=0,
    offset=0.8,
    height=-0.1,
    startTime=100) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,30})));
  PumpControlledPressureVessel feedPump(
    V=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    FBctrl_pH2O_out_k=(1/699.066666666667)*3,
    FBctrl_pH2O_out_T=7.86284785139149 + 6.29027828111319*0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(cathodeStreamSink.ports[1], FCV_catSOEC.port_b)
    annotation (Line(points={{80,0},{70,0},{60,0}}, color={0,127,255}));
  connect(valveOpening.y, FCV_catSOEC.opening)
    annotation (Line(points={{59,30},{50,30},{50,8}}, color={0,0,127}));
  connect(FCV_catSOEC.port_a, feedPump.port_b)
    annotation (Line(points={{40,0},{25,0},{10,0}}, color={0,127,255}));
  connect(cathodeStreamSource.ports[1], feedPump.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(tempIn.port, feedPump.port_a) annotation (Line(points={{-20,20},{
          -20,0},{-10,0}}, color={0,127,255}));
  connect(tempOut.port, feedPump.port_b)
    annotation (Line(points={{20,20},{20,0},{10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=360, Interval=0.1));
end PumpControlledPressureVessel_closedLoop;
