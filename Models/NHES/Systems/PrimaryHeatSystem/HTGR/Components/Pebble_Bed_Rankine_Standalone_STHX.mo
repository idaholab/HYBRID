within NHES.Systems.PrimaryHeatSystem.HTGR.Components;
model Pebble_Bed_Rankine_Standalone_STHX
    extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Rankine_Power_Change_2 CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_HTGR_Pebble data(
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
      length_core=10,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
      sizeAssembly=17,
      nRodFuel_assembly=264,
      nAssembly=12,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1));
    Real eff;
  replaceable package Coolant_Medium =
      NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT                                  annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

  //Modelica.Units.SI.Power Q_Recup;

 /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

  Data.DataInitial_HTGR_Pebble
                      dataInitial(P_LP_Comp_Ref=4000000)
    annotation (Placement(transformation(extent={{78,120},{98,140}})));

  Compressor_Controlled            compressor_Controlled(
    redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
    explicitIsentropicEnthalpy=false,
    pstart_in=5500000,
    Tstart_in=398.15,
    Tstart_out=423.15,
    use_w0_port=true,
    PR0=1.05,
    w0nom=300)
            annotation (Placement(transformation(extent={{120,10},{140,30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      R=1000)
    annotation (Placement(transformation(extent={{114,-50},{94,-30}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={184,-16})));
  Nuclear.CoreSubchannels.Pebble_Bed_2 core(
    redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Material = Media.Solids.Graphite_5,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
    Q_fission_input(displayUnit="MW") = 100000000,
    alpha_fuel=-5e-5,
    alpha_coolant=0.0,
    p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
    Q_nominal(displayUnit="MW") = 125000000,
    SigmaF_start=26,
    p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
    T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
    T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
    m_flow_a_start=300,
    exposeState_a=false,
    exposeState_b=true,
    Ts_start(displayUnit="degC"),
    fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare record Data_DH =
        TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
    redeclare record Data_FP =
        TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
    rho_input=CR_reactivity.y,
    redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
    SF_start_power={0.3,0.25,0.25,0.2},
    nParallel=data.nAssembly,
    redeclare model Geometry =
        TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
        (
        width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
        rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
            data.r_outer_fuelRod},
        length=data.length_core,
        nPins=data.nRodFuel_assembly,
        nPins_nonFuel=data.nRodNonFuel_assembly,
        angle=1.5707963267949),
    toggle_ReactivityFP=false,
    Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
        0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
        0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
        0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
        0.022746578,0.011373949},
    Fh=1.4,
    n_hot=25,
    Teffref_fuel=1273.15,
    Teffref_coolant=923.15,
    T_inlet=723.15,
    T_outlet=1123.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={146,-40})));

  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=3000000,
    p_b_start=8000,
    T_a_start=673.15,
    T_b_start=343.15,
    m_flow_nominal=200,
    p_inlet_nominal=14000000,
    p_outlet_nominal=2500000,
    T_nominal=673.15)
    annotation (Placement(transformation(extent={{-42,-40},{-62,-60}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{-118,-60},{-138,-40}})));
  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{84,76},{96,90}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T(redeclare package Medium =
        TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={58,-40})));
  Fluid.Vessels.IdealCondenser condenser(
    p=10000,
    V_total=75,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{-106,-106},{-126,-86}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1200,
    dp_nominal=15000000,
    m_flow_nominal=50,
    d_nominal=1000,
    controlType="RPM",
    use_port=true)
    annotation (Placement(transformation(extent={{-128,38},{-108,58}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-24,-44})));
  TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                       annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={22,-76})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=3900000,
    T_start=723.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{10,-52},{30,-32}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                 STHX(
    NTU=2,
    K_tube=100,
    K_shell=1000,
    redeclare package Tube_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    V_Tube=10,
    V_Shell=10,
    V_buffers=5,
    p_start_tube=6000000,
    h_start_tube_inlet=5000e3,
    h_start_tube_outlet=3000e3,
    p_start_shell=14000000,
    h_start_shell_inlet=800e3,
    h_start_shell_outlet=3000e3,
    m_start_tube=150,
    m_start_shell=50)                                             annotation (Placement(transformation(
        extent={{12,11},{-12,-11}},
        rotation=90,
        origin={5,12})));

  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50)
    annotation (Placement(transformation(extent={{4,-80},{-16,-100}})));
  Modelica.Blocks.Sources.Constant const4(k=1.0)
    annotation (Placement(transformation(extent={{-46,-112},{-26,-92}})));
  Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
    annotation (Placement(transformation(extent={{-112,96},{-100,110}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=3000000,
    p_b_start=8000,
    T_a_start=673.15,
    T_b_start=343.15,
    m_flow_nominal=200,
    p_inlet_nominal=14000000,
    p_outlet_nominal=8000,
    T_nominal=673.15)
    annotation (Placement(transformation(extent={{-80,-40},{-100,-60}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=3900000,
    T_start=473.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5.0),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-140,14})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Modelica.Media.Water.StandardWater, V=5)
    annotation (Placement(transformation(extent={{-84,-32},{-64,-12}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=2.5)
    annotation (Placement(transformation(extent={{-102,8},{-122,-12}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-138,-36},{-118,-16}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,48})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=5500000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-142,-94},{-162,-74}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    separator(redeclare package Medium = Modelica.Media.Water.StandardWater,
      redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
    annotation (Placement(transformation(extent={{-40,10},{-60,-10}})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50)
    annotation (Placement(transformation(extent={{18,-136},{-2,-156}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=8000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-156},{-20,-136}})));
  TRANSFORM.Fluid.Sensors.Pressure     sensor_p1(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                       annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-72,-72})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-109,-71})));
  Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
    annotation (Placement(transformation(extent={{-106,110},{-94,124}})));
  Modelica.Blocks.Sources.RealExpression TBV_Flow(y=TBV.m_flow)
    annotation (Placement(transformation(extent={{-106,126},{-94,140}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=16700000,
    use_T_start=false,
    T_start=723.15,
    h_start=210e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{-28,36},{-8,56}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    crossArea=5,
    length=1) annotation (Placement(transformation(extent={{4,-36},{24,-16}})));
initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
  eff = generator.power/core.Q_total.y;
  connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{184,-26},
          {184,-40},{156,-40}}, color={0,127,255}));
  connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
    annotation (Line(points={{136,28},{184,28},{184,-6}}, color={0,127,255}));
  connect(resistance.port_a, core.port_b)
    annotation (Line(points={{111,-40},{136,-40}}, color={0,127,255}));
  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{30,83},{82.8,83}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(resistance.port_b, sensor_T.port_a)
    annotation (Line(points={{97,-40},{68,-40}}, color={0,127,255}));
  connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,-16},{58,-16},{58,-36.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
      Line(
      points={{30,100},{30,60},{130,60},{130,28.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,-16},{180.4,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(steamTurbine.portHP, sensor_T1.port_b)
    annotation (Line(points={{-42,-56},{-38,-56},{-38,-44},{-34,-44}},
                                                   color={0,127,255}));
  connect(volume.port_b, sensor_p.port) annotation (Line(points={{26,-42},{32,-42},
          {32,-46},{38,-46},{38,-84},{40,-84},{40,-86},{22,-86}}, color={0,127,255}));
  connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
      points={{-30,100},{-30,-28},{-24,-28},{-24,-40.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
      points={{30,100},{30,70},{-114,70},{-114,55},{-118,55}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-32,100},{-32,-20},{-2,-20},{-2,-42},{6,-42},{6,-76},{
          16,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_p.port, valveLinear.port_a) annotation (Line(points={{22,-86},
          {18,-86},{18,-92},{6,-92},{6,-90},{4,-90}}, color={0,127,255}));
  connect(valveLinear.port_b, sensor_T1.port_a) annotation (Line(points={{-16,-90},
          {-20,-90},{-20,-66},{-6,-66},{-6,-44},{-14,-44}},
                                               color={0,127,255}));
  connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
      points={{-30,100},{-72,100},{-72,103},{-99.4,103}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(steamTurbine1.shaft_b, generator.shaft)
    annotation (Line(points={{-100,-50},{-117.9,-50.1}}, color={0,0,0}));
  connect(volume1.port_b, pump.port_a) annotation (Line(points={{-140,20},{-140,
          50},{-128,50},{-128,48}}, color={0,127,255}));
  connect(steamTurbine1.portHP, tee.port_1) annotation (Line(points={{-80,-56},
          {-74,-56},{-74,-36},{-88,-36},{-88,-22},{-84,-22}}, color={0,127,255}));
  connect(tee.port_3, valveLinear1.port_a) annotation (Line(points={{-74,-12},{
          -74,-2},{-102,-2}}, color={0,127,255}));
  connect(valveLinear1.port_b, volume1.port_a) annotation (Line(points={{-122,
          -2},{-134,-2},{-134,8},{-140,8}}, color={0,127,255}));
  connect(sensor_T2.port_a, pump.port_b)
    annotation (Line(points={{-80,48},{-108,48}}, color={0,127,255}));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-30,60},{-72,60},{-72,51.6},{-70,51.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(condenser.port_b, pump1.port_a) annotation (Line(points={{-116,-106},{
          -124,-106},{-124,-100},{-136,-100},{-136,-84},{-142,-84}},color={0,
          127,255}));
  connect(pump1.port_b, volume1.port_a) annotation (Line(points={{-162,-84},{
          -174,-84},{-174,-28},{-140,-28},{-140,8}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, steamTurbine1.shaft_a)
    annotation (Line(points={{-62,-50},{-80,-50}}, color={0,0,0}));
  connect(actuatorBus.TCV_Position, valveLinear.opening) annotation (Line(
      points={{30,100},{30,60},{242,60},{242,-108},{-8,-108},{-8,-98},{-6,-98}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, valveLinear1.opening) annotation (
      Line(
      points={{30,100},{30,70},{-172,70},{-172,-24},{-112,-24},{-112,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(steamTurbine.portLP, separator.port_a) annotation (Line(points={{-62,
          -56},{-64,-56},{-64,-58},{-66,-58},{-66,-34},{-36,-34},{-36,0},{-44,0}},
        color={0,127,255}));
  connect(separator.port_b, tee.port_2)
    annotation (Line(points={{-56,0},{-56,-22},{-64,-22}}, color={0,127,255}));
  connect(separator.port_Liquid, volume1.port_a) annotation (Line(points={{-46,
          4},{-46,28},{-152,28},{-152,8},{-140,8}}, color={0,127,255}));
  connect(TBV.port_a, volume.port_b) annotation (Line(points={{18,-146},{68,
          -146},{68,-66},{26,-66},{26,-42}}, color={0,127,255}));
  connect(actuatorBus.TBV, TBV.opening) annotation (Line(
      points={{30,100},{242,100},{242,-154},{8,-154}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-2,-146},{-2,
          -148},{-20,-148},{-20,-146}},                 color={0,127,255}));
  connect(sensor_p1.port, steamTurbine.portLP)
    annotation (Line(points={{-72,-82},{-72,-86},{-66,-86},{-66,-56},{-62,-56}},
                                                         color={0,127,255}));
  connect(steamTurbine1.portLP, sensor_m_flow1.port_a) annotation (Line(points={
          {-100,-56},{-109,-56},{-109,-64}}, color={0,127,255}));
  connect(sensor_m_flow1.port_b, condenser.port_a)
    annotation (Line(points={{-109,-78},{-109,-86}}, color={0,127,255}));
  connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
      points={{-30,100},{-30,117},{-93.4,117}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Bypass_Flow, TBV_Flow.y) annotation (Line(
      points={{-30,100},{-32,100},{-32,133},{-93.4,133}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(volume2.port_b, STHX.Shell_in) annotation (Line(points={{-12,46},{-2,
          46},{-2,48},{2.8,48},{2.8,24}}, color={0,127,255}));
  connect(volume2.port_a, sensor_T2.port_b) annotation (Line(points={{-24,46},{
          -54,46},{-54,48},{-60,48}}, color={0,127,255}));
  connect(transportDelayPipe.port_b, volume.port_a) annotation (Line(points={{
          24,-26},{32,-26},{32,-36},{12,-36},{12,-42},{14,-42}}, color={0,127,
          255}));
  connect(transportDelayPipe.port_a, STHX.Shell_out) annotation (Line(points={{
          4,-26},{0,-26},{0,-4},{2.8,-4},{2.8,8.88178e-16}}, color={0,127,255}));
  connect(sensor_T.port_b, STHX.Tube_out) annotation (Line(points={{48,-40},{50,
          -40},{50,28},{14,28},{14,24},{9.4,24}}, color={0,127,255}));
  connect(STHX.Tube_in, compressor_Controlled.inlet) annotation (Line(points={{
          9.4,0},{9.4,-12},{84,-12},{84,30},{86,30},{86,28},{124,28}}, color={0,
          127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(__Dymola_NumberOfIntervals=113, __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
end Pebble_Bed_Rankine_Standalone_STHX;
