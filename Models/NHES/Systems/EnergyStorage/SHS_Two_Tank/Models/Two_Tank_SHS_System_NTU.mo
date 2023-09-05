within NHES.Systems.EnergyStorage.SHS_Two_Tank.Models;
model Two_Tank_SHS_System_NTU
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable ControlSystems.CS_Boiler_04 CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable Data.Data_SHS data);
    replaceable package Storage_Medium =
      TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
      replaceable package Charging_Medium =
      Modelica.Media.Water.StandardWater                                       constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
          "General",
        group="Mediums"), choicesAllMatching=true);
      replaceable package Discharging_Medium =
      Modelica.Media.Water.StandardWater                                          constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
          "General",
        group="Mediums"), choicesAllMatching=true);
    parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
    parameter Integer CHXnV = 5;
    parameter Modelica.Units.SI.Length tank_height = 15;

    input Modelica.Units.SI.MassFlowRate Produced_steam_flow annotation(Dialog(tab = "General"));
    output Boolean Charging_Trigger = hysteresis.y;

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
    tube_av_b=false,
    shell_av_b=false,
    use_derQ=data.DHX_Use_derQ,
    tau=data.DHX_tau,
    NTU=data.DHX_NTU,
    K_tube=data.DHX_K_tube,
    K_shell=data.DHX_K_shell,
    redeclare package Tube_medium = Storage_Medium,
    redeclare package Shell_medium = Discharging_Medium,
    V_Tube=data.DHX_v_tube,
    V_Shell=data.DHX_v_shell,
    p_start_tube=data.DHX_p_start_tube,
    h_start_tube_inlet=data.DHX_h_start_tube_inlet,
    h_start_tube_outlet=data.DHX_h_start_tube_outlet,
    p_start_shell=data.DHX_p_start_shell,
    h_start_shell_inlet=data.DHX_h_start_shell_inlet,
    h_start_shell_outlet=data.DHX_h_start_shell_outlet,
    dp_init_tube=data.DHX_dp_init_tube,
    dp_init_shell = data.DHX_dp_init_shell,
    Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={8,14})));
  TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium =
        Storage_Medium, redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.ctvolume_volume))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-10})));
  Fluid.Valves.ValveLinear Discharging_Valve(
    redeclare package Medium = Storage_Medium,
    dp_nominal=data.disvalve_dp_nominal,
    m_flow_nominal=data.disvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={82,-28})));
  SupportComponent.DumpTank_Init_T hot_tank(
    redeclare package Medium = Storage_Medium,
    A=data.ht_area,
    V0=data.ht_zero_level_volume,
    p_surface=data.ht_surface_pressure,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p_start=data.ht_surface_pressure,
    level_start=data.ht_init_level,
    h_start=747e3,
    T_start=data.hot_tank_init_temp)
    annotation (Placement(transformation(extent={{34,-98},{54,-78}})));

  TRANSFORM.Fluid.Machines.Pump discharge_pump(
    redeclare package Medium = Storage_Medium,
    V=data.discharge_pump_volume,
    diameter=data.discharge_pump_diameter,
    redeclare model FlowChar =
        TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
        (V_flow_curve={0,1,2}, head_curve={20,8,0}),
    N_nominal=data.discharge_pump_rpm_nominal,
    diameter_nominal=data.discharge_pump_diameter_nominal,
    dp_nominal=data.discharge_pump_dp_nominal,
    m_flow_nominal=data.discharge_pump_m_flow_nominal,
    d_nominal=data.discharge_pump_rho_nominal,
    N_input=data.discharge_pump_constantRPM)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,-66})));
  Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
        Discharging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
    redeclare package Medium = Storage_Medium,
    crossArea=data.ctdp_area,
    length=data.ctdp_length,
    dheight=data.ctdp_d_height) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-22,26})));
  SupportComponent.DumpTank_Init_T cold_tank(
    redeclare package Medium = Storage_Medium,
    A=data.cold_tank_area,
    V0=data.ct_zero_level_volume,
    p_surface=data.ct_surface_pressure,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p_start=data.ct_surface_pressure,
    level_start=data.cold_tank_init_level,
    Use_T_Start=true,
    h_start=133e3,
    T_start=data.cold_tank_init_temp)
    annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
  TRANSFORM.Fluid.Machines.Pump charge_pump(
    redeclare package Medium = Storage_Medium,
    V=data.charge_pump_volume,
    diameter=data.charge_pump_diamter,
    redeclare model FlowChar =
        TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
        (V_flow_curve={0,1,2}, head_curve={20,8,0}),
    N_nominal=data.charge_pump_rpm_nominal,
    diameter_nominal=data.charge_pump_diameter_nominal,
    dp_nominal=data.charge_pump_dp_nominal,
    m_flow_nominal=data.charge_pump_m_flow_nominal,
    d_nominal=data.charge_pump_rho_nominal,
    N_input=data.charge_pump_constantRPM)
                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-48,-2})));
  Fluid.Valves.ValveLinear Charging_Valve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=data.chvalve_dp_nominal,
    m_flow_nominal=data.chvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-26,-26})));
  Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

  Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
    annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
    annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary2(
    redeclare package Medium = Charging_Medium,
    use_m_flow_in=false,
    use_h_in=true,
    m_flow=m_flow_min,
    nPorts=1) annotation (Placement(transformation(extent={{-44,-104},{-24,-84}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary4(
    redeclare package Medium = Charging_Medium,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=-m_flow_min,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-124,-52},{-104,-32}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
    annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay1(Ti=0.5)
    annotation (Placement(transformation(extent={{-62,-92},{-54,-88}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
    annotation (Placement(transformation(extent={{-66,68},{-46,88}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
    annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
    annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
        Produced_steam_flow)
    annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
    shell_av_b=true,
    use_derQ=true,
    tau=1,
    NTU=0.9,
    K_tube=1000,
    K_shell=1000,
    redeclare package Tube_medium = Storage_Medium,
    redeclare package Shell_medium = Charging_Medium,
    V_Tube=10,
    V_Shell=25,
    Q_init=1)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-14,-60})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
      Medium =
        Charging_Medium)                                                                           annotation (Placement(
        transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
          extent={{-108,-72},{-88,-52}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
      Medium =
        Charging_Medium)                                                                            annotation (Placement(
        transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
            {-108,44},{-88,64}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
      Medium =
        Discharging_Medium)                                                                            annotation (Placement(
        transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
            48},{108,68}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
      Medium =
        Discharging_Medium)                                                                             annotation (Placement(
        transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
            {90,-72},{110,-52}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium =
        Storage_Medium, R=100)
    annotation (Placement(transformation(extent={{24,-84},{44,-64}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
      Medium =
        Storage_Medium)
    annotation (Placement(transformation(extent={{0,-88},{20,-68}})));
equation
  connect(volume.port_a, Discharging_Valve.port_b)
    annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                   color={0,127,255}));
  connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{44,-96.4},
          {44,-108},{82,-108},{82,-76}},
                                       color={0,127,255}));
  connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
          {24,10},{18,10}},
                          color={0,127,255}));
  connect(cold_tank.port_b, charge_pump.port_a)
    annotation (Line(points={{-48,19.6},{-48,8}}, color={0,127,255}));
  connect(DHX.Tube_out, cold_tank_dump_pipe.port_a)
    annotation (Line(points={{-2,10},{-22,10},{-22,16}}, color={0,127,255}));
  connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,
          -12},{-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
        color={0,127,255}));
  connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points=
         {{-22,36},{-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}}, color={0,
          127,255}));
  connect(discharge_pump.port_b, Discharging_Valve.port_a)
    annotation (Line(points={{82,-56},{82,-38}}, color={0,127,255}));
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
    annotation (Line(points={{-67,-90},{-62.8,-90}}, color={0,0,127}));
  connect(hysteresis.u, Level_Hot_Tank2.y)
    annotation (Line(points={{-68,78},{-74,78},{-74,74},{-79,74}},
                                                     color={0,0,127}));
  connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,142},{-83,142}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
      points={{-30,100},{-30,72},{-45,72},{-45,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
      points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{56,58},{56,
          38},{-6,38},{-6,16},{-2,16}}, color={0,127,255}));
  connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{18,16},{48,16},{48,
          18},{72,18},{72,16},{92,16},{92,-62},{100,-62}}, color={0,127,255}));
  connect(boundary2.h_in, delay1.y)
    annotation (Line(points={{-46,-90},{-53.44,-90}}, color={0,0,127}));
  connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-10,-50},
          {-10,-44},{-26,-44},{-26,-36}}, color={0,127,255}));
  connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-16,-70},{
          -16,-84},{-14,-84},{-14,-94},{-24,-94}}, color={0,127,255}));
  connect(CHX.Shell_in, port_ch_a) annotation (Line(points={{-16,-70},{-16,-74},
          {-82,-74},{-82,-62},{-98,-62}}, color={0,127,255}));
  connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-16,-50},
          {-52,-50},{-52,-42},{-104,-42}},
                                      color={0,127,255}));
  connect(CHX.Shell_out, port_ch_b) annotation (Line(points={{-16,-50},{-52,-50},
          {-52,-42},{-88,-42},{-88,54},{-98,54}}, color={0,127,255}));
  connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{44,-79.6},
          {58,-79.6},{58,-74},{41,-74}}, color={0,127,255}));
  connect(CHX.Tube_out, sensor_T.port_a)
    annotation (Line(points={{-10,-70},{-10,-78},{0,-78}}, color={0,127,255}));
  connect(sensor_T.port_b, resistance.port_a)
    annotation (Line(points={{20,-78},{27,-78},{27,-74}}, color={0,127,255}));
  annotation (experiment(
      StopTime=432000,
      Interval=37,
      __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
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
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
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
          extent={{-8,2},{8,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={170,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={56,52},
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
          origin={74,58},
          rotation=180),
        Rectangle(
          extent={{-5,2},{5,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={89,-62},
          rotation=180),
        Rectangle(
          extent={{-46,2},{46,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={86,-18},
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
          extent={{-52,2},{52,-2}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-82,2},
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
          origin={-87,52},
          rotation=180),
        Rectangle(
          extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
          lineColor={175,175,175},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=1),
        Rectangle(
          extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
          lineColor={175,175,175},
          fillColor={85,85,255},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=1)}));
end Two_Tank_SHS_System_NTU;
