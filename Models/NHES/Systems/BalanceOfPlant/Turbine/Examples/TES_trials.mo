within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model TES_trials
  import NHES;

  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-90,78},{-70,98}})));
  NHES.Fluid.Pipes.StraightPipe_withWall pipe(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    nV=8,
    p_a_start=3400000,
    p_b_start=3500000,
    use_Ts_start=false,
    T_a_start=421.15,
    T_b_start=579.15,
    h_a_start=1.2e6,
    h_b_start=2.2e6,
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
    amplitude=20e6,
    period=5000,
    offset=160e6,
    startTime=3000)
    annotation (Placement(transformation(extent={{-118,-10},{-98,10}})));
  NHES.Fluid.Sensors.stateSensor
                            stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{108,40},{128,20}})));
  NHES.Fluid.Sensors.stateSensor
                            stateSensor3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{144,-50},{124,-70}})));
  NHES.Fluid.Sensors.stateDisplay
                             stateDisplay2
    annotation (Placement(transformation(extent={{96,52},{140,82}})));
  NHES.Fluid.Sensors.stateDisplay
                             stateDisplay3
    annotation (Placement(transformation(extent={{126,-104},{172,-74}})));
  NHES.Fluid.Pipes.StraightPipe_withWall pipe1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nV=8,
    p_a_start=3400000,
    p_b_start=3500000,
    use_Ts_start=false,
    T_a_start=421.15,
    T_b_start=579.15,
    h_a_start=1.2e6,
    h_b_start=2.2e6,
    m_flow_a_start=67,
    length=10,
    diameter=1,
    redeclare package Wall_Material = NHES.Media.Solids.SS316,
    th_wall=0.001) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={158,2})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary1(use_port=
        true, Q_flow=500e6)
    annotation (Placement(transformation(extent={{192,12},{172,-8}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    amplitude=-20e6,
    period=5000,
    offset=-160e6,
    startTime=3000)
    annotation (Placement(transformation(extent={{212,-6},{192,14}})));
  NHES.Systems.EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR
    two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR(
      redeclare package Storage_Medium =
        NHES.Media.Hitec.ConstantPropertyLiquidHitec, redeclare package
      Charging_Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{10,-8},{40,16}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=20,
    use_input=false,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=180,
        origin={87,-61})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow2(
    m_flow_nominal=20,
    use_input=false,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He)
                                                         annotation (
      Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=180,
        origin={-5,-5})));
equation

  connect(boundary.port, pipe.heatPorts[1])
    annotation (Line(points={{-76,0},{-64.4,0},{-64.4,-1.25625}},
                                                             color={191,0,0}));
  connect(pulse.y, boundary.Q_flow_ext)
    annotation (Line(points={{-97,0},{-90,0}}, color={0,0,127}));
  connect(stateDisplay3.statePort,stateSensor3. statePort) annotation (Line(
        points={{149,-92.9},{149,-108},{118,-108},{118,-60.05},{133.95,-60.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay2.statePort, stateSensor2.statePort) annotation (Line(
        points={{118,63.1},{118,29.95},{118.05,29.95}}, color={0,0,0}));
  connect(stateSensor2.port_b, pipe1.port_a)
    annotation (Line(points={{128,30},{158,30},{158,12}}, color={0,127,255}));
  connect(pipe1.port_b, stateSensor3.port_a) annotation (Line(points={{158,-8},
          {158,-60},{144,-60}}, color={0,127,255}));
  connect(boundary1.port, pipe1.heatPorts[1]) annotation (Line(points={{172,2},
          {167.2,2},{167.2,3.25625},{162.4,3.25625}}, color={191,0,0}));
  connect(pulse1.y, boundary1.Q_flow_ext)
    annotation (Line(points={{191,4},{191,2},{186,2}}, color={0,0,127}));
  connect(stateSensor2.port_a,
    two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR.port_dch_a)
    annotation (Line(points={{108,30},{46,30},{46,10.96},{39.7,10.96}}, color={
          0,127,255}));
  connect(stateSensor3.port_b, pump_SimpleMassFlow1.port_a) annotation (Line(
        points={{124,-60},{112,-60},{112,-61},{96,-61}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b,
    two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR.port_dch_b)
    annotation (Line(points={{78,-61},{46,-61},{46,-3.44},{40,-3.44}}, color={0,
          127,255}));
  connect(
    two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR.port_ch_a,
    pump_SimpleMassFlow2.port_a) annotation (Line(points={{10.3,-4.4},{7.15,
          -4.4},{7.15,-5},{4,-5}}, color={0,127,255}));
  connect(pump_SimpleMassFlow2.port_b, pipe.port_a) annotation (Line(points={{
          -14,-5},{-44,-5},{-44,-10},{-60,-10}}, color={0,127,255}));
  connect(pipe.port_b,
    two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR.port_ch_b)
    annotation (Line(points={{-60,10},{-26.05,10},{-26.05,10.48},{7.9,10.48}},
        color={0,127,255}));
  annotation (experiment(
      StopTime=10000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end TES_trials;
