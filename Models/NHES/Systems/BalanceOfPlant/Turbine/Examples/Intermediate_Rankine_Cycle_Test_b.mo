within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model Intermediate_Rankine_Cycle_Test_b
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_TESUC
                                                                 BOP(
  port_a_nominal(
      m_flow=70,
      p=3500000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=3400000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)))
    annotation (Placement(transformation(extent={{-22,-32},{38,28}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="MPa") = BOP.port_b_nominal.p,
    T(displayUnit="K") = BOP.port_b_nominal.T)
    annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-72,-60},{-28,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-72,20},{-28,50}})));
  Modelica.Fluid.Sources.Boundary_ph      source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=BOP.port_a_nominal.p,
    h=BOP.port_a_nominal.h,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=100,
    startTime=10,
    offset=BOP.port_a_nominal.p,
    amplitude=0.05*BOP.port_a_nominal.p)
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
  connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
          {-64,-12},{-60,-12}}, color={0,127,255}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-40,-12},{-32,-12},{-32,-14},{-22,-14}},
                                                   color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-40,12},{-32,12},{-32,10},{-22,10}},
                                                 color={0,127,255}));
  connect(source.ports[1], stateSensor1.port_a)
    annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
  connect(pulse.y, source.p_in)
    annotation (Line(points={{-99,20},{-90,20}}, color={0,0,127}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{38,-2},{54,-2},{54,0},{70,0}},
                                             color={255,0,0}));
  annotation (experiment(StopTime=500, __Dymola_Algorithm="Esdirk45a"));
end Intermediate_Rankine_Cycle_Test_b;
