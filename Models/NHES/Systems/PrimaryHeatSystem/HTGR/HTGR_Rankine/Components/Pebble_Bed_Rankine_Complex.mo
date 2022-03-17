within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components;
model Pebble_Bed_Rankine_Complex
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Rankine_DNE CS,
    redeclare replaceable HTGR_Rankine.ED_Dummy ED,
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
       Modelica.Media.IdealGases.SingleGases.He  constrainedby Modelica.Media.Interfaces.PartialMedium                     annotation(choicesAllMatching = true,dialog(group="Media"));
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

  Brayton_Systems.Compressor_Controlled compressor_Controlled(
    redeclare package Medium = Coolant_Medium,
    explicitIsentropicEnthalpy=false,
    pstart_in=5500000,
    Tstart_in=398.15,
    Tstart_out=423.15,
    use_w0_port=true,
    PR0=1.05,
    w0nom=300)
    annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Coolant_Medium,
      R=1000)
    annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-80,-40})));
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
    exposeState_b=false,
    Ts_start(displayUnit="degC"),
    fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare record Data_DH =
        TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
    redeclare record Data_FP =
        TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
    rho_input=CR_reactivity.y,
    redeclare package Medium = Coolant_Medium,
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
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-82,2})));

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
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
    annotation (Placement(transformation(extent={{38,26},{58,46}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{64,-28},{44,-8}})));
  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{68,94},{80,108}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-5,-7},{5,7}},
        rotation=270,
        origin={-43,27})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=75,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1200,
    dp_nominal=15000000,
    m_flow_nominal=50,
    d_nominal=1000,
    controlType="RPM",
    use_port=true)
    annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={20,30})));
  TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                       annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-18,54})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=3900000,
    T_start=723.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,30})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    redeclare model FlowModel_shell =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
    p_b_start_shell=14300000,
    p_b_start_tube=3900000,
    T_a_start_tube=373.15,
    T_b_start_tube=773.15,
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
    p_a_start_shell=14400000,
    T_a_start_shell=1023.15,
    T_b_start_shell=723.15,
    m_flow_a_start_shell=300,
    p_a_start_tube=4000000,
    use_Ts_start_tube=true,
    m_flow_a_start_tube=50,
    redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_i_shell(displayUnit="m") = 0.011,
        D_o_shell=0.022,
        crossAreaEmpty_shell=500*0.05,
        length_shell=75,
        nTubes=1500,
        nV=6,
        dimension_tube(displayUnit="mm") = 0.0254,
        length_tube=75,
        th_wall=0.003,
        nR=3),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare package Medium_shell =
        Coolant_Medium)
    annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={-37,-2})));

  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={0,30})));
  Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
    annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
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
    T_nominal=673.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={74,4})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=3900000,
    T_start=473.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5.0),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,-60})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Modelica.Media.Water.StandardWater, V=5)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,28})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=2.5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,2})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,-60})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=5500000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
    annotation (Placement(transformation(extent={{58,32},{78,52}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{8,-6},{-8,6}},
        rotation=90,
        origin={80,-18})));
  Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
    annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-46,72})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-82,62},{-62,82}})));
initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
  eff = generator.power/core.Q_total.y;
  connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
          {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                color={0,127,255},
      thickness=0.5));
  connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
    annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                          color={0,127,255},
      thickness=0.5));
  connect(resistance.port_a, core.port_b)
    annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                   color={0,127,255},
      thickness=0.5));
  connect(resistance.port_b, sensor_T.port_a)
    annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                 color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
      Line(
      points={{30,100},{30,92},{-100,92},{-100,-22},{-58,-22},{-58,-41.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,92},{-100,92},{-100,-43.6},{-80,-43.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
      points={{38,42},{32,42},{32,30},{26,30}},
      color={0,127,255},
      thickness=0.5));
  connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
          {-18,44}},                                              color={0,127,255}));
  connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
          30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
      thickness=0.5));
  connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
        points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                          color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
      points={{-30,100},{20,100},{20,32.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
      points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-30,54},{-24,54}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
      points={{8,30},{14,30}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
      points={{-30,100},{-55.4,99}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(LPT.shaft_b, generator.shaft) annotation (Line(
      points={{74,-6},{74,-18.1},{64.1,-18.1}},
      color={0,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                    color={0,127,255},
      thickness=0.5));
  connect(LPT.portHP, tee.port_1) annotation (Line(
      points={{80,14},{80,16},{80,16},{80,18}},
      color={0,127,255},
      thickness=0.5));
  connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
      points={{90,28},{100,28},{100,12}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
      points={{100,-8},{100,-72},{36,-72},{36,-60},{28,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(STHX.port_a_tube, sensor_T2.port_b)
    annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                      color={0,127,255},
      thickness=0.5));
  connect(sensor_T2.port_a, pump.port_b)
    annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-30,92},{-100,92},{-100,-76},{-28,-76},{-28,-63.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
          -60},{60,-60}},                                           color={0,127,
          255},
      thickness=0.5));
  connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
          -60}},                                     color={0,127,255},
      thickness=0.5));
  connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
      points={{58,36},{74,36},{74,14}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
      points={{30,100},{30,92},{0,92},{0,36.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
      Line(
      points={{30,100},{30,88},{116,88},{116,2},{108,2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
      points={{58,42},{62,42}},
      color={0,127,255},
      thickness=0.5));
  connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
      points={{74,42},{80,42},{80,38}},
      color={0,127,255},
      thickness=0.5));
  connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
      points={{64,38},{64,8},{28,8},{28,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
      points={{80,-6},{80,-8},{80,-8},{80,-10}},
      color={0,127,255},
      thickness=0.5));
  connect(sensor_m_flow1.port_b,Condenser. port_a)
    annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                     color={0,127,255},
      thickness=0.5));
  connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
      points={{-30,100},{-30,111},{-79.4,111}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
          {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
      thickness=0.5));
  connect(TCV.port_a, volume.port_b) annotation (Line(
      points={{-8,30},{-14,30}},
      color={0,127,255},
      thickness=0.5));

  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{30,101},{66.8,101}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, TBV.opening) annotation (Line(
      points={{30,100},{30,92},{-46,92},{-46,78.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,46},
          {-26,46},{-26,72},{-38,72}}, color={0,127,255}));
  connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-54,72},{-62,
          72}},                                      color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=30,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
end Pebble_Bed_Rankine_Complex;
