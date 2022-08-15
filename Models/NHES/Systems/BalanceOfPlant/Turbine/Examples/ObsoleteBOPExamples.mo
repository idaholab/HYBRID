within NHES.Systems.BalanceOfPlant.Turbine.Examples;
package ObsoleteBOPExamples
  model SteamTurbine_L2
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
      intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR(
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
        CS(electric_demand=sine.y, Overall_Power=sensorW.W),
      port_a_nominal(
        p=3400000,
        h=3e6,
        m_flow=67),
      port_b_nominal(p=3400000, h=1e6))
      annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3400000,
      T(displayUnit="degC") = 421.15)
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
    Modelica.Fluid.Sources.MassFlowSource_h source1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=10,
      h=2e6,
      nPorts=1)
      annotation (Placement(transformation(extent={{-48,-88},{-28,-68}})));
    Modelica.Fluid.Sources.Boundary_ph source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p=3400000,
      h=3e6,
      use_p_in=false)
      annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{46,-6},{60,6}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=10e6,
      f=1/20000,
      offset=38e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{-56,58},{-36,78}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
    connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
            {-64,-12},{-60,-12}}, color={0,127,255}));
    connect(stateSensor.port_a,
      intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.port_b)
      annotation (Line(points={{-40,-12},{-30,-12}}, color={0,127,255}));
    connect(stateSensor1.port_b,
      intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.port_a)
      annotation (Line(points={{-40,12},{-30,12}}, color={0,127,255}));
    connect(source.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
    connect(source1.ports[1], intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.port_a1)
      annotation (Line(points={{-28,-78},{-22,-78},{-22,-28.8},{-19.2,-28.8}},
          color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.portElec_b,
      sensorW.port_a) annotation (Line(points={{30,0},{46,0}}, color={255,0,0}));
    connect(sensorW.port_b, sinkElec.port)
      annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
    annotation (experiment(StopTime=500));
  end SteamTurbine_L2;

  model SteamTurbine_L3
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat
        CS(electric_demand=sine.y),
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=26),
      port_b_nominal(p=1200000, h=1e6))
      annotation (Placement(transformation(extent={{-32,-30},{28,30}})));

    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 1200000,
      T(displayUnit="degC") = 421.15)
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
    Modelica.Fluid.Sources.Boundary_ph source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p=1200000,
      h=2e6,
      use_p_in=false)
      annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{46,-6},{60,6}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=10e6,
      f=1/20000,
      offset=2e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{-56,58},{-36,78}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
    connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
            {-64,-12},{-60,-12}}, color={0,127,255}));
    connect(stateSensor.port_a,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
      annotation (Line(points={{-40,-12},{-32,-12}}, color={0,127,255}));
    connect(stateSensor1.port_b,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
      annotation (Line(points={{-40,12},{-32,12}}, color={0,127,255}));
    connect(source.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
      sensorW.port_a) annotation (Line(points={{28,0},{46,0}}, color={255,0,0}));
    connect(sensorW.port_b, sinkElec.port)
      annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
    annotation (experiment(StopTime=500));
  end SteamTurbine_L3;

  model SteamTurbine_L4
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L2_ClosedFeedHeat
      intermediate_Rankine_Cycle_4_1(
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_6
        CS,
      port_a_nominal(
        p=3400000,
        h=3e6,
        m_flow=67),
      port_b_nominal(p=3400000, h=1e6))
      annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3400000,
      T(displayUnit="degC") = 421.15)
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
    Modelica.Fluid.Sources.Boundary_ph source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p=3400000,
      h=3e6,
      use_p_in=false)
      annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{46,-6},{60,6}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=10e6,
      f=1/20000,
      offset=38e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{-56,58},{-36,78}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
    connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
            {-64,-12},{-60,-12}}, color={0,127,255}));
    connect(stateSensor.port_a, intermediate_Rankine_Cycle_4_1.port_b)
      annotation (Line(points={{-40,-12},{-30,-12}}, color={0,127,255}));
    connect(stateSensor1.port_b, intermediate_Rankine_Cycle_4_1.port_a)
      annotation (Line(points={{-40,12},{-30,12}}, color={0,127,255}));
    connect(source.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_4_1.portElec_b, sensorW.port_a)
      annotation (Line(points={{30,0},{46,0}}, color={255,0,0}));
    connect(sensorW.port_b, sinkElec.port)
      annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
    annotation (experiment(StopTime=500));
  end SteamTurbine_L4;

  model Intermediate_Rankine_Cycle_Test_e
    import NHES;

    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle
      BOP(port_a_nominal(
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
    NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
                                 nuScale_Tave_enthalpy(
      redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy
        CS(
        T_SG_exit=579.15,
        Q_nom(displayUnit="MW") = 160000000,
        demand=1.0),
      port_a_nominal(
        m_flow=70,
        p=3447380,
        T(displayUnit="degC") = 421.15),
      port_b_nominal(
        p=3447380,
        T(displayUnit="degC") = 579.25,
        h=2997670))
      annotation (Placement(transformation(extent={{-122,-40},{-54,48}})));
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
    connect(stateSensor.port_b, nuScale_Tave_enthalpy.port_a) annotation (Line(
          points={{-38,-12},{-42,-12},{-42,-1.41538},{-52.7636,-1.41538}}, color=
            {0,127,255}));
    connect(nuScale_Tave_enthalpy.port_b, stateSensor1.port_a) annotation (Line(
          points={{-52.7636,20.9231},{-42,20.9231},{-42,12},{-38,12}}, color={0,
            127,255}));
    annotation (experiment(StopTime=50000, __Dymola_Algorithm="Dassl"));
  end Intermediate_Rankine_Cycle_Test_e;

  model Intermediate_Rankine_Cycle_Test_d
    import NHES;

    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L2_ClosedFeedHeat BOP(
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_5
        CS,
      port_a_nominal(
        m_flow=67,
        p=3400000,
        h=3e6),
      port_b_nominal(p=3500000, h=1e6))
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
      offset=160e6,
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

  model Intermediate_Rankine_Cycle_Test_c
    import NHES;
    extends Modelica.Icons.Example;

    NHES.Systems.BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_Control
      BOP(port_a_nominal(
        m_flow=493.7058,
        p=14000000,
        h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
        port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
            318.95)))
      annotation (Placement(transformation(extent={{-22,-30},{38,30}})));
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
      annotation (Placement(transformation(extent={{-72,20},{-26,50}})));
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
          points={{-49,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
    connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
            {-64,-12},{-60,-12}}, color={0,127,255}));
    connect(stateSensor.port_a, BOP.port_b)
      annotation (Line(points={{-40,-12},{-22,-12}}, color={0,127,255}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-40,12},{-22,12}}, color={0,127,255}));
    connect(source.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
    connect(pulse.y, source.p_in)
      annotation (Line(points={{-99,20},{-90,20}}, color={0,0,127}));
    connect(BOP.portElec_b, sinkElec.port)
      annotation (Line(points={{38,0},{70,0}}, color={255,0,0}));
    annotation (experiment(
        StopTime=500,
        __Dymola_NumberOfIntervals=250,
        __Dymola_Algorithm="Dassl"));
  end Intermediate_Rankine_Cycle_Test_c;

  model Intermediate_Rankine_Cycle_Test_b
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC
      BOP(port_a_nominal(
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

  model Intermediate_Rankine_Cycle_Test_a
    import NHES;

    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle
      BOP(port_a_nominal(
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
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX nTU_HX(
      NTU=30,
      K_tube=17000,
      K_shell=500,
      V_Tube=10,
      V_Shell=10,
      p_start_tube=5000000,
      h_start_tube_inlet=1e6,
      h_start_tube_outlet=3e6,
      p_start_shell=5000000,
      h_start_shell_inlet=3.1e6,
      h_start_shell_outlet=1e6,
      Q_init=10e7,
      tau=1,
      m_start_tube=200,
      m_start_shell=200) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-58,0})));
    Modelica.Fluid.Sources.MassFlowSource_h source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=300,
      nPorts=1,
      h=5.3e6)
      annotation (Placement(transformation(extent={{-88,0},{-68,20}})));
    Modelica.Fluid.Sources.Boundary_ph sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      h=1e6,
      nPorts=1,
      p(displayUnit="bar") = 4500000)
      annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
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
    connect(nTU_HX.Tube_in, stateSensor.port_b) annotation (Line(points={{-54,-10},
            {-54,-12},{-38,-12}}, color={0,127,255}));
    connect(nTU_HX.Tube_out, stateSensor1.port_a)
      annotation (Line(points={{-54,10},{-54,12},{-38,12}}, color={0,127,255}));
    connect(source.ports[1], nTU_HX.Shell_in)
      annotation (Line(points={{-68,10},{-60,10}}, color={0,127,255}));
    connect(sink.ports[1], nTU_HX.Shell_out) annotation (Line(points={{-68,-12},{
            -60,-12},{-60,-10}}, color={0,127,255}));
    annotation (experiment(StopTime=500));
  end Intermediate_Rankine_Cycle_Test_a;
end ObsoleteBOPExamples;
