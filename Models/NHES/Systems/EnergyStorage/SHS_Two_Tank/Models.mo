within NHES.Systems.EnergyStorage.SHS_Two_Tank;
package Models
  model Two_Tank_SHS_System_BestModel
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_04 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
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

      input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
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
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=573.15,
      h_start_tube_inlet=data.DHX_h_start_tube_inlet,
      h_start_tube_outlet=data.DHX_h_start_tube_outlet,
      p_start_shell=data.DHX_p_start_shell,
      h_start_shell_inlet=data.DHX_h_start_shell_inlet,
      h_start_shell_outlet=data.DHX_h_start_shell_outlet,
      dp_init_tube=data.DHX_dp_init_tube,
      dp_init_shell = data.DHX_dp_init_shell,
      Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
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
    Fluid.Valves.ValveLinear Discharging_Valve(
      redeclare package Medium = Storage_Medium,
      dp_nominal=data.disvalve_dp_nominal,
      m_flow_nominal=data.disvalve_m_flow_nom)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={68,-42})));
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
      annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

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
          origin={68,-76})));
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
          origin={12,44})));
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
      annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
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
      nPorts=1) annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary4(
      redeclare package Medium = Charging_Medium,
      use_m_flow_in=false,
      use_T_in=false,
      m_flow=-m_flow_min,
      T=413.15,
      nPorts=1) annotation (Placement(transformation(extent={{-126,-44},{-106,-24}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
      annotation (Placement(transformation(extent={{-128,-98},{-108,-78}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay1(Ti=0.5)
      annotation (Placement(transformation(extent={{-102,-90},{-94,-86}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.7, uHigh=11)
      annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=11.7 - hot_tank.level)
      annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
      annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
          Steam_Output_Temp)
      annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
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
      Q_init=1)          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-44,-54})));

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
      annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
    Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
      annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{36,34},{56,54}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-86,6})));
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
            -96.4},{36,-102},{68,-102},{68,-86}},
                                         color={0,127,255}));
    connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                            color={0,127,255}));
    connect(cold_tank.port_b, charge_pump.port_a)
      annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
    connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
            {-42,-10}},
          color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
            -42,44},{-42,40.4}},                                      color={0,
            127,255}));
    connect(discharge_pump.port_b, Discharging_Valve.port_a)
      annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
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
    connect(Level_Hot_Tank1.y, delay1.u)
      annotation (Line(points={{-107,-88},{-102.8,-88}},
                                                       color={0,0,127}));
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
        points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
            74,30}},                      color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
            86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
    connect(boundary2.h_in, delay1.y)
      annotation (Line(points={{-86,-88},{-93.44,-88}}, color={0,0,127}));
    connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
            {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
    connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-46,-64},
            {-46,-70},{-58,-70},{-58,-92},{-64,-92}},color={0,127,255}));
    connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-46,-44},
            {-46,-36},{-100,-36},{-100,-34},{-106,-34}},
                                        color={0,127,255}));
    connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
            -79.6},{36,-76},{13,-76}},     color={0,127,255}));
    connect(CHX.Tube_out, sensor_T.port_a)
      annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                             color={0,127,255}));
    connect(sensor_T.port_b, resistance.port_a)
      annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
    connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
            -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
    connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
            {-76,-64},{-46,-64}}, color={0,127,255}));
    connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
        points={{-30,100},{-32,100},{-32,86},{-47,86}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
      annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
    connect(sensor_T2.port_b, DHX.Tube_out)
      annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
            -4},{-86,-30},{-78,-30}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_ch_b) annotation (Line(points={{-86,16},{
            -88,16},{-88,54},{-98,54}}, color={0,127,255}));
    connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
        points={{-30,100},{-30,124},{-47,124},{-47,106}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
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
  end Two_Tank_SHS_System_BestModel;

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

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
        package Medium =
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

  model SHS_Mikk_Two_Tank_NTUs_New_Control
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_02 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
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
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
        Medium =
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
    SupportComponent.DumpTank_Init_T hot_tank(
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

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
        package Medium =
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
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
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

  model Two_Tank_SHS_System
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_02 CS,
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
      parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.0;
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
      annotation (Placement(transformation(extent={{38,-94},{58,-74}})));
    TRANSFORM.Fluid.Pipes.TransportDelayPipe hot_tank_dump_pipe(
      redeclare package Medium = Storage_Medium,
      crossArea=data.htdp_area,
      length=data.htdp_length,
      dheight=data.htdp_d_height) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={20,-70})));
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
      nPorts=1) annotation (Placement(transformation(extent={{-98,-2},{-78,18}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=0.5*CHX.shell.mediums[
          1].h + 0.5*CHX.shell.mediums[CHXnV].h)
      annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay1(Ti=0.5)
      annotation (Placement(transformation(extent={{-62,-92},{-54,-88}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
      annotation (Placement(transformation(extent={{-66,68},{-46,88}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
      annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
          hot_tank_dump_pipe.state.T)
      annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
          Produced_steam_flow)
      annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
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
      redeclare package Medium_shell = Charging_Medium,
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
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                     color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{48,-92.4},
            {48,-96},{82,-96},{82,-76}}, color={0,127,255}));
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
    connect(hot_tank_dump_pipe.port_b, hot_tank.port_a) annotation (Line(points={
            {30,-70},{48,-70},{48,-75.6}}, color={0,127,255}));
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
    connect(Charging_Valve.port_b, CHX.port_a_tube) annotation (Line(points={{-26,-36},
            {-26,-46},{-8,-46},{-8,-50}},        color={0,127,255}));
    connect(hot_tank_dump_pipe.port_a, CHX.port_b_tube) annotation (Line(points={
            {10,-70},{8,-70},{8,-74},{2,-74},{2,-82},{-8,-82},{-8,-70}}, color={0,
            127,255}));
    connect(boundary2.ports[1], CHX.port_a_shell) annotation (Line(points={{-24,-94},
            {-12.6,-94},{-12.6,-70}},            color={0,127,255}));
    connect(boundary4.ports[1], CHX.port_b_shell) annotation (Line(points={{-78,8},
            {-68,8},{-68,-50},{-24,-50},{-24,-50},{-12.6,-50}}, color={0,127,255}));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{56,58},{56,
            38},{-6,38},{-6,16},{-2,16}}, color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{18,16},{48,16},{48,
            18},{72,18},{72,16},{92,16},{92,-62},{100,-62}}, color={0,127,255}));
    connect(port_ch_a, CHX.port_a_shell) annotation (Line(points={{-98,-62},{-74,-62},
            {-74,-64},{-44,-64},{-44,-70},{-12.6,-70}}, color={0,127,255}));
    connect(CHX.port_b_shell, port_ch_b) annotation (Line(points={{-12.6,-50},{-50,
            -50},{-50,-32},{-76,-32},{-76,54},{-98,54}}, color={0,127,255}));
    connect(boundary2.h_in, delay1.y)
      annotation (Line(points={{-46,-90},{-53.44,-90}}, color={0,0,127}));
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
  end Two_Tank_SHS_System;

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

  model Two_Tank_SHS_System_NTU_GMI
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_04 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
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
    Fluid.Valves.ValveLinear Discharging_Valve(
      redeclare package Medium = Storage_Medium,
      dp_nominal=data.disvalve_dp_nominal,
      m_flow_nominal=data.disvalve_m_flow_nom)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={68,-42})));
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
      annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

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
          origin={68,-76})));
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
          origin={12,44})));
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
      annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
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
      nPorts=1) annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary4(
      redeclare package Medium = Charging_Medium,
      use_m_flow_in=false,
      use_T_in=false,
      m_flow=-m_flow_min,
      T=473.15,
      nPorts=1) annotation (Placement(transformation(extent={{-126,24},{-106,44}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
      annotation (Placement(transformation(extent={{-128,-98},{-108,-78}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay1(Ti=0.5)
      annotation (Placement(transformation(extent={{-102,-90},{-94,-86}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
      annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
      annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
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
          origin={-44,-54})));

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
      annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
            -96.4},{36,-102},{68,-102},{68,-86}},
                                         color={0,127,255}));
    connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                            color={0,127,255}));
    connect(cold_tank.port_b, charge_pump.port_a)
      annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
    connect(DHX.Tube_out, cold_tank_dump_pipe.port_a)
      annotation (Line(points={{68,30},{68,44},{22,44}},   color={0,127,255}));
    connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
            {-42,-10}},
          color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
            -42,44},{-42,40.4}},                                      color={0,
            127,255}));
    connect(discharge_pump.port_b, Discharging_Valve.port_a)
      annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
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
    connect(Level_Hot_Tank1.y, delay1.u)
      annotation (Line(points={{-107,-88},{-102.8,-88}},
                                                       color={0,0,127}));
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
        points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
            74,30}},                      color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
            86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
    connect(boundary2.h_in, delay1.y)
      annotation (Line(points={{-86,-88},{-93.44,-88}}, color={0,0,127}));
    connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
            {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
    connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-46,-64},
            {-46,-70},{-58,-70},{-58,-92},{-64,-92}},color={0,127,255}));
    connect(CHX.Shell_in, port_ch_a) annotation (Line(points={{-46,-64},{-46,-70},
            {-82,-70},{-82,-62},{-98,-62}}, color={0,127,255}));
    connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-46,-44},
            {-46,-36},{-84,-36},{-84,34},{-106,34}},
                                        color={0,127,255}));
    connect(CHX.Shell_out, port_ch_b) annotation (Line(points={{-46,-44},{-46,-36},
            {-84,-36},{-84,54},{-98,54}},           color={0,127,255}));
    connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
            -79.6},{36,-76},{13,-76}},     color={0,127,255}));
    connect(CHX.Tube_out, sensor_T.port_a)
      annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                             color={0,127,255}));
    connect(sensor_T.port_b, resistance.port_a)
      annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
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
  end Two_Tank_SHS_System_NTU_GMI;

  model Two_Tank_SHS_System_NTU_TESUC
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Basic_TESUC CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(
        DHX_p_start_shell=1100000,
        DHX_Q_init=1e6,
        discharge_pump_dp_nominal=200000));
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

      input Modelica.Units.SI.MassFlowRate Power_Demand annotation(Dialog(tab = "General", group = "Inputs"));
      input Modelica.Units.SI.Temperature T_Steam "Used for control of power production in the case of steam cycle on the discharge side, could be replaced with gas temp if a Brayton cycle used." annotation(Dialog(tab = "General", group = "Inputs"));
    output Boolean Charging_Trigger=greaterThreshold.y;

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
          origin={76,-30})));
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
      annotation (Placement(transformation(extent={{-104,90},{-84,110}})));

    Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
      annotation (Placement(transformation(extent={{-104,104},{-84,124}})));
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
    Modelica.Blocks.Logical.GreaterThreshold
                                       greaterThreshold(     threshold=0.0)
      annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=Power_Demand)
      annotation (Placement(transformation(extent={{-132,68},{-112,88}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
      annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
    Modelica.Blocks.Sources.RealExpression Steam_Temp(y=T_Steam)
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
      annotation (Line(points={{56,-10},{76,-10},{76,-20}},
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
      annotation (Line(points={{82,-56},{82,-40},{76,-40}},
                                                   color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
      annotation (Line(
        points={{30,100},{96,100},{96,-30},{84,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
        points={{-30,100},{-76,100},{-76,128},{-83,128}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
        points={{-30,100},{-76,100},{-76,114},{-83,114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
        points={{-30,100},{-83,100}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Level_Hot_Tank1.y, delay1.u)
      annotation (Line(points={{-67,-90},{-62.8,-90}}, color={0,0,127}));
    connect(greaterThreshold.u, Level_Hot_Tank2.y)
      annotation (Line(points={{-98,78},{-111,78}}, color={0,0,127}));
    connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
        points={{-30,100},{-76,100},{-76,142},{-83,142}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, greaterThreshold.y) annotation (Line(
        points={{-30,100},{-68,100},{-68,78},{-75,78}},
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
    connect(sensorBus.Steam_Temp, Steam_Temp.y) annotation (Line(
        points={{-30,100},{-62,100},{-62,140},{-51,140}},
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
  end Two_Tank_SHS_System_NTU_TESUC;

  model Two_Tank_SHS_System_NTU_GMI_TempControl
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_04 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
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

      input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
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
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=573.15,
      h_start_tube_inlet=data.DHX_h_start_tube_inlet,
      h_start_tube_outlet=data.DHX_h_start_tube_outlet,
      p_start_shell=data.DHX_p_start_shell,
      h_start_shell_inlet=data.DHX_h_start_shell_inlet,
      h_start_shell_outlet=data.DHX_h_start_shell_outlet,
      dp_init_tube=data.DHX_dp_init_tube,
      dp_init_shell = data.DHX_dp_init_shell,
      Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
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
    Fluid.Valves.ValveLinear Discharging_Valve(
      redeclare package Medium = Storage_Medium,
      dp_nominal=data.disvalve_dp_nominal,
      m_flow_nominal=data.disvalve_m_flow_nom)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={68,-42})));
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
      annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

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
          origin={68,-76})));
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
          origin={12,44})));
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
      annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
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
      nPorts=1) annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary4(
      redeclare package Medium = Charging_Medium,
      use_m_flow_in=false,
      use_T_in=false,
      m_flow=-m_flow_min,
      T=413.15,
      nPorts=2) annotation (Placement(transformation(extent={{-126,24},{-106,44}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
      annotation (Placement(transformation(extent={{-128,-98},{-108,-78}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay1(Ti=0.5)
      annotation (Placement(transformation(extent={{-102,-90},{-94,-86}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=97)
      annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=100 - hot_tank.level)
      annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
      annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
          Steam_Output_Temp)
      annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
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
      Q_init=1)          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-44,-54})));

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
      annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
    Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    Modelica.Blocks.Sources.RealExpression Cold_Tank_Temp(y=cold_tank.T)
      annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-82,-40},{-62,-20}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{36,34},{56,54}})));
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
            -96.4},{36,-102},{68,-102},{68,-86}},
                                         color={0,127,255}));
    connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                            color={0,127,255}));
    connect(cold_tank.port_b, charge_pump.port_a)
      annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
    connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
            {-42,-10}},
          color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
            -42,44},{-42,40.4}},                                      color={0,
            127,255}));
    connect(discharge_pump.port_b, Discharging_Valve.port_a)
      annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
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
    connect(Level_Hot_Tank1.y, delay1.u)
      annotation (Line(points={{-107,-88},{-102.8,-88}},
                                                       color={0,0,127}));
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
        points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
            74,30}},                      color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
            86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
    connect(boundary2.h_in, delay1.y)
      annotation (Line(points={{-86,-88},{-93.44,-88}}, color={0,0,127}));
    connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
            {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
    connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-46,-64},
            {-46,-70},{-58,-70},{-58,-92},{-64,-92}},color={0,127,255}));
    connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-46,-44},
            {-46,-36},{-84,-36},{-84,34.5},{-106,34.5}},
                                        color={0,127,255}));
    connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
            -79.6},{36,-76},{13,-76}},     color={0,127,255}));
    connect(CHX.Tube_out, sensor_T.port_a)
      annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                             color={0,127,255}));
    connect(sensor_T.port_b, resistance.port_a)
      annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
    connect(sensorBus.Cold_Tank_Temp, Cold_Tank_Temp.y) annotation (Line(
        points={{-30,100},{-30,124},{-47,124},{-47,106}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
            -46,-34},{-56,-34},{-56,-30},{-62,-30}}, color={0,127,255}));
    connect(port_ch_b, sensor_T1.port_a) annotation (Line(points={{-98,54},{-84,
            54},{-84,32},{-86,32},{-86,-30},{-82,-30}}, color={0,127,255}));
    connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
            {-76,-64},{-46,-64}}, color={0,127,255}));
    connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
        points={{-30,100},{-32,100},{-32,86},{-47,86}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
      annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
    connect(sensor_T2.port_b, DHX.Tube_out)
      annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
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
  end Two_Tank_SHS_System_NTU_GMI_TempControl;

  model Two_Tank_SHS_System_NTU_GMI_TempControl_2
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_04 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
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

      input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
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
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=573.15,
      h_start_tube_inlet=data.DHX_h_start_tube_inlet,
      h_start_tube_outlet=data.DHX_h_start_tube_outlet,
      p_start_shell=data.DHX_p_start_shell,
      h_start_shell_inlet=data.DHX_h_start_shell_inlet,
      h_start_shell_outlet=data.DHX_h_start_shell_outlet,
      dp_init_tube=data.DHX_dp_init_tube,
      dp_init_shell = data.DHX_dp_init_shell,
      Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
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
    Fluid.Valves.ValveLinear Discharging_Valve(
      redeclare package Medium = Storage_Medium,
      dp_nominal=data.disvalve_dp_nominal,
      m_flow_nominal=data.disvalve_m_flow_nom)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={68,-42})));
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
      annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

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
          origin={68,-76})));
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
          origin={12,44})));
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
      annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
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
      annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

    Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
      annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
      annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=997)
      annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=1000 - hot_tank.level)
      annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
      annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
          Steam_Output_Temp)
      annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
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
      Q_init=1)          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-44,-54})));

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
      annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
    Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
      annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{36,34},{56,54}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-86,6})));
    Modelica.Fluid.Sources.MassFlowSource_h boundary2(
      redeclare package Medium = Charging_Medium,
      use_m_flow_in=false,
      use_h_in=true,
      m_flow=m_flow_min,
      nPorts=1) annotation (Placement(transformation(extent={{-126,-182},{-106,
              -162}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay1(Ti=0.5) annotation (Placement(transformation(extent={{-144,-170},
              {-136,-166}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
      annotation (Placement(transformation(extent={{-170,-178},{-150,-158}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary4(
      redeclare package Medium = Charging_Medium,
      use_m_flow_in=false,
      use_T_in=false,
      m_flow=-m_flow_min,
      T=413.15,
      nPorts=2) annotation (Placement(transformation(extent={{-168,-56},{-148,-36}})));
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
            -96.4},{36,-102},{68,-102},{68,-86}},
                                         color={0,127,255}));
    connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                            color={0,127,255}));
    connect(cold_tank.port_b, charge_pump.port_a)
      annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
    connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
            {-42,-10}},
          color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
            -42,44},{-42,40.4}},                                      color={0,
            127,255}));
    connect(discharge_pump.port_b, Discharging_Valve.port_a)
      annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
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
        points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
            74,30}},                      color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
            86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
    connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
            {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
    connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
            -79.6},{36,-76},{13,-76}},     color={0,127,255}));
    connect(CHX.Tube_out, sensor_T.port_a)
      annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                             color={0,127,255}));
    connect(sensor_T.port_b, resistance.port_a)
      annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
    connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
            -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
    connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
            {-76,-64},{-46,-64}}, color={0,127,255}));
    connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
        points={{-30,100},{-32,100},{-32,86},{-47,86}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
      annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
    connect(sensor_T2.port_b, DHX.Tube_out)
      annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
            -4},{-86,-30},{-78,-30}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_ch_b) annotation (Line(points={{-86,16},{
            -88,16},{-88,54},{-98,54}}, color={0,127,255}));
    connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
        points={{-30,100},{-30,124},{-47,124},{-47,106}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CHX.Shell_in,boundary2. ports[1]) annotation (Line(points={{-46,-64},
            {-46,-150},{-100,-150},{-100,-172},{-106,-172}},
                                                     color={0,127,255}));
    connect(CHX.Shell_out,boundary4. ports[1]) annotation (Line(points={{-46,-44},
            {-46,-40},{-120,-40},{-120,-45.5},{-148,-45.5}},
                                        color={0,127,255}));
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
  end Two_Tank_SHS_System_NTU_GMI_TempControl_2;

  model Two_Tank_SHS_System_NTU_GMI_TempControl_2_new_pumps
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_04 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
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

      input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
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
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=573.15,
      h_start_tube_inlet=data.DHX_h_start_tube_inlet,
      h_start_tube_outlet=data.DHX_h_start_tube_outlet,
      p_start_shell=data.DHX_p_start_shell,
      h_start_shell_inlet=data.DHX_h_start_shell_inlet,
      h_start_shell_outlet=data.DHX_h_start_shell_outlet,
      dp_init_tube=data.DHX_dp_init_tube,
      dp_init_shell = data.DHX_dp_init_shell,
      Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
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
    Fluid.Valves.ValveLinear Discharging_Valve(
      redeclare package Medium = Storage_Medium,
      dp_nominal=data.disvalve_dp_nominal,
      m_flow_nominal=data.disvalve_m_flow_nom)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={68,-42})));
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
      annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

    TRANSFORM.Fluid.Machines.Pump discharge_pump(
      redeclare package Medium = Storage_Medium,
      V=data.discharge_pump_volume,
      diameter=data.discharge_pump_diameter,
      redeclare model FlowChar =
          TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
          (V_flow_curve={0,0.5*(data.discharge_pump_m_flow_nominal/data.discharge_pump_rho_nominal),
              (data.discharge_pump_m_flow_nominal/data.discharge_pump_rho_nominal)},
            head_curve={(data.discharge_pump_dp_nominal/(9.81*data.discharge_pump_rho_nominal)),
              (data.discharge_pump_dp_nominal/(9.81*data.discharge_pump_rho_nominal))
              *0.4,0}),
      N_nominal=data.discharge_pump_rpm_nominal,
      diameter_nominal=data.discharge_pump_diameter_nominal,
      dp_nominal=data.discharge_pump_dp_nominal,
      m_flow_nominal=data.discharge_pump_m_flow_nominal,
      d_nominal=data.discharge_pump_rho_nominal,
      N_input=data.discharge_pump_constantRPM)
                    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={68,-76})));
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
          origin={12,44})));
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
      annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
    TRANSFORM.Fluid.Machines.Pump charge_pump(
      redeclare package Medium = Storage_Medium,
      V=data.charge_pump_volume,
      diameter=data.charge_pump_diamter,
      redeclare model FlowChar =
          TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
          (V_flow_curve={0,0.5*(data.charge_pump_m_flow_nominal/data.charge_pump_rho_nominal),
              (data.charge_pump_m_flow_nominal/data.charge_pump_rho_nominal)},
            head_curve={(data.charge_pump_dp_nominal/(9.81*data.charge_pump_rho_nominal)),
              (data.charge_pump_dp_nominal/(9.81*data.charge_pump_rho_nominal))*
              0.4,0}),
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
      annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

    Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
      annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
      annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=997)
      annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
    Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=1000 - hot_tank.level)
      annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
      annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
    Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
          Steam_Output_Temp)
      annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
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
      Q_init=1)          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-44,-54})));

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
      annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
    Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
      annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{36,34},{56,54}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-86,6})));
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
            -96.4},{36,-102},{68,-102},{68,-86}},
                                         color={0,127,255}));
    connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                            color={0,127,255}));
    connect(cold_tank.port_b, charge_pump.port_a)
      annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
    connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
            {-42,-10}},
          color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
            -42,44},{-42,40.4}},                                      color={0,
            127,255}));
    connect(discharge_pump.port_b, Discharging_Valve.port_a)
      annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
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
        points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
            74,30}},                      color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
            86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
    connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
            {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
    connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
            -79.6},{36,-76},{13,-76}},     color={0,127,255}));
    connect(CHX.Tube_out, sensor_T.port_a)
      annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                             color={0,127,255}));
    connect(sensor_T.port_b, resistance.port_a)
      annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
    connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
            -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
    connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
            {-76,-64},{-46,-64}}, color={0,127,255}));
    connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
        points={{-30,100},{-32,100},{-32,86},{-47,86}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
      annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
    connect(sensor_T2.port_b, DHX.Tube_out)
      annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
            -4},{-86,-30},{-78,-30}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_ch_b) annotation (Line(points={{-86,16},{
            -88,16},{-88,54},{-98,54}}, color={0,127,255}));
    connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
        points={{-30,100},{-30,124},{-47,124},{-47,106}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
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
  end Two_Tank_SHS_System_NTU_GMI_TempControl_2_new_pumps;

  model
    Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Boiler_04 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
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

      input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
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
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=573.15,
      h_start_tube_inlet=data.DHX_h_start_tube_inlet,
      h_start_tube_outlet=data.DHX_h_start_tube_outlet,
      p_start_shell=data.DHX_p_start_shell,
      h_start_shell_inlet=data.DHX_h_start_shell_inlet,
      h_start_shell_outlet=data.DHX_h_start_shell_outlet,
      dp_init_tube=data.DHX_dp_init_tube,
      dp_init_shell = data.DHX_dp_init_shell,
      Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
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
    Fluid.Valves.ValveLinear Discharging_Valve(
      redeclare package Medium = Storage_Medium,
      dp_nominal=data.disvalve_dp_nominal,
      m_flow_nominal=data.disvalve_m_flow_nom)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={68,-42})));
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
      annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

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
          origin={68,-76})));
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
          origin={12,44})));
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
      annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
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
      annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
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
      p_start_shell=14000000,
      use_T_start_shell=true,
      T_start_shell_inlet=813.15,
      T_start_shell_outlet=481.15,
      dp_init_tube=20000,
      Q_init=1,
      m_start_shell=50)  annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-44,-54})));

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
        Medium =
          Charging_Medium)                                                                           annotation (Placement(
          transformation(extent={{-108,-80},{-88,-60}}), iconTransformation(
            extent={{-108,-80},{-88,-60}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
        Medium =
          Charging_Medium)                                                                            annotation (Placement(
          transformation(extent={{-124,44},{-104,64}}),iconTransformation(extent={{-124,44},
              {-104,64}})));
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
      annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
    Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
      annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
        Medium =
          Storage_Medium)
      annotation (Placement(transformation(extent={{36,34},{56,54}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-86,6})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-176,26},{-156,46}})));
    TRANSFORM.Fluid.Valves.ValveLinear PRV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=400)                  annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={-136,36})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-60,-50})));
  equation
    connect(volume.port_a, Discharging_Valve.port_b)
      annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
    connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
            -96.4},{36,-102},{68,-102},{68,-86}},
                                         color={0,127,255}));
    connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                            color={0,127,255}));
    connect(cold_tank.port_b, charge_pump.port_a)
      annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
    connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
            {-42,-10}},
          color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
            -42,44},{-42,40.4}},                                      color={0,
            127,255}));
    connect(discharge_pump.port_b, Discharging_Valve.port_a)
      annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
      annotation (Line(
        points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
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
        points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
            74,30}},                      color={0,127,255}));
    connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
            86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
    connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
            {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
    connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
            -79.6},{36,-76},{13,-76}},     color={0,127,255}));
    connect(CHX.Tube_out, sensor_T.port_a)
      annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                             color={0,127,255}));
    connect(sensor_T.port_b, resistance.port_a)
      annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
    connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
            -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
    connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-70},{-76,-70},
            {-76,-64},{-46,-64}}, color={0,127,255}));
    connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
        points={{-30,100},{-32,100},{-32,86},{-47,86}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
      annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
    connect(sensor_T2.port_b, DHX.Tube_out)
      annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
            -4},{-86,-30},{-78,-30}}, color={0,127,255}));
    connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
        points={{-30,100},{-30,124},{-47,124},{-47,106}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.TBV,PRV. opening) annotation (Line(
        points={{30,100},{-136,100},{-136,42.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(PRV.port_a, CHX.Shell_in) annotation (Line(points={{-128,36},{-118,36},
            {-118,-12},{-142,-12},{-142,-50},{-72,-50},{-72,-64},{-46,-64}},
          color={0,127,255}));
    connect(boundary.ports[1], PRV.port_b)
      annotation (Line(points={{-156,36},{-144,36}}, color={0,127,255}));
    connect(sensorBus.Steam_Pressure,sensor_p. p) annotation (Line(
        points={{-30,100},{-30,-50},{-66,-50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensor_p.port, CHX.Shell_in) annotation (Line(points={{-60,-60},{-60,
            -64},{-46,-64}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_ch_b)
      annotation (Line(points={{-86,16},{-86,54},{-114,54}}, color={0,127,255}));
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
  end Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR;

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
end Models;
