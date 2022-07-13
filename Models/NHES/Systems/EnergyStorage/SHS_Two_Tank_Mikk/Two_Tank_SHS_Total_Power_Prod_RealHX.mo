within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk;
model Two_Tank_SHS_Total_Power_Prod_RealHX
  "Copy of same SHS model but without the charging heat exchanger, which is now assumed to exist within a reactor model."
    extends BaseClasses.Partial_SubSystem_A(    redeclare replaceable CS_Total_Power_Prod CS,
    redeclare replaceable ED_Dummy ED,
    redeclare replaceable Data.Data_SHS data(
      hot_tank_init_temp=773.15,
      cold_tank_init_temp=598.15,            DHX_NTU=0.84));
    replaceable package Storage_Medium = NHES.Media.SolarSalt.SolarSalt
       constrainedby Modelica.Media.Interfaces.PartialMedium                                                          annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);

      replaceable package Discharging_Medium =
      Modelica.Media.Water.StandardWater                                          constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
        group="Mediums"), choicesAllMatching=true);
    parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
    parameter Integer CHXnV = 5;
    parameter Modelica.Units.SI.Length tank_height = 15;

    input Modelica.Units.SI.MassFlowRate Produced_steam_flow annotation(Dialog(tab = "General"));
    output Boolean Charging_Trigger = hysteresis.y;

  TRANSFORM.HeatExchangers.GenericDistributed_HX      DHX(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
        (
        nV=5,
        nTubes=1000,
        nR=2,
        dimension_shell=0.0508,
        length_shell=75,
        dimension_tube(displayUnit="mm") = 0.0254,
        length_tube=75),
    redeclare package Medium_shell =
        Storage_Medium,
    redeclare package Medium_tube =
        Discharging_Medium,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
    p_a_start_shell=150000,
    p_b_start_shell=100000,
    T_a_start_shell=773.15,
    T_b_start_shell=548.15,
    p_a_start_tube=4500000,
    p_b_start_tube=4000000,
    T_a_start_tube=423.15,
    T_b_start_tube=723.15)           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={84,-14})));

  TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium =
        Storage_Medium,
    T_start=773.15,     redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.ctvolume_volume))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,36})));
  Fluid.Valves.ValveLinear Discharging_Valve(
    redeclare package Medium = Storage_Medium,
    dp_nominal=data.disvalve_dp_nominal,
    m_flow_nominal=data.disvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={54,54})));
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
    annotation (Placement(transformation(extent={{-28,26},{-8,46}})));

  TRANSFORM.Fluid.Machines.Pump discharge_pump(
    redeclare package Medium = Storage_Medium,
    V=data.discharge_pump_volume,
    T_start=data.hot_tank_init_temp,
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
        origin={26,40})));
  Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
        Discharging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
    redeclare package Medium = Storage_Medium,
    crossArea=data.ctdp_area,
    length=data.ctdp_length,
    dheight=data.ctdp_d_height) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={56,-60})));
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
    annotation (Placement(transformation(extent={{22,-90},{42,-70}})));
  TRANSFORM.Fluid.Machines.Pump charge_pump(
    redeclare package Medium = Storage_Medium,
    V=data.charge_pump_volume,
    T_start=data.cold_tank_init_temp,
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
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-2,-82})));
  Fluid.Valves.ValveLinear Charging_Valve(
    redeclare package Medium = Storage_Medium,
    allowFlowReversal=true,
    dp_nominal=data.chvalve_dp_nominal,
    m_flow_nominal=data.chvalve_m_flow_nom)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-42,-64})));
  Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
    annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

  Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
    annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
    annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
    annotation (Placement(transformation(extent={{-66,68},{-46,88}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
    annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
  Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
    annotation (Placement(transformation(extent={{-104,132},{-84,152}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package Medium =
        Storage_Medium)                                                                           annotation (Placement(
        transformation(extent={{-108,42},{-88,62}}),   iconTransformation(
          extent={{-108,42},{-88,62}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package Medium =
        Storage_Medium)                                                                            annotation (Placement(
        transformation(extent={{-108,-72},{-88,-52}}),
                                                     iconTransformation(extent={{-108,
            -72},{-88,-52}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package Medium =
        Discharging_Medium)                                                                            annotation (Placement(
        transformation(extent={{88,-72},{108,-52}}),
                                                   iconTransformation(extent={{88,-72},
            {108,-52}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
      Medium =
        Discharging_Medium)                                                                             annotation (Placement(
        transformation(extent={{88,48},{108,68}}),   iconTransformation(extent={{88,48},
            {108,68}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium =
        Storage_Medium, R=100)
    annotation (Placement(transformation(extent={{-48,42},{-28,62}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Storage_Medium)
    annotation (Placement(transformation(extent={{-78,42},{-58,62}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Sources.RealExpression Discharge_Steam(y=0.0)
    annotation (Placement(transformation(extent={{-58,140},{-38,160}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume     volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=4000000,
    T_start=623.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.25))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,10})));
equation
  connect(volume.port_a, Discharging_Valve.port_b)
    annotation (Line(points={{74,36},{64,36},{64,42},{66,42},{66,48},{68,48},{
          68,54},{64,54}},                         color={0,127,255}));
  connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{-18,
          27.6},{-18,18},{24,18},{24,24},{26,24},{26,30}},
                                       color={0,127,255}));
  connect(cold_tank.port_b, charge_pump.port_a)
    annotation (Line(points={{32,-88.4},{32,-98},{-2,-98},{-2,-92}},
                                                  color={0,127,255}));
  connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-2,-72},
          {0,-72},{0,-64},{-32,-64}},
        color={0,127,255}));
  connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{46,-60},
          {32,-60},{32,-71.6}},                                     color={0,
          127,255}));
  connect(discharge_pump.port_b, Discharging_Valve.port_a)
    annotation (Line(points={{26,50},{26,54},{44,54}},
                                                 color={0,127,255}));
  connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
    annotation (Line(
      points={{30,100},{30,-46},{-42,-46},{-42,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
    annotation (Line(
      points={{30,100},{30,68},{54,68},{54,62}},
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
  connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{-18,
          44.4},{-18,52},{-31,52}},      color={0,127,255}));
  connect(sensor_T.port_b, resistance.port_a)
    annotation (Line(points={{-58,52},{-45,52}},          color={0,127,255}));
  connect(Charging_Valve.port_b, port_ch_b) annotation (Line(points={{-52,-64},
          {-84,-64},{-84,-62},{-98,-62}},
                               color={0,127,255}));
  connect(sensor_T.port_a, port_ch_a) annotation (Line(points={{-78,52},{-98,52}},
                                                                      color={0,127,
          255}));
  connect(volume.port_b, DHX.port_a_shell) annotation (Line(points={{86,36},{98,
          36},{98,24},{79.4,24},{79.4,-4}}, color={0,127,255}));
  connect(DHX.port_b_shell, cold_tank_dump_pipe.port_a) annotation (Line(points={{79.4,
          -24},{78,-24},{78,-60},{66,-60}},                         color={0,
          127,255}));
  connect(port_dch_a, DHX.port_a_tube)
    annotation (Line(points={{98,-62},{84,-62},{84,-24}}, color={0,127,255}));
  connect(sensor_T1.port_b, port_dch_b) annotation (Line(points={{120,10},{120,
          58},{98,58}},      color={0,127,255}));
  connect(sensorBus.Discharge_Temp, sensor_T1.T) annotation (Line(
      points={{-30,100},{-30,152},{-28,152},{-28,76},{110,76},{110,13.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Steam, Discharge_Steam.y) annotation (Line(
      points={{-30,100},{-54,100},{-54,136},{-34,136},{-34,144},{-32,144},{-32,150},
          {-37,150}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(DHX.port_b_tube, volume1.port_b)
    annotation (Line(points={{84,-4},{84,10}}, color={0,127,255}));
  connect(volume1.port_a, sensor_T1.port_a)
    annotation (Line(points={{96,10},{100,10}}, color={0,127,255}));
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
end Two_Tank_SHS_Total_Power_Prod_RealHX;
