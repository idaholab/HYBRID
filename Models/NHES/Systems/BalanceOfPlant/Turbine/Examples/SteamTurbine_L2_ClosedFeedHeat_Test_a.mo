within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_L2_ClosedFeedHeat_Test_a
  import NHES;

  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L2_ClosedFeedHeat BOP(
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
      CS(data(Q_Nom=45e6)),
    redeclare replaceable Data.Turbine_2 data(
      V_tee=50,
      valve_TCV_mflow=150,
      valve_TCV_dp_nominal=100000,
      valve_TBV_mflow=4,
      valve_TBV_dp_nominal=2000000,
      InternalBypassValve_p_spring=6500000,
      InternalBypassValve_K(unit="1/(m.kg)"),
      InternalBypassValve_tau(unit="1/s"),
      MainFeedHeater_K_tube(unit="1/m4"),
      MainFeedHeater_K_shell(unit="1/m4"),
      BypassFeedHeater_K_tube(unit="1/m4"),
      BypassFeedHeater_K_shell(unit="1/m4")),
    port_a_nominal(
      m_flow=67,
      p=3400000,
      h=3e6),
    port_b_nominal(p=3500000, h=1e6),
    init(
      tee_p_start=800000,
      moisturesep_p_start=700000,
      FeedwaterMixVolume_p_start=100000,
      HPT_T_b_start=578.15,
      MainFeedHeater_p_start_shell=100000,
      MainFeedHeater_h_start_shell_inlet=2e6,
      MainFeedHeater_h_start_shell_outlet=1.8e6,
      MainFeedHeater_dp_init_shell=90000,
      MainFeedHeater_m_start_tube=67,
      MainFeedHeater_m_start_shell=67,
      BypassFeedHeater_h_start_tube_inlet=1.1e6,
      BypassFeedHeater_h_start_tube_outlet=1.2e6,
      BypassFeedHeater_m_start_tube=67,
      BypassFeedHeater_m_start_shell=4))
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
    offset=170e6,
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
  annotation (experiment(
      StopTime=300,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_L2_ClosedFeedHeat_Test_a;
