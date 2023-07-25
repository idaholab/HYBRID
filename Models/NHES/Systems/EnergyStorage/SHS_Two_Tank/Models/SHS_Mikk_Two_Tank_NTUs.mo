within NHES.Systems.EnergyStorage.SHS_Two_Tank.Models;
model SHS_Mikk_Two_Tank_NTUs
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable ControlSystems.CS_Boiler CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable Data.Data_Dummy data);
    replaceable package Storage_Medium =
      TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66;
    parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.0;
  TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        length=20,
        r_inner=3,
        th_wall=0.03),
    level_start=11.0,
    p_liquid_start=500000,
    p_vapor_start=500000,
    use_LiquidHeatPort=false,
    Twall_start=343.15)
    annotation (Placement(transformation(extent={{20,34},{38,56}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1.0,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{74,34},{54,54}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
    annotation (Placement(transformation(extent={{-102,48},{-82,68}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=25)
    annotation (Placement(transformation(extent={{60,6},{40,26}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-46,66},{-26,86}})));
  Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
    annotation (Placement(transformation(extent={{-102,62},{-82,82}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{4,66},{-16,86}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
    tube_av_b=false,
    shell_av_b=false,
    NTU=4,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Storage_Medium,
    redeclare package Shell_medium = Modelica.Media.Examples.TwoPhaseWater,
    V_Tube=10,
    V_Shell=25,
    p_start_tube=100000,
    h_start_tube_inlet=100e3,
    h_start_tube_outlet=300e3,
    p_start_shell=500000,
    h_start_shell_inlet=1400e3,
    h_start_shell_outlet=2000e3,
    dp_init_tube=1000,
    Q_init=1)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={8,14})));
  TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium =
        Storage_Medium, redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1.0))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-10})));
  Fluid.Valves.ValveLinear Discharging_Valve(
    redeclare package Medium = Storage_Medium,
    dp_nominal=100000,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={82,-28})));
  SupportComponent.DumpTank_Init_T hot_tank(
    redeclare package Medium = Storage_Medium,
    A=50,
    V0=1,
    p_surface=100000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    level_start=7,
    h_start=747e3,
    T_start=553.15)
    annotation (Placement(transformation(extent={{38,-94},{58,-74}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe1(
    redeclare package Medium = Storage_Medium,
    crossArea=1,
    length=10,
    dheight=0)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={20,-70})));
  TRANSFORM.Fluid.Machines.Pump      pump1(
    redeclare package Medium = Storage_Medium,
    V=1,
    diameter=0.5,
    redeclare model FlowChar =
        TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
        (V_flow_curve={0,1,2}, head_curve={20,8,0}),
    diameter_nominal=0.5,
    dp_nominal=200000,
    m_flow_nominal=10,
    d_nominal=1000,
    N_input=1500)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,-66})));
  Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
        Discharging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe2(
    redeclare package Medium = Storage_Medium,
    crossArea=1,
    length=10,
    dheight=0.0)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-22,26})));
  SupportComponent.DumpTank_Init_T cold_tank(
    redeclare package Medium = Storage_Medium,
    A=50,
    V0=1,
    p_surface=100000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p_start=100000,
    level_start=7,
    Use_T_Start=true,
    h_start=133e3,
    T_start=433.15)
    annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
  TRANSFORM.Fluid.Machines.Pump      pump2(
    redeclare package Medium = Storage_Medium,
    V=1,
    diameter=0.5,
    redeclare model FlowChar =
        TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
        (V_flow_curve={0,1,2}, head_curve={20,8,0}),
    diameter_nominal=0.5,
    dp_nominal=700000,
    m_flow_nominal=20,
    d_nominal=1000,
    N_input=2000)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-48,-2})));
  Fluid.Valves.ValveLinear Charging_Valve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=100000,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-26,-26})));
  Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,76},{-82,96}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
    use_derQ=false,
    tau=5,
    NTU=2.0,
    K_tube=100,
    K_shell=100,                                           redeclare package
              Tube_medium =
        Storage_Medium,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=10,
    V_Shell=0.001,
    Q_init=1)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-18,-58})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
              Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-54,-54},{-74,-34}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5000000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-108,-54},{-88,-34}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary5(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=8,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-106,-86},{-86,-66}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-48,-68},{-28,-88}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid2(
    amplitude=10,
    rising=500,
    width=8500,
    falling=500,
    period=18000,
    offset=0.0,
    startTime=9000)
    annotation (Placement(transformation(extent={{-180,-64},{-168,-52}})));
  Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
    annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
    annotation (Placement(transformation(extent={{-102,118},{-82,138}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_T_in=true,
    m_flow=m_flow_min,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary4(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=-m_flow_min,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-82,-44},{-62,-24}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.T)
    annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay1(Ti=0.5)
    annotation (Placement(transformation(extent={{-58,-92},{-50,-88}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
        transportDelayPipe1.state.T)
    annotation (Placement(transformation(extent={{-100,134},{-80,154}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=valveLinear.m_flow)
    annotation (Placement(transformation(extent={{-100,146},{-80,166}})));
equation
  connect(boundary3.ports[1], boilerDrum.feedwaterPort)
    annotation (Line(points={{54,44},{38,45}},             color={0,127,255}));
  connect(pump.port_a, boilerDrum.downcomerPort) annotation (Line(points={{60,16},
          {64,16},{64,32},{35.3,32},{35.3,36.2}},                       color={0,
          127,255}));
  connect(boilerDrum.steamPort, valveLinear.port_a) annotation (Line(points={{35.3,
          53.36},{34,53.36},{34,76},{4,76}},        color={0,127,255}));
  connect(valveLinear.port_b, boundary.ports[1])
    annotation (Line(points={{-16,76},{-26,76}}, color={0,127,255}));
  connect(pump.port_b, DHX.Shell_out) annotation (Line(points={{40,16},{18,16}},
                                                              color={0,127,255}));
  connect(DHX.Shell_in, boilerDrum.riserPort) annotation (Line(points={{-2,16},
          {-6,16},{-6,30},{22.7,30},{22.7,36.2}},
                                                color={0,127,255}));
  connect(volume.port_a, Discharging_Valve.port_b)
    annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                   color={0,127,255}));
  connect(hot_tank.port_b, pump1.port_a) annotation (Line(points={{48,-92.4},{
          48,-96},{82,-96},{82,-76}},
                             color={0,127,255}));
  connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
          {24,10},{18,10}},
                          color={0,127,255}));
  connect(cold_tank.port_b,pump2. port_a) annotation (Line(points={{-48,19.6},{
          -48,8}},                    color={0,127,255}));
  connect(DHX.Tube_out, transportDelayPipe2.port_a) annotation (Line(points={{-2,10},
          {-22,10},{-22,16}},                                            color=
          {0,127,255}));
  connect(boundary1.ports[1],CHX_Discharge_T. port_b)
    annotation (Line(points={{-88,-44},{-74,-44}},
                                                 color={0,127,255}));
  connect(boundary5.ports[1],CHX_Inlet_T. port_a)
    annotation (Line(points={{-86,-76},{-86,-78},{-48,-78}},
                                                 color={0,127,255}));
  connect(pump2.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,-12},
          {-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
                                                color={0,127,255}));
  connect(transportDelayPipe2.port_b, cold_tank.port_a) annotation (Line(points={{-22,36},
          {-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}},
                    color={0,127,255}));
  connect(transportDelayPipe1.port_b, hot_tank.port_a) annotation (Line(points={{30,-70},
          {48,-70},{48,-75.6}},
                  color={0,127,255}));
  connect(pump1.port_b, Discharging_Valve.port_a) annotation (Line(points={{82,-56},
          {82,-38}},                        color={0,127,255}));
  connect(actuatorBus.Boiler_Steam_Valve, valveLinear.opening) annotation (Line(
      points={{30,100},{30,90},{-6,90},{-6,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Boiler_Drum_Pressure, Boiler_Pressure.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,72},{-81,72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Boiler_Level, Level_Boiler.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,58},{-81,58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Boiler_Feed_Flow, boundary3.m_flow_in) annotation (Line(
      points={{30,100},{84,100},{84,52},{74,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
    annotation (Line(
      points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
    annotation (Line(
      points={{30,100},{96,100},{96,-28},{90,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,114},{-81,114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,128},{-81,128}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
      points={{-30,100},{-81,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,86},{-81,86}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-14,-48},
          {-14,-40},{-26,-40},{-26,-36}}, color={0,127,255}));
  connect(CHX.Tube_out, transportDelayPipe1.port_a) annotation (Line(points={{-14,
          -68},{-14,-70},{10,-70}}, color={0,127,255}));
  connect(CHX_Inlet_T.port_b, CHX.Shell_in) annotation (Line(points={{-28,-78},
          {-20,-78},{-20,-68}}, color={0,127,255}));
  connect(CHX.Shell_out, CHX_Discharge_T.port_a) annotation (Line(points={{-20,
          -48},{-20,-44},{-54,-44}}, color={0,127,255}));
  connect(boundary2.ports[1], CHX.Shell_in) annotation (Line(points={{-14,-94},{
          -10,-94},{-10,-92},{-4,-92},{-4,-84},{-20,-84},{-20,-68}}, color={0,127,
          255}));
  connect(boundary4.ports[1], CHX.Shell_out) annotation (Line(points={{-62,-34},
          {-42,-34},{-42,-44},{-20,-44},{-20,-48}},
                      color={0,127,255}));
  connect(boundary5.m_flow_in, trapezoid2.y)
    annotation (Line(points={{-106,-68},{-106,-58},{-167.4,-58}},
                                                      color={0,0,127}));
  connect(Level_Hot_Tank1.y, delay1.u)
    annotation (Line(points={{-67,-90},{-58.8,-90}}, color={0,0,127}));
  connect(boundary2.T_in, delay1.y)
    annotation (Line(points={{-36,-90},{-49.44,-90}}, color={0,0,127}));
  connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,156},{-79,156}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
      points={{-30,100},{-54,100},{-54,98},{-76,98},{-76,144},{-79,144}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (experiment(
      StopTime=800000,
      Interval=30,
      __Dymola_Algorithm="Esdirk45a"));
end SHS_Mikk_Two_Tank_NTUs;
