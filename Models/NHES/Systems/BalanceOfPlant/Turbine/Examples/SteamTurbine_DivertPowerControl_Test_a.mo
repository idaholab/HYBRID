within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_DivertPowerControl_Test_a
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
  NHES.Fluid.Pipes.StraightPipe_withWall pipe(
    redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_a_start=3400000,
    p_b_start=3500000,
    use_Ts_start=false,
    T_a_start=421.15,
    T_b_start=579.15,
    h_a_start=3.6e6,
    h_b_start=1.2e6,
    m_flow_a_start=67,
    length=10,
    diameter=1,
    redeclare package Wall_Material = NHES.Media.Solids.SS316,
    th_wall=0.001) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(use_port=
        true, Q_flow=500e6)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=10e6,
    period=5000,
    offset=160e6,
    startTime=3000)
    annotation (Placement(transformation(extent={{-118,-10},{-98,10}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=10e6,
    f=1/20000,
    offset=38e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{72,-6},{86,6}})));
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
    intermediate_Rankine_Cycle_TESUC(
    port_a_nominal(
      p=3400000,
      h=3e6,
      m_flow=67),
    port_b_nominal(p=3400000, h=1e6),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
      CS(electric_demand=sine1.y, Overall_Power=sensorW.W))
    annotation (Placement(transformation(extent={{10,-18},{50,22}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                           color={0,0,0}));
  connect(stateSensor.port_b, pipe.port_a) annotation (Line(points={{-38,-12},{-46,
          -12},{-46,-14},{-60,-14},{-60,-10}}, color={0,127,255}));
  connect(pipe.port_b, stateSensor1.port_a)
    annotation (Line(points={{-60,10},{-60,12},{-38,12}}, color={0,127,255}));
  connect(boundary.port, pipe.heatPorts[1])
    annotation (Line(points={{-76,0},{-64.4,0},{-64.4,0.1}}, color={191,0,0}));
  connect(pulse.y, boundary.Q_flow_ext)
    annotation (Line(points={{-97,0},{-90,0}}, color={0,0,127}));
  connect(sensorW.port_b, sinkElec.port)
    annotation (Line(points={{86,0},{96,0}}, color={255,0,0}));
  connect(stateSensor1.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
    annotation (Line(points={{-18,12},{4,12},{4,10},{10,10}}, color={0,127,255}));
  connect(stateSensor.port_a, intermediate_Rankine_Cycle_TESUC.port_b)
    annotation (Line(points={{-18,-12},{4,-12},{4,-6},{10,-6}}, color={0,127,
          255}));
  connect(intermediate_Rankine_Cycle_TESUC.portElec_b, sensorW.port_a)
    annotation (Line(points={{50,2},{66,2},{66,0},{72,0}}, color={255,0,0}));
  annotation (experiment(StopTime=50000, __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_DivertPowerControl_Test_a;
