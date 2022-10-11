within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk;
model SHS_Mikk_Two_Tank_NTUs_New_Control
    extends BaseClasses.Partial_SubSystem_A(    redeclare replaceable CS_Boiler_02 CS,
    redeclare replaceable ED_Dummy ED,
    redeclare replaceable Data.Data_Dummy data);
    replaceable package Storage_Medium =
      TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66;
    parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.0;
    parameter Integer CHXnV = 5;
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
    annotation (Placement(transformation(extent={{18,34},{36,56}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1.0,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{74,36},{56,54}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
    annotation (Placement(transformation(extent={{-102,48},{-82,68}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=25)
    annotation (Placement(transformation(extent={{58,6},{38,26}})));
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
  BaseClasses.DumpTank_Init_T      hot_tank(
    redeclare package Medium = Storage_Medium,
    A=50,
    V0=1,
    p_surface=100000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    level_start=7,
    h_start=747e3,
    T_start=518.15)
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
  BaseClasses.DumpTank_Init_T      cold_tank(
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

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
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
    annotation (Placement(transformation(extent={{-52,-68},{-32,-88}})));
  Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
    annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
    annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_T_in=true,
    m_flow=m_flow_min,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-44,-102},{-24,-82}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary4(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=-m_flow_min,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-140,-42},{-120,-22}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.shell.mediums[
        CHXnV].T)
    annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay1(Ti=0.5)
    annotation (Placement(transformation(extent={{-58,-92},{-50,-88}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
    annotation (Placement(transformation(extent={{-194,-78},{-174,-58}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    amplitude=10,
    rising=600,
    falling=600,
    offset=0)
    annotation (Placement(transformation(extent={{-150,-78},{-130,-58}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
    annotation (Placement(transformation(extent={{-230,-78},{-210,-58}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
        transportDelayPipe1.state.T)
    annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=valveLinear.m_flow)
    annotation (Placement(transformation(extent={{-104,144},{-84,164}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX      CHX(
    nParallel=6,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_o_shell=0.1,
        crossAreaEmpty_shell=1,
        nV=CHXnV,
        nTubes=500,
        nR=2,
        length_shell=25,
        dimension_tube=0.04,
        length_tube=25,
        th_wall=0.003),
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    redeclare package Medium_tube = Storage_Medium,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model FlowModel_shell =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
    p_a_start_tube=1500000,
    p_b_start_tube=800000,
    exposeState_b_shell=false,
    useLumpedPressure_shell=false,
    exposeState_a_tube=false,
    exposeState_b_tube=true,
    redeclare model InternalTraceGen_tube =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration,
    redeclare model InternalHeatGen_tube =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
                       annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-8,-60})));

equation
  connect(boundary3.ports[1], boilerDrum.feedwaterPort)
    annotation (Line(points={{56,45},{36,45}},             color={0,127,255}));
  connect(pump.port_a, boilerDrum.downcomerPort) annotation (Line(points={{58,16},
          {62,16},{62,32},{33.3,32},{33.3,36.2}},                       color={0,
          127,255}));
  connect(boilerDrum.steamPort, valveLinear.port_a) annotation (Line(points={{33.3,
          53.36},{34,53.36},{34,76},{4,76}},        color={0,127,255}));
  connect(valveLinear.port_b, boundary.ports[1])
    annotation (Line(points={{-16,76},{-26,76}}, color={0,127,255}));
  connect(pump.port_b, DHX.Shell_out) annotation (Line(points={{38,16},{18,16}},
                                                              color={0,127,255}));
  connect(DHX.Shell_in, boilerDrum.riserPort) annotation (Line(points={{-2,16},
          {-6,16},{-6,30},{20.7,30},{20.7,36.2}},
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
    annotation (Line(points={{-86,-76},{-86,-78},{-52,-78}},
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
      points={{30,100},{84,100},{84,52.2},{74,52.2}},
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
      points={{-30,100},{-76,100},{-76,128},{-83,128}},
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
  connect(Level_Hot_Tank1.y, delay1.u)
    annotation (Line(points={{-67,-90},{-58.8,-90}}, color={0,0,127}));
  connect(boundary2.T_in, delay1.y)
    annotation (Line(points={{-46,-88},{-48,-88},{-48,-90},{-49.44,-90}},
                                                      color={0,0,127}));
  connect(boundary5.m_flow_in, triggeredTrapezoid.y)
    annotation (Line(points={{-106,-68},{-129,-68}}, color={0,0,127}));
  connect(hysteresis.y, triggeredTrapezoid.u)
    annotation (Line(points={{-173,-68},{-152,-68}}, color={255,0,255}));
  connect(hysteresis.u, Level_Hot_Tank2.y)
    annotation (Line(points={{-196,-68},{-209,-68}}, color={0,0,127}));
  connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,142},{-83,142}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,32},{-173,32},{-173,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,154},{-83,154}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Charging_Valve.port_b, CHX.port_a_tube) annotation (Line(points={{-26,-36},
          {-26,-46},{-8,-46},{-8,-50}},        color={0,127,255}));
  connect(transportDelayPipe1.port_a, CHX.port_b_tube) annotation (Line(points={{10,-70},
          {8,-70},{8,-74},{2,-74},{2,-82},{-8,-82},{-8,-70}},             color=
         {0,127,255}));
  connect(CHX.port_a_shell, CHX_Inlet_T.port_b) annotation (Line(points={{-12.6,
          -70},{-14,-70},{-14,-78},{-32,-78}}, color={0,127,255}));
  connect(boundary2.ports[1], CHX.port_a_shell) annotation (Line(points={{-24,-92},
          {-12.6,-92},{-12.6,-70}},            color={0,127,255}));
  connect(CHX.port_b_shell, CHX_Discharge_T.port_a) annotation (Line(points={{-12.6,
          -50},{-30,-50},{-30,-52},{-48,-52},{-48,-44},{-54,-44}},       color=
          {0,127,255}));
  connect(CHX_Discharge_T.port_b, boundary4.ports[1]) annotation (Line(points={{
          -74,-44},{-74,-32},{-120,-32}}, color={0,127,255}));
  annotation (experiment(
      StopTime=432000,
      Interval=37,
      __Dymola_Algorithm="Esdirk45a"),Icon(graphics={
        Ellipse(
          extent={{-56,70},{-6,60}},
          lineColor={175,175,175},
          lineThickness=1),
        Ellipse(
          extent={{-56,14},{-6,0}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-56,66},{-6,6}},
          lineColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=1,
          fillColor={215,215,215}),
        Ellipse(
          extent={{18,-56},{72,-68}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{18,-2},{72,-62}},
          lineColor={175,175,175},
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=1),
        Ellipse(
          extent={{18,4},{72,-8}},
          lineColor={175,175,175},
          lineThickness=1),
        Rectangle(
          extent={{68,44},{24,18}},
          lineColor={175,175,175},
          lineThickness=1,
          fillPattern=FillPattern.CrossDiag,
          fillColor={0,128,255}),
        Rectangle(
          extent={{-8,-36},{-52,-62}},
          lineColor={175,175,175},
          lineThickness=1,
          fillPattern=FillPattern.CrossDiag,
          fillColor={255,85,85}),
        Rectangle(
          extent={{-6,18},{18,12}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-41,3},{41,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-71,15},
          rotation=90),
        Rectangle(
          extent={{-30,3},{30,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-44,-23},
          rotation=180),
        Rectangle(
          extent={{-8,3},{8,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-15,-28},
          rotation=90),
        Rectangle(
          extent={{-9,3},{9,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-65,53},
          rotation=180),
        Rectangle(
          extent={{-18,-70},{10,-76}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-7,3},{7,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-15,-69},
          rotation=90),
        Rectangle(
          extent={{4,-54},{18,-60}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-11,3},{11,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={7,-65},
          rotation=90),
        Rectangle(
          extent={{-8,3},{8,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={15,20},
          rotation=90),
        Rectangle(
          extent={{-6,3},{6,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={18,29},
          rotation=180),
        Rectangle(
          extent={{32,12},{82,6}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-17,3},{17,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={79,-5},
          rotation=90),
        Rectangle(
          extent={{-5,3},{5,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={77,-19},
          rotation=180),
        Rectangle(
          extent={{-10,2},{10,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-62,-70},
          rotation=90),
        Rectangle(
          extent={{-17,2},{17,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-77,-62},
          rotation=180),
        Rectangle(
          extent={{-11,2},{11,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-53,-78},
          rotation=180),
        Rectangle(
          extent={{-9,2},{9,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={56,53},
          rotation=90),
        Rectangle(
          extent={{-6,3},{6,-3}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={35,12},
          rotation=90),
        Rectangle(
          extent={{-20,2},{20,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={74,60},
          rotation=180),
        Rectangle(
          extent={{-5,2},{5,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={91,-60},
          rotation=180),
        Rectangle(
          extent={{-45,2},{45,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={86,-17},
          rotation=90),
        Rectangle(
          extent={{-10,2},{10,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={78,26},
          rotation=180),
        Rectangle(
          extent={{-16,2},{16,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-68,-48},
          rotation=180),
        Rectangle(
          extent={{-45,2},{45,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-82,-5},
          rotation=90),
        Rectangle(
          extent={{-9,2},{9,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-44,-71},
          rotation=90),
        Rectangle(
          extent={{-7,2},{7,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-87,38},
          rotation=180),
        Rectangle(
          extent=DynamicSelect({{-56,66},{-6,6}},{{-56,66},{-6,6+60*hot_tank.level/tank_height}}),
          lineColor={175,175,175},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=1)}));
end SHS_Mikk_Two_Tank_NTUs_New_Control;
