within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model Intermediate_Rankine_Cycle_Test_a
  import NHES;

  parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
  parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle BOP(
  port_a_nominal(
      m_flow=493.7058,
      p=14000000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)))
    annotation (Placement(transformation(extent={{-22,-30},{38,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-72,-60},{-28,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-72,20},{-26,50}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="MPa") = BOP.port_b_nominal.p,
    T(displayUnit="K") = BOP.port_b_nominal.T)
    annotation (Placement(transformation(extent={{-94,-2},{-74,-22}})));
  Modelica.Fluid.Sources.Boundary_ph boundary1(nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="MPa") = BOP.port_a_nominal.p,
    h = BOP.port_a_nominal.h)
    annotation (Placement(transformation(extent={{-94,2},{-74,22}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-49,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-40,-12},{-22,-12}}, color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-40,12},{-22,12}}, color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{38,0},{70,0}}, color={255,0,0}));
  connect(stateSensor.port_b, sink.ports[1])
    annotation (Line(points={{-60,-12},{-74,-12}}, color={0,127,255}));
  connect(boundary1.ports[1], stateSensor1.port_a)
    annotation (Line(points={{-74,12},{-60,12}}, color={0,127,255}));
  annotation (experiment(StopTime=500));
end Intermediate_Rankine_Cycle_Test_a;
