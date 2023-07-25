within NHES.Systems.EnergyStorage.SHS_Two_Tank.Models;
model Two_Tank_SHS_HT_Power_ANL
  extends
    NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_SubSystem_A(
    redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_Boiler_04
      CS,
    redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.ED_Dummy ED,
    redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
        DHX_v_shell=1.0));
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
    parameter Integer CHXnV = 5;
    parameter Modelica.Units.SI.Length tank_height = 15;

    input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
    output Boolean Charging_Trigger = hysteresis.y;

  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
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
    use_T_start_tube=true,
    T_start_tube_inlet=513.15,
    T_start_tube_outlet=453.15,
    h_start_tube_inlet=data.DHX_h_start_tube_inlet,
    h_start_tube_outlet=data.DHX_h_start_tube_outlet,
    p_start_shell=data.DHX_p_start_shell,
    h_start_shell_inlet=data.DHX_h_start_shell_inlet,
    h_start_shell_outlet=data.DHX_h_start_shell_outlet,
    dp_init_tube=data.DHX_dp_init_tube,
    dp_init_shell=data.DHX_dp_init_shell,
    Q_init=data.DHX_Q_init) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={72,20})));
  TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium =
        Storage_Medium, redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.ctvolume_volume))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={68,-16})));
  NHES.Fluid.Valves.ValveLinear Discharging_Valve(
    redeclare package Medium = Storage_Medium,
    dp_nominal=data.disvalve_dp_nominal,
    m_flow_nominal=data.disvalve_m_flow_nom) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={68,-42})));
  NHES.Systems.EnergyStorage.SHS_Two_Tank.SupportComponent.DumpTank_Init_T
    hot_tank(
    redeclare package Medium = Storage_Medium,
    A=data.ht_area,
    V0=data.ht_zero_level_volume,
    p_surface=data.ht_surface_pressure,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p_start=data.ht_surface_pressure,
    level_start=data.ht_init_level,
    h_start=747e3,
    T_start=data.hot_tank_init_temp,
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{42,-98},{62,-78}})));

  Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
        Discharging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
    redeclare package Medium = Storage_Medium,
    crossArea=data.ctdp_area,
    length=data.ctdp_length,
    dheight=data.ctdp_d_height) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={34,44})));
  NHES.Systems.EnergyStorage.SHS_Two_Tank.SupportComponent.DumpTank_Init_T
    cold_tank(
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
    annotation (Placement(transformation(extent={{-10,22},{10,42}})));
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
        origin={0,8})));
  NHES.Fluid.Valves.ValveLinear Charging_Valve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=data.chvalve_dp_nominal,
    m_flow_nominal=data.chvalve_m_flow_nom) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-20})));
  Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

  Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
    annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
    annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.7, uHigh=11)
    annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=11.7 - hot_tank.level)
    annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
    annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
        Steam_Output_Temp)
    annotation (Placement(transformation(extent={{-68,112},{-48,132}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
    shell_av_b=true,
    use_derQ=true,
    tau=1,
    NTU=20,
    K_tube=1000,
    K_shell=1000,
    redeclare package Tube_medium = Storage_Medium,
    redeclare package Shell_medium = Charging_Medium,
    V_Tube=10,
    V_Shell=25,
    use_T_start_tube=true,
    T_start_tube_inlet=573.15,
    T_start_tube_outlet=573.15,
    dp_init_tube=20000,
    Q_init=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-2,-54})));

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
    annotation (Placement(transformation(extent={{28,-86},{48,-66}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
      Medium =
        Storage_Medium)
    annotation (Placement(transformation(extent={{8,-86},{28,-66}})));
  Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
    annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
  Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
    annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-88,22})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
      Medium =
        Storage_Medium)
    annotation (Placement(transformation(extent={{48,34},{68,54}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m1(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-88,42})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpy h_Inlet(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-68,-70})));
  NHES.Fluid.Valves.ValveLinear SteamValve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal(displayUnit="Pa") = 50,
    m_flow_nominal=10) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-46,-28})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           Steam_Ch_Pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-22,-28})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpy   h_Outlet(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-68,-42})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-78,6})));
  Modelica.Blocks.Sources.Constant const2(k=50)
    annotation (Placement(transformation(extent={{-82,24},{-76,30}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-72,16},{-64,24}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(use_port=
        true, Q_flow=2.6e6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-6,-94})));
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
        origin={68,-74})));
  Modelica.Blocks.Sources.RealExpression Steam_Deposit_Power(y=(h_Outlet.h_out
         - h_Inlet.h_out)*sensor_m1.m_flow)
    annotation (Placement(transformation(extent={{-68,128},{-48,148}})));
equation
  connect(volume.port_a, Discharging_Valve.port_b)
    annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
  connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                          color={0,127,255}));
  connect(cold_tank.port_b, charge_pump.port_a)
    annotation (Line(points={{0,23.6},{0,18}},    color={0,127,255}));
  connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{0,-2},{
          0,-10}},
        color={0,127,255}));
  connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{24,44},
          {0,44},{0,40.4}},                                         color={0,
          127,255}));
  connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
    annotation (Line(
      points={{30,100},{30,58},{-14,58},{-14,-20},{-8,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
    annotation (Line(
      points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
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
  connect(hysteresis.u, Level_Hot_Tank2.y)
    annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
  connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,142},{-83,142}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
      points={{-30,100},{-30,74},{-85.4,74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
      points={{-30,100},{-30,126},{-47,126},{-47,122}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
          74,30}},                      color={0,127,255}));
  connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
          86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
  connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{2,-44},{
          2,-38},{0,-38},{0,-30}},        color={0,127,255}));
  connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{52,-79.6},
          {52,-76},{45,-76}},            color={0,127,255}));
  connect(CHX.Tube_out, sensor_T.port_a)
    annotation (Line(points={{2,-64},{2,-76},{8,-76}},     color={0,127,255}));
  connect(sensor_T.port_b, resistance.port_a)
    annotation (Line(points={{28,-76},{31,-76}},          color={0,127,255}));
  connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-92,-62},
          {-92,-80},{-4,-80},{-4,-64}},
                                color={0,127,255}));
  connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
      points={{-30,100},{-32,100},{-32,86},{-47,86}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
    annotation (Line(points={{44,44},{48,44}}, color={0,127,255}));
  connect(sensor_T2.port_b, DHX.Tube_out)
    annotation (Line(points={{68,44},{68,30}},         color={0,127,255}));
  connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-4,100},{-4,66},{58,66},{58,47.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensor_m1.port_a, sensor_T1.port_a)
    annotation (Line(points={{-88,32},{-88,32}}, color={0,127,255}));
  connect(sensor_m1.port_b, port_ch_b)
    annotation (Line(points={{-88,52},{-88,54},{-98,54}}, color={0,127,255}));
  connect(sensorBus.ChargeSteam_mFlow, sensor_m1.m_flow) annotation (Line(
      points={{-30,100},{-30,62},{-74,62},{-74,42},{-84.4,42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
      points={{-30,100},{-30,106},{-47,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(h_Inlet.port, CHX.Shell_in)
    annotation (Line(points={{-68,-80},{-4,-80},{-4,-64}}, color={0,127,255}));
  connect(Steam_Ch_Pump.port_b, SteamValve.port_a)
    annotation (Line(points={{-32,-28},{-36,-28}}, color={0,127,255}));
  connect(CHX.Shell_out, Steam_Ch_Pump.port_a) annotation (Line(points={{-4,-44},
          {-4,-34},{-8,-34},{-8,-28},{-12,-28}}, color={0,127,255}));
  connect(sensor_T1.port_b, sensor_p1.port)
    annotation (Line(points={{-88,12},{-88,6}}, color={0,127,255}));
  connect(SteamValve.port_b, sensor_p1.port)
    annotation (Line(points={{-56,-28},{-88,-28},{-88,6}}, color={0,127,255}));
  connect(h_Outlet.port, SteamValve.port_b) annotation (Line(points={{-68,-32},{
          -68,-28},{-56,-28}}, color={0,127,255}));
  connect(const2.y, add.u1) annotation (Line(points={{-75.7,27},{-75.7,26},{-74,
          26},{-74,22.4},{-72.8,22.4}}, color={0,0,127}));
  connect(sensor_p1.p, add.u2) annotation (Line(points={{-78,12},{-78,18},{-72.8,
          18},{-72.8,17.6}}, color={0,0,127}));
  connect(add.y, Steam_Ch_Pump.in_p) annotation (Line(points={{-63.6,20},{-22,20},
          {-22,-20.7}}, color={0,0,127}));
  connect(sensorBus.Outlet_Enthalpy, h_Outlet.h_out) annotation (Line(
      points={{-30,100},{-30,58},{-52,58},{-52,16},{-60,16},{-60,-42},{-62,-42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(sensorBus.Inlet_Enthalpy, h_Inlet.h_out) annotation (Line(
      points={{-30,100},{-30,58},{-52,58},{-52,16},{-60,16},{-60,-70},{-62,-70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(actuatorBus.InletValveOpening, SteamValve.opening) annotation (Line(
      points={{30,100},{30,60},{-46,60},{-46,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Hot_Tank_Entrance_Temp, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,56},{18,56},{18,-72.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundary.port, hot_tank.heatPort) annotation (Line(points={{4,-94},
          {38,-94},{38,-100},{62,-100},{62,-94},{60.4,-94},{60.4,-88}},
                                                  color={191,0,0}));
  connect(actuatorBus.Hot_Tank_Heating_Power, boundary.Q_flow_ext) annotation (
      Line(
      points={{30,100},{30,-2},{14,-2},{14,-36},{-8,-36},{-8,-40},{-16,-40},{-16,
          -82},{-20,-82},{-20,-94},{-10,-94}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Discharging_Valve.port_a, discharge_pump.port_b)
    annotation (Line(points={{68,-52},{68,-64}}, color={0,127,255}));
  connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{52,
          -96.4},{52,-98},{72,-98},{72,-92},{68,-92},{68,-84}},
                                         color={0,127,255}));
  connect(sensorBus.Steam_Deposit_Power, Steam_Deposit_Power.y) annotation (
     Line(
      points={{-30,100},{-30,138},{-47,138}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(
      StopTime=432000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"), Icon(coordinateSystem(extent={{-100,
            -100},{100,140}}),              graphics={
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
          lineThickness=1)}),
    Diagram(coordinateSystem(extent={{-100,-100},{100,140}})));
end Two_Tank_SHS_HT_Power_ANL;
