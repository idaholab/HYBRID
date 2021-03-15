within NHES.Electrolysis.Machines.Examples;
model PumpControlledFlow_test
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Water.StandardWater annotation (
      __Dymola_choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT recycledWaterFeed(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=4317930,
    T=488.293,
    nPorts=1)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,0})));
  Modelica.Fluid.Sources.Boundary_pT recyledWaterSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=6270000,
    T=488.293,
    nPorts=1)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,0})));
  Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Sources.Ramp flowRate_set(
    offset=9.0942,
    height=-3,
    duration=10,
    startTime=10) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,70})));
  Modelica.Blocks.Sources.Ramp pin_signal(
    height=2e5,
    duration=10,
    offset=43.1793e5,
    startTime=50) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,30})));
  Machines.PumpControlledFlow pumpControlledFlow(
    V=1,
    initType_actuator=Modelica.Blocks.Types.Init.SteadyState,
    initType_FBctrl=Modelica.Blocks.Types.Init.SteadyState,
    rho_nominal=849.248,
    N_nominal=1498.66,
    eta_nominal=0.8,
    m_flow_start=9.0942,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=4317960,
    p_b_start=6270000,
    T_b_start=488.787)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(pin_signal.y, recycledWaterFeed.p_in) annotation (Line(points={{-79,
          30},{-70,30},{-70,8},{-62,8}}, color={0,0,127}));
  connect(recyledWaterSink.ports[1], pumpControlledFlow.port_b)
    annotation (Line(points={{40,0},{25,0},{10,0}}, color={0,127,255}));
  connect(pumpControlledFlow.port_a, recycledWaterFeed.ports[1]) annotation (
      Line(points={{-10,0},{-40,0},{-40,-1.33227e-015}}, color={0,127,255}));
  connect(TH2O_in.port, pumpControlledFlow.port_a)
    annotation (Line(points={{-30,10},{-30,0},{-10,0}}, color={0,127,255}));
  connect(TH2O_out.port, pumpControlledFlow.port_b)
    annotation (Line(points={{30,10},{30,0},{10,0}}, color={0,127,255}));
  connect(flowRate_set.y, pumpControlledFlow.flowRate_set) annotation (Line(
        points={{-39,70},{-20,70},{-20,7},{-10,7}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), experiment(StopTime=100, Interval=0.1));
end PumpControlledFlow_test;
