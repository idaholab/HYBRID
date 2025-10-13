within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk;
model Two_Tank_SHS_System_NewUpdate_Bypasses
  "This version removes the minimum flow enforcer from the two tank system model."
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable Controls.CS_Experimental CS,
    redeclare replaceable Controls.ED_Dummy ED,
    redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
    replaceable package Storage_Medium =
      TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
      replaceable package Charging_Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
        group="Mediums"), choicesAllMatching=true);
      replaceable package Discharging_Medium =
      Modelica.Media.Water.StandardWater                                          constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
        group="Mediums"), choicesAllMatching=true);
    parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
    parameter Integer CHXnV = 5;
    parameter Modelica.Units.SI.Length tank_height = 15;

    input Modelica.Units.SI.MassFlowRate Produced_steam_flow annotation(Dialog(tab = "General"));
  output Boolean Charging_Trigger=booleanConstant.y;

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
    tube_av_b=false,
    shell_av_b=true,
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
    use_T_start_tube=data.DHX_use_T_start_tube,
    T_start_tube_inlet=data.DHX_T_start_tube_inlet,
    T_start_tube_outlet=data.DHX_T_start_tube_outlet,
    h_start_tube_inlet=data.DHX_h_start_tube_inlet,
    h_start_tube_outlet=data.DHX_h_start_tube_outlet,
    p_start_shell=data.DHX_p_start_shell,
    use_T_start_shell=data.DHX_use_T_start_shell,
    T_start_shell_inlet=data.DHX_T_start_shell_inlet,
    T_start_shell_outlet=data.DHX_T_start_shell_outlet,
    h_start_shell_inlet=data.DHX_h_start_shell_inlet,
    h_start_shell_outlet=data.DHX_h_start_shell_outlet,
    dp_init_tube=data.DHX_dp_init_tube,
    dp_init_shell = data.DHX_dp_init_shell,
    dp_general=data.DHX_dp_general,
    Q_init=data.DHX_Q_init,
    Cr_init=data.DHX_Cr_init,
    m_start_tube=data.DHX_m_flow_start_tube,
    m_start_shell=data.DHX_m_flow_start_shell)
                                     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={72,20})));
  TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium =
        Storage_Medium,
    p_start=data.DHX_p_start_tube,
    use_T_start=true,
    T_start=data.hot_tank_init_temp,
    h_start=data.DHX_h_start_tube_inlet,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.ctvolume_volume))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={68,-10})));
  Fluid.Valves.ValveLinear Discharging_Valve(
    redeclare package Medium = Storage_Medium,
    dp_nominal=data.disvalve_dp_nominal,
    m_flow_nominal=data.disvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={68,-58})));
  BaseClasses.DumpTank_Init_T      hot_tank(
    redeclare package Medium = Storage_Medium,
    A=data.ht_area,
    V0=data.ht_zero_level_volume,
    p_surface=data.ht_surface_pressure,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p_start=data.ht_surface_pressure,
    level_start=data.ht_init_level,
    h_start=747e3,
    T_start=data.hot_tank_init_temp)
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));

  TRANSFORM.Fluid.Machines.Pump discharge_pump(
    redeclare package Medium = Storage_Medium,
    V=data.discharge_pump_volume,
    diameter=data.discharge_pump_diameter,
    redeclare model FlowChar =
        TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
        (V_flow_curve=data.dis_pump_V_flow_nom, head_curve=data.dis_pump_head_curve),
    N_nominal=data.discharge_pump_rpm_nominal,
    diameter_nominal=data.discharge_pump_diameter_nominal,
    dp_nominal=data.discharge_pump_dp_nominal,
    m_flow_nominal=data.discharge_pump_m_flow_nominal,
    d_nominal=data.discharge_pump_rho_nominal,
    N_input=data.discharge_pump_constantRPM)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={68,-92})));
  Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
        Discharging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-104,104},{-84,124}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
    redeclare package Medium = Storage_Medium,
    crossArea=data.ctdp_area,
    length=data.ctdp_length,
    dheight=data.ctdp_d_height) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-20,46})));
  BaseClasses.DumpTank_Init_T      cold_tank(
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
    annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
  TRANSFORM.Fluid.Machines.Pump charge_pump(
    redeclare package Medium = Storage_Medium,
    V=data.charge_pump_volume,
    diameter=data.charge_pump_diamter,
    redeclare model FlowChar =
        TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
        (V_flow_curve=data.charge_pump_V_flow_nom, head_curve=data.charge_pump_head_curve),
    N_nominal=data.charge_pump_rpm_nominal,
    diameter_nominal=data.charge_pump_diameter_nominal,
    dp_nominal=data.charge_pump_dp_nominal,
    m_flow_nominal=data.charge_pump_m_flow_nominal,
    d_nominal=data.charge_pump_rho_nominal,
    N_input=data.charge_pump_constantRPM)
                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-42,8})));
  Fluid.Valves.ValveLinear Charging_Valve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=data.chvalve_dp_nominal,
    m_flow_nominal=data.chvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-42,-20})));
  Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-104,76},{-84,96}})));

  Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-94,100})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
    annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
  Modelica.Blocks.Sources.BooleanConstant
                                     booleanConstant
    annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=data.ht_level_max -
        hot_tank.level)
    annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
        sensor_T_hottank.T)
    annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
  Modelica.Blocks.Sources.RealExpression Steam_Flow_Rate(y=Produced_steam_flow)
    annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
    shell_av_b=true,
    use_derQ=true,
    tau=data.CHX_tau,
    NTU=data.CHX_NTU,
    K_tube=data.CHX_K_tube,
    K_shell=data.CHX_K_shell,
    redeclare package Tube_medium = Storage_Medium,
    redeclare package Shell_medium = Charging_Medium,
    V_Tube=data.CHX_v_tube,
    V_Shell=data.CHX_v_shell,
    p_start_tube=data.CHX_p_start_tube,
    use_T_start_tube=data.CHX_use_T_start_tube,
    T_start_tube_inlet=data.CHX_T_start_tube_inlet,
    T_start_tube_outlet=data.CHX_T_start_tube_outlet,
    h_start_tube_inlet=data.CHX_h_start_tube_inlet,
    h_start_tube_outlet=data.CHX_h_start_tube_outlet,
    p_start_shell=data.CHX_p_start_shell,
    use_T_start_shell=data.CHX_use_T_start_shell,
    T_start_shell_inlet=data.CHX_T_start_shell_inlet,
    T_start_shell_outlet=data.CHX_T_start_shell_outlet,
    h_start_shell_inlet=data.CHX_h_start_shell_inlet,
    h_start_shell_outlet=data.CHX_h_start_shell_outlet,
    dp_init_tube=data.CHX_dp_init_tube,
    dp_init_shell=data.CHX_dp_init_shell,
    dp_general=data.CHX_dp_general,
    Q_init=data.CHX_Q_init,
    Cr_init=data.CHX_Cr_init,
    m_start_tube=data.CHX_m_flow_start_tube,
    m_start_shell=data.CHX_m_flow_start_shell)
                       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-80,-40})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package Medium =
        Charging_Medium)                                                                           annotation (Placement(
        transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
          extent={{-108,-72},{-88,-52}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package Medium =
        Charging_Medium)                                                                            annotation (Placement(
        transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
            {-108,44},{-88,64}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package Medium =
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
    annotation (Placement(transformation(extent={{-82,-102},{-62,-82}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T_hottank(redeclare package
      Medium = Storage_Medium)
    annotation (Placement(transformation(extent={{20,-88},{40,-68}})));
  Modelica.Blocks.Sources.RealExpression Charging_HTF_Temp(y=CHX.Shell.medium.T)
    annotation (Placement(transformation(extent={{-104,148},{-84,168}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T_discharge(redeclare
      package Medium = Discharging_Medium) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={94,-28})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T_coldtank(redeclare
      package Medium = Storage_Medium)
    annotation (Placement(transformation(extent={{18,36},{-2,56}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Storage_Medium, V=0.1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-44,-52})));
  Fluid.Valves.ValveLinear CHX_BypassValve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=0.1*data.chvalve_dp_nominal,
    m_flow_nominal=10*data.chvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-12,-72})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(redeclare
      package Medium = Storage_Medium, V=0.1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-38,-106})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
      redeclare package Medium = Storage_Medium, R=100)
    annotation (Placement(transformation(extent={{-14,-116},{6,-96}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee2(
    redeclare package Medium = Storage_Medium,
    V=0.1,
    T_start=data.hot_tank_init_temp)          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-28})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee3(redeclare
      package Medium = Storage_Medium, V=0.1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,46})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(
      redeclare package Medium = Storage_Medium, R=100)
    annotation (Placement(transformation(extent={{70,36},{50,56}})));
  Fluid.Valves.ValveLinear DHX_BypassValve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=0.1*data.disvalve_dp_nominal,
    m_flow_nominal=10*data.disvalve_m_flow_nom) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,-6})));
  Modelica.Blocks.Logical.GreaterThreshold
                                     greaterThreshold
    annotation (Placement(transformation(extent={{-64,178},{-52,166}})));
equation
  connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{40,
          -108.4},{40,-114},{68,-114},{68,-102}},
                                       color={0,127,255}));
  connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-4},{68,10}},
                          color={0,127,255}));
  connect(cold_tank.port_b, charge_pump.port_a)
    annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
  connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
          {-42,-10}},
        color={0,127,255}));
  connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{-30,46},
          {-42,46},{-42,40.4}},                                     color={0,
          127,255}));
  connect(discharge_pump.port_b, Discharging_Valve.port_a)
    annotation (Line(points={{68,-82},{68,-68}}, color={0,127,255}));
  connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
    annotation (Line(
      points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
    annotation (Line(
      points={{30,100},{130,100},{130,-78},{86,-78},{86,-58},{76,-58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,114},{-83,114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,128},{-83,128}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
      points={{-30,100},{-83,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,86},{-83,86}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,142},{-83,142}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_Logical, booleanConstant.y) annotation (Line(
      points={{-30,100},{-30,74},{-85.4,74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Steam, Steam_Flow_Rate.y) annotation (Line(
      points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
          74,30}},                      color={0,127,255}));
  connect(CHX.Shell_in, port_ch_a) annotation (Line(points={{-82,-50},{-82,-62},
          {-98,-62}},                     color={0,127,255}));
  connect(CHX.Shell_out, port_ch_b) annotation (Line(points={{-82,-30},{-82,54},
          {-98,54}},                              color={0,127,255}));
  connect(DHX.Shell_out, sensor_T_discharge.port_a) annotation (Line(points={{
          74,10},{74,-4},{94,-4},{94,-18}}, color={0,127,255}));
  connect(sensor_T_discharge.port_b, port_dch_b)
    annotation (Line(points={{94,-38},{94,-62},{100,-62}}, color={0,127,255}));
  connect(sensorBus.Discharge_Temp, sensor_T_discharge.T) annotation (Line(
      points={{-30,100},{-30,82},{128,82},{128,-28},{97.6,-28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_T_coldtank.port_b, cold_tank_dump_pipe.port_a)
    annotation (Line(points={{-2,46},{-10,46}},color={0,127,255}));
  connect(CHX_BypassValve.port_a, tee.port_3) annotation (Line(points={{-12,-62},
          {-12,-52},{-34,-52}},               color={0,127,255}));
  connect(Charging_Valve.port_b, tee.port_2) annotation (Line(points={{-42,-30},
          {-42,-36},{-44,-36},{-44,-42}},                             color={0,127,
          255}));
  connect(tee.port_1, CHX.Tube_in) annotation (Line(points={{-44,-62},{-44,-66},
          {-66,-66},{-66,-26},{-76,-26},{-76,-30}}, color={0,127,255}));
  connect(resistance.port_a, CHX.Tube_out) annotation (Line(points={{-79,-92},{
          -86,-92},{-86,-76},{-76,-76},{-76,-50}},
                           color={0,127,255}));
  connect(sensor_T_hottank.port_b, hot_tank.port_a)
    annotation (Line(points={{40,-78},{40,-91.6}}, color={0,127,255}));
  connect(tee1.port_3, CHX_BypassValve.port_b) annotation (Line(points={{-38,-96},
          {-38,-88},{-12,-88},{-12,-82}},                color={0,127,255}));
  connect(tee1.port_2, resistance.port_b) annotation (Line(points={{-48,-106},{
          -56,-106},{-56,-92},{-65,-92}},              color={0,127,255}));
  connect(resistance1.port_b, sensor_T_hottank.port_a) annotation (Line(points={{3,-106},
          {14,-106},{14,-78},{20,-78}},                              color={0,
          127,255}));
  connect(resistance1.port_a, tee1.port_1)
    annotation (Line(points={{-11,-106},{-28,-106}},
                                                  color={0,127,255}));
  connect(actuatorBus.hot_tank_bypass_position, CHX_BypassValve.opening)
    annotation (Line(
      points={{30,100},{30,76},{26,76},{26,58},{-10,58},{-10,-60},{-14,-60},{
          -14,-58},{-30,-58},{-30,-72},{-20,-72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Discharging_Valve.port_b, tee2.port_1) annotation (Line(points={{68,
          -48},{68,-44},{40,-44},{40,-38}}, color={0,127,255}));
  connect(tee2.port_2, volume.port_a) annotation (Line(points={{40,-18},{40,-10},
          {52,-10},{52,-30},{68,-30},{68,-16}}, color={0,127,255}));
  connect(tee3.port_2, sensor_T_coldtank.port_a)
    annotation (Line(points={{30,46},{18,46}}, color={0,127,255}));
  connect(resistance2.port_b, tee3.port_1)
    annotation (Line(points={{53,46},{50,46}}, color={0,127,255}));
  connect(resistance2.port_a, DHX.Tube_out)
    annotation (Line(points={{67,46},{68,46},{68,30}}, color={0,127,255}));
  connect(tee2.port_3, DHX_BypassValve.port_a) annotation (Line(points={{30,-28},
          {22,-28},{22,-30},{16,-30},{16,-16}}, color={0,127,255}));
  connect(DHX_BypassValve.port_b, tee3.port_3) annotation (Line(points={{16,4},
          {16,16},{40,16},{40,36}}, color={0,127,255}));
  connect(actuatorBus.cold_tank_bypass_position, DHX_BypassValve.opening)
    annotation (Line(
      points={{30,100},{30,58},{26,58},{26,20},{-2,20},{-2,-6},{8,-6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.cold_tank_inlet_temp, sensor_T_coldtank.T) annotation (Line(
      points={{-30,100},{-30,72},{8,72},{8,49.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(greaterThreshold.u, Steam_Flow_Rate.y) annotation (Line(points={{
          -65.2,172},{-70,172},{-70,140},{-51,140}}, color={0,0,127}));
  connect(sensorBus.discharging_logical, greaterThreshold.y) annotation (Line(
      points={{-30,100},{-28,100},{-28,172},{-51.4,172}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_HTF_Temp, Charging_HTF_Temp.y) annotation (Line(
      points={{-30,100},{-76,100},{-76,158},{-83,158}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
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
end Two_Tank_SHS_System_NewUpdate_Bypasses;
