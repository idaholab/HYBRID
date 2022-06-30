within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model Intermediate_Rankine_Cycle_Test_d
  import NHES;

  parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
  parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_3 BOP(
  port_a_nominal(
      m_flow=493.7058,
      p=14000000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)))
    annotation (Placement(transformation(extent={{0,-30},{60,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
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
    p_a_start=5000000,
    p_b_start=5000000,
    use_Ts_start=false,
    h_a_start=3.6e6,
    h_b_start=1.2e6,
    m_flow_a_start=180,
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
    offset=60e6,
    startTime=3000)
    annotation (Placement(transformation(extent={{-118,-10},{-98,10}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                           color={0,0,0}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-18,-12},{0,-12}},   color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-18,12},{0,12}},   color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
  connect(stateSensor.port_b, pipe.port_a) annotation (Line(points={{-38,-12},{-46,
          -12},{-46,-14},{-60,-14},{-60,-10}}, color={0,127,255}));
  connect(pipe.port_b, stateSensor1.port_a)
    annotation (Line(points={{-60,10},{-60,12},{-38,12}}, color={0,127,255}));
  connect(boundary.port, pipe.heatPorts[1])
    annotation (Line(points={{-76,0},{-64.4,0},{-64.4,0.1}}, color={191,0,0}));
  connect(pulse.y, boundary.Q_flow_ext)
    annotation (Line(points={{-97,0},{-90,0}}, color={0,0,127}));
  annotation (experiment(StopTime=50000, __Dymola_Algorithm="Dassl"));
end Intermediate_Rankine_Cycle_Test_d;
