within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_NoFeedHeat_Test_b
  import NHES;

  parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
  parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

  extends Modelica.Icons.Example;
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{116,-10},{96,10}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-18,-22},{-38,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-52,-60},{-8,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-52,30},{-6,60}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=10e6,
    f=1/20000,
    offset=38e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{72,-6},{86,6}})));
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
    intermediate_Rankine_Cycle_TESUC(
    port_a_nominal(
      p=1100000,
      h=2e6,
      m_flow=26),
    port_b_nominal(p=1300000, h=1e6),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat
      CS(electric_demand=const.y, data(Q_Nom=0)))
    annotation (Placement(transformation(extent={{10,-18},{50,22}})));
  Modelica.Blocks.Sources.Constant const(k=18e6)
    annotation (Placement(transformation(extent={{-2,70},{18,90}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 1200000,
    T(displayUnit="degC") = 491.15)
    annotation (Placement(transformation(extent={{-88,22},{-68,2}})));
  Modelica.Fluid.Sources.Boundary_pT sink1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 1200000,
    T(displayUnit="degC") = 421.15)
    annotation (Placement(transformation(extent={{-88,-6},{-68,-26}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                           color={0,0,0}));
  connect(sensorW.port_b, sinkElec.port)
    annotation (Line(points={{86,0},{96,0}}, color={255,0,0}));
  connect(stateSensor1.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
    annotation (Line(points={{-18,12},{4,12},{4,10},{10,10}}, color={0,127,255}));
  connect(stateSensor.port_a, intermediate_Rankine_Cycle_TESUC.port_b)
    annotation (Line(points={{-18,-12},{4,-12},{4,-6},{10,-6}}, color={0,127,
          255}));
  connect(intermediate_Rankine_Cycle_TESUC.portElec_b, sensorW.port_a)
    annotation (Line(points={{50,2},{66,2},{66,0},{72,0}}, color={255,0,0}));
  connect(sink.ports[1], stateSensor1.port_a)
    annotation (Line(points={{-68,12},{-38,12}}, color={0,127,255}));
  connect(sink1.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-16},
          {-52,-16},{-52,-12},{-38,-12}}, color={0,127,255}));
  annotation (experiment(StopTime=50000, __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_NoFeedHeat_Test_b;
