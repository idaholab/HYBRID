within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components;
model SMR_High_fidelity
  "This model includes Hot channel calculations, pressurizer with heaters and sprays, and control bank movement based on bank overlap"
 // import TRANSFORM;

  extends SMR_Generic.BaseClasses.Partial_SubSystem_A(
    replaceable package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=system.allowFlowReversal,
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_GenericModule_NuScale data(
      Q_total=200e6,
      Q_total_el=60e6,
      T_hot=586.85,
      m_flow=637.1,
      nAssembly=37),
    port_b(redeclare package Medium = Medium),
    port_a(redeclare package Medium = Medium));

Real Tave=(Tcore_inlet.T+Tcore_exit.T)/2.0;

  Modelica.Fluid.Pipes.DynamicPipe Lower_Riser(
    crossArea=2.313,
    isCircular=true,
    diameter=1.716,
    p_a_start=dataInitial.p_start_pressurizer,
    allowFlowReversal=true,
    use_HeatTransfer=false,
    p_b_start=dataInitial.p_start_pressurizer,
    length=2.865,
    height_ab=2.865,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    T_start=data.T_hot,
    redeclare package Medium = Medium)
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,-54})));
  Modelica.Fluid.Pipes.DynamicPipe DownComer(
    allowFlowReversal=true,
    crossArea=2.388,
    isCircular=true,
    diameter=1.744,
    p_a_start=dataInitial.p_start_pressurizer,
    p_b_start=dataInitial.p_start_pressurizer,
    length=8.521,
    height_ab=-8.521,
    T_start(displayUnit="K") = data.T_cold,
    redeclare package Medium = Medium)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={22,-52})));
  Modelica.Fluid.Pipes.DynamicPipe Upper_Riser(
    crossArea=1.431,
    isCircular=true,
    diameter=1.35,
    p_a_start=dataInitial.p_start_pressurizer,
    length=7.925,
    height_ab=7.925,
    p_b_start=dataInitial.p_start_pressurizer,
    T_start=data.T_hot,
    redeclare package Medium = Medium)
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,-20})));
  inner Modelica.Fluid.System system(
      T_ambient(displayUnit="K") = 531.48,
    p_ambient(displayUnit="bar") = 12755300,
    m_flow_start=100)
    annotation (Placement(transformation(extent={{-120,120},{-100,140}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(allowFlowReversal=true,
                                                                  redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-18,-114},{-34,-98}})));
  Modelica.Fluid.Sensors.Temperature Tcore_exit(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-94,-74},{-106,-62}})));
  Modelica.Fluid.Pipes.DynamicPipe PressurizerandTopper(
    crossArea=1.431,
    isCircular=true,
    diameter=1.35,
    p_a_start=dataInitial.p_start_pressurizer,
    p_b_start=dataInitial.p_start_pressurizer,
    length=0.823,
    height_ab=0.823,
    T_start=data.T_hot,
    redeclare package Medium = Medium)
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,14})));
  Modelica.Fluid.Sensors.Temperature Tcore_inlet(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-92,-108},{-106,-120}})));
  TRANSFORM.Fluid.FittingsAndResistances.PipeLoss pipeLoss(
    allowFlowReversal=true,
    m_flow_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.PipeLossResistance.Circle
        (dimension_avg=0.4),
    K_ab=450.0,
    redeclare package Medium = Medium)
                annotation (Placement(transformation(extent={{-16,26},{4,46}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=67,
    use_input=true,
    redeclare package Medium = Medium)                   annotation (
      Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={81,-73})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
    p_a_start_shell=data.p,
    T_a_start_shell=data.T_hot,
    T_b_start_shell=data.T_cold,
    m_flow_a_start_shell=data.m_flow,
    p_a_start_tube=data.p_steam,
    use_Ts_start_tube=false,
    h_a_start_tube=data.h_steam_cold,
    h_b_start_tube=data.h_steam_hot,
    m_flow_a_start_tube=84.0,
    ps_start_shell=dataInitial.p_start_STHX_shell,
    Ts_start_shell=dataInitial.T_start_STHX_shell,
    ps_start_tube=dataInitial.p_start_STHX_tube,
    hs_start_tube=dataInitial.h_start_STHX_tube,
    Ts_wall_start=dataInitial.T_start_STHX_tubeWall,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_i_shell=data.d_steamGenerator_shell_inner,
        D_o_shell=data.d_steamGenerator_shell_outer,
        length_shell=data.length_steamGenerator,
        nTubes=data.nTubes_steamGenerator,
        nV=10,
        dimension_tube=data.d_steamGenerator_tube_inner,
        length_tube=data.length_steamGenerator_tube,
        th_wall=data.th_steamGenerator_tube,
        nR=2,
        angle_shell=-1.5707963267949),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube = Medium)                       annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={27,0})));

  Data.DataInitial_NS dataInitial(
    p_start_core_coolantSubchannel(displayUnit="Pa") = {12903247.0,12898190.0,12893307.0,
      12888614.0},
    T_start_core_coolantSubchannel(displayUnit="K") = {540.2313,558.79364,576.1813,
      586.9483},
    h_start_STHX_tube={957542.44,1226821.5,1475077.8,1743775.2,2041209.8,2374421.2,
        2749133.0,2919464.0,2980839.5,3004198.5},
    T_start_STHX_shell(displayUnit="K") = {585.6959,583.2033,576.07135,560.9657,
      554.01654,547.5736,541.4915,535.5601,527.6039,516.3904},
    Ts_start_core_fuelModel_region_1=[735.3177,865.1219,884.5617,785.37634; 705.33734,
        814.50995,833.0326,753.8575; 620.802,676.6141,692.713,665.06805],
    Ts_start_core_fuelModel_region_2=[620.8022,676.6141,692.713,665.06805; 584.4808,
        623.8399,640.4899,629.82477; 547.5703,569.67633,586.9591,594.09796],
    Ts_start_core_fuelModel_region_3=[547.5703,569.67633,586.9591,594.09796; 543.7788,
        564.05676,581.3935,590.4041; 540.2313,558.79364,576.1813,586.9483],
    T_start_STHX_tubeWall(displayUnit="K") = [511.0002,523.26855,531.58636,537.2081,
      542.85175,548.7496,555.07025,573.4225,582.2541,585.3353; 516.3904,527.6039,
      535.5601,541.4915,547.5736,554.01654,560.9657,576.07135,583.2033,585.6959],
    p_start_pressurizer(displayUnit="Pa") = 12807852,
    p_start_pressurizer_tee(displayUnit="Pa") = 12807852,
    T_start_pressurizer_tee(displayUnit="K") = 586.90674)
    annotation (Placement(transformation(extent={{80,120},{100,140}})));

  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{40,-38},{56,-52}})));
  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{34,52},{50,38}})));
  Fluid.Vessels.Pressurizer_sprays pressurizer_Update_Doster_sources(
    p_start=dataInitial.p_start_pressurizer_tee,
    alphag_start=0.45,
    allowFlowReversal=true,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    V_pressurizer=15.8,
    A_Pressurizer=15)
    "pressurizer.Medium.bubbleEnthalpy(Medium.setSat_p(pressurizer.p_start))"
    annotation (Placement(transformation(extent={{-54,66},{-30,88}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume pressurizer_tee(
    V=0.001,
    p_start=dataInitial.p_start_pressurizer_tee,
    T_start=dataInitial.T_start_pressurizer_tee,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-52,30},{-40,42}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance teeTopressurizer(R=10,
      redeclare package Medium = Medium)           annotation (Placement(
        transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={-46,51})));
  Nuclear.CoreSubchannels.Regions_3_CHF_EPRI_with_hotchannel core(
    redeclare package Material_2 = TRANSFORM.Media.Solids.Helium,
    redeclare package Material_3 = TRANSFORM.Media.Solids.ZrNb_E125,
    alpha_fuel=-3.6e-5,
    alpha_coolant=-45e-5,
    p_b_start(displayUnit="Pa"),
    Q_nominal=data.Q_total,
    SigmaF_start=26,
    T_start_1=data.T_avg + 400,
    T_start_2=data.T_avg + 130,
    T_start_3=data.T_avg + 30,
    p_a_start(displayUnit="Pa") = dataInitial.p_start_pressurizer,
    T_a_start(displayUnit="K") = data.T_cold,
    T_b_start(displayUnit="K") = data.T_hot,
    m_flow_a_start=data.m_flow,
    exposeState_a=false,
    exposeState_b=false,
    Ts_start(displayUnit="degC") = dataInitial.T_start_core_coolantSubchannel,
    ps_start=dataInitial.p_start_core_coolantSubchannel,
    Ts_start_1(displayUnit="K") = dataInitial.Ts_start_core_fuelModel_region_1,
    Ts_start_2(displayUnit="K") = dataInitial.Ts_start_core_fuelModel_region_2,
    Ts_start_3(displayUnit="K") = dataInitial.Ts_start_core_fuelModel_region_3,
    fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare record Data_DH =
        TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
    redeclare record Data_FP =
        TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
    redeclare package Material_1 = TRANSFORM.Media.Solids.UO2,
    rho_input=CR_reactivity.y,
    redeclare package Medium = Medium,
    SF_start_power={0.2,0.3,0.3,0.2},
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
    Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
        0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
        0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
        0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
        0.022746578,0.011373949},
    Fh=1.4,
    n_hot=25,
    Teffref_fuel=771.206,
    Teffref_coolant=557.95) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,-88})));

  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(
                                         allowFlowReversal=false, redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{66,-82},{48,-64}})));

  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{-54,128},{-42,142}})));
  Modelica.Blocks.Sources.RealExpression Q_total(y=core.Q_total.y)
    "total thermal power"
    annotation (Placement(transformation(extent={{-76,118},{-64,130}})));
  Modelica.Fluid.Sensors.Pressure Secondary_Side_Pressure(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{70,68},{90,88}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy Steam_exit_enthalpy(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{18,56},{36,74}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy Feed_Enthalpy(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{46,-24},{62,-8}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(
      use_port=true, Q_flow=400)
    annotation (Placement(transformation(extent={{-70,64},{-60,74}})));
  Modelica.Fluid.Sensors.Pressure Secondary_Side_Pressure1(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-84,82},{-94,92}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.995*data.P_setpoint_pressurizer,
      uHigh=1.0*data.P_setpoint_pressurizer)
    annotation (Placement(transformation(extent={{-110,64},{-102,72}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-88,64},{-80,72}})));
  Modelica.Blocks.Sources.RealExpression Heater_Off
    annotation (Placement(transformation(extent={{-110,76},{-100,84}})));
  Modelica.Blocks.Sources.RealExpression Heater_On(y=400.0e3)
    annotation (Placement(transformation(extent={{-110,52},{-100,60}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow Pressurizer_Pump_CVCS(
    m_flow_nominal=67,
    use_input=true,
    redeclare package Medium = Medium,
    allowFlowReversal=false) annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={-145,-65})));
  TRANSFORM.Controls.LimPID_Hysteresis PID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=0.1,
    k_s=0.5 + 0*1/data.P_setpoint_pressurizer,
    k_m=0.5 + 0*1/data.P_setpoint_pressurizer,
    yMax=5.66,
    yMin=0.0,
    eOn=0.0001*0.005*data.P_setpoint_pressurizer,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{-146,-16},{-136,-26}})));
  Modelica.Blocks.Sources.RealExpression Sprayer(y=1.01*data.P_setpoint_pressurizer)
    annotation (Placement(transformation(
        extent={{4.5,-5.5},{-4.5,5.5}},
        rotation=90,
        origin={-136.5,6.5})));
  Modelica.Fluid.Sensors.SpecificEnthalpy enthalpy_check(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-184,-120},{-164,-100}})));
  Modelica.Fluid.Sources.MassFlowSource_h boundary1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-8,78},{-18,88}})));
  Modelica.Fluid.Sources.Boundary_ph Core_inlet(
    redeclare package Medium = Medium,
    use_p_in=false,
    use_h_in=true,
    p=12750000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-152,-116},{-132,-96}})));
  Modelica.Blocks.Sources.RealExpression Heater_On1(y=-
        pressurizer_Update_Doster_sources.spray_port.m_flow)
    annotation (Placement(transformation(extent={{-22,60},{-12,68}})));
equation

  connect(Lower_Riser.port_b, Upper_Riser.port_a)
    annotation (Line(points={{-78,-44},{-78,-30}},
                                                 color={0,127,255}));
  connect(Upper_Riser.port_b, PressurizerandTopper.port_a)
    annotation (Line(points={{-78,-10},{-78,4}}, color={0,127,255}));
  connect(DownComer.port_b, massFlowRate.port_a)
    annotation (Line(points={{22,-62},{22,-106},{-18,-106}},
                                                         color={0,127,255}));
  connect(DownComer.port_a, STHX.port_b_shell)
    annotation (Line(points={{22,-42},{22,-12},{21.94,-12}},
                                                           color={0,127,255}));
  connect(pipeLoss.port_b, STHX.port_a_shell) annotation (Line(points={{4,36},{
          21.94,36},{21.94,12}},  color={0,127,255}));
  connect(temperature2.port, STHX.port_a_tube) annotation (Line(points={{48,-38},
          {50,-38},{50,-34},{36,-34},{36,-12},{27,-12}},
                                                     color={0,127,255}));
  connect(temperature3.port, STHX.port_b_tube)
    annotation (Line(points={{42,52},{27,52},{27,12}}, color={0,127,255}));
  connect(PressurizerandTopper.port_b, pressurizer_tee.port_1)
    annotation (Line(points={{-78,24},{-78,36},{-52,36}}, color={0,127,255}));
  connect(pressurizer_tee.port_2, pipeLoss.port_a)
    annotation (Line(points={{-40,36},{-16,36}},color={0,127,255}));
  connect(pressurizer_tee.port_3, teeTopressurizer.port_a)
    annotation (Line(points={{-46,42},{-46,46.1}},
                                                 color={0,127,255}));
  connect(core.port_b, Lower_Riser.port_a)
    annotation (Line(points={{-78,-78},{-78,-64}}, color={0,127,255}));
  connect(massFlowRate.port_b, core.port_a) annotation (Line(points={{-34,
          -106},{-78,-106},{-78,-98}},
                                color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, massFlowRate1.port_a)
    annotation (Line(points={{70,-73},{66,-73}}, color={0,127,255}));
  connect(massFlowRate1.port_b, STHX.port_a_tube)
    annotation (Line(points={{48,-73},{27,-73},{27,-12}},color={0,127,255}));

  connect(STHX.port_b_tube, port_b) annotation (Line(points={{27,12},{27,20},
          {74,20},{74,60},{104,60}},color={0,127,255}));
  connect(port_a, pump_SimpleMassFlow1.port_a) annotation (Line(points={{104,-6},
          {96,-6},{96,-73},{92,-73}},     color={0,127,255}));
  connect(sensorBus.Q_total, Q_total.y) annotation (Line(
      points={{-29.9,100.1},{-48,100.1},{-48,100},{-60,100},{-60,124},{-63.4,
          124}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.reactivity_ControlRod, CR_reactivity.u) annotation (
      Line(
      points={{30.1,100.1},{-60,100.1},{-60,135},{-55.2,135}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Tcore_inlet.port, core.port_a) annotation (Line(points={{-99,-108},
          {-78,-108},{-78,-98}},                    color={0,127,255}));
  connect(Tcore_exit.port, Lower_Riser.port_a) annotation (Line(points={{-100,
          -74},{-78,-74},{-78,-64}},
                                color={0,127,255}));
  connect(sensorBus.T_Core_Outlet, Tcore_exit.T) annotation (Line(
      points={{-29.9,100.1},{-120,100.1},{-120,-68},{-104.2,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Inlet, Tcore_inlet.T) annotation (Line(
      points={{-29.9,100.1},{-120,100.1},{-120,-114},{-103.9,-114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(STHX.port_b_tube, Secondary_Side_Pressure.port) annotation (Line(
        points={{27,12},{27,20},{74,20},{74,68},{80,68}},color={0,127,255}));
  connect(actuatorBus.mfeedpump, pump_SimpleMassFlow1.in_m_flow) annotation (
      Line(
      points={{30,100},{62,100},{62,28},{81,28},{81,-64.97}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(STHX.port_b_tube, Steam_exit_enthalpy.port)
    annotation (Line(points={{27,12},{27,56}}, color={0,127,255}));
  connect(STHX.port_a_tube, Feed_Enthalpy.port) annotation (Line(points={{27,
          -12},{40,-12},{40,-24},{54,-24}}, color={0,127,255}));
  connect(sensorBus.SG_Inlet_Enthalpy, Feed_Enthalpy.h_out) annotation (Line(
      points={{-30,100},{100,100},{100,-16},{62.8,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SG_Outlet_enthalpy, Steam_exit_enthalpy.h_out)
    annotation (Line(
      points={{-30,100},{100,100},{100,65},{36.9,65}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_exit_SG, temperature3.T) annotation (Line(
      points={{-30,100},{110,100},{110,45},{47.6,45}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.secondary_side_massflow, massFlowRate1.m_flow)
    annotation (Line(
      points={{-30,100},{100,100},{100,-56},{57,-56},{57,-63.1}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Secondary_Side_Pressure1.p, hysteresis.u) annotation (Line(points={
          {-94.5,87},{-116,87},{-116,68},{-110.8,68}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{-101.6,68},{-88.8,68}}, color={255,0,255}));
  connect(Heater_Off.y, switch1.u1) annotation (Line(points={{-99.5,80},{-96,
          80},{-96,71.2},{-88.8,71.2}}, color={0,0,127}));
  connect(Heater_On.y, switch1.u3) annotation (Line(points={{-99.5,56},{-96,
          56},{-96,64.8},{-88.8,64.8}}, color={0,0,127}));
  connect(switch1.y, boundary.Q_flow_ext) annotation (Line(points={{-79.6,68},
          {-74,68},{-74,69},{-67,69}}, color={0,0,127}));
  connect(PID.y, Pressurizer_Pump_CVCS.in_m_flow) annotation (Line(points={{-135.5,
          -21},{-128,-21},{-128,-44},{-145,-44},{-145,-56.97}},        color=
          {0,0,127}));
  connect(Sprayer.y, PID.u_m) annotation (Line(points={{-136.5,1.55},{-136.5,
          -10.225},{-141,-10.225},{-141,-15}}, color={0,0,127}));
  connect(Secondary_Side_Pressure1.p, PID.u_s) annotation (Line(points={{
          -94.5,87},{-150,87},{-150,-21},{-147,-21}}, color={0,0,127}));
  connect(boundary.port, pressurizer_Update_Doster_sources.Heaters_Port)
    annotation (Line(points={{-60,69},{-58,69},{-58,71.72},{-54,71.72}},
        color={191,0,0}));
  connect(teeTopressurizer.port_b, pressurizer_Update_Doster_sources.surge_port)
    annotation (Line(points={{-46,55.9},{-44,55.9},{-44,66},{-42,66}}, color=
          {0,127,255}));
  connect(pressurizer_Update_Doster_sources.spray_port,
    Secondary_Side_Pressure1.port) annotation (Line(points={{-54,79.2},{-88,
          79.2},{-88,82},{-89,82}}, color={0,127,255}));
  connect(Pressurizer_Pump_CVCS.port_b, pressurizer_Update_Doster_sources.spray_port)
    annotation (Line(points={{-156,-65},{-166,-65},{-166,96},{-54,96},{-54,
          79.2}}, color={0,127,255}));
  connect(Core_inlet.ports[1], Pressurizer_Pump_CVCS.port_a) annotation (Line(
        points={{-132,-106},{-126,-106},{-126,-65},{-134,-65}}, color={0,127,
          255}));
  connect(massFlowRate.port_b, enthalpy_check.port) annotation (Line(points={{-34,
          -106},{-64,-106},{-64,-130},{-174,-130},{-174,-120}},      color={0,
          127,255}));
  connect(enthalpy_check.h_out, Core_inlet.h_in)
    annotation (Line(points={{-163,-110},{-160,-110},{-160,-102},{-154,-102}},
                                                       color={0,0,127}));
  connect(Heater_On1.y, boundary1.m_flow_in) annotation (Line(points={{-11.5,
          64},{4,64},{4,87},{-8,87}}, color={0,0,127}));
  connect(boundary1.ports[1], pressurizer_Update_Doster_sources.CVCS_Outlet_Port)
    annotation (Line(points={{-18,83},{-26,83},{-26,82},{-28,82},{-28,88},{
          -33.36,88}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{100,160}}),
                         graphics={Bitmap(extent={{-114,-90},{110,90}},fileName=
             "modelica://NHES/Resources/Images/Systems/PHS/Schematic-of-a-NuScale-power-module.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{100,
            160}})),
    experiment(
      StopTime=18000,
      Interval=1,
      __Dymola_Algorithm="esdirk45a"),
    Documentation(revisions="<html>
</html>", info="<html>
<p>Based on non-proprietary opensource data. </p>
<p>Model is consistent with the model found in:</p>
<p>1. <b><span style=\"font-family: Open Sans; color: #333333; background-color: #ffffff;\">Konor Frick &amp; Shannon Bragg-Sitton&nbsp;(2021)&nbsp;Development of the NuScale Power Module in the INL Modelica Ecosystem,&nbsp;Nuclear Technology,&nbsp;207:4,&nbsp;521-542,&nbsp;DOI:&nbsp;<a href=\"https://doi.org/10.1080/00295450.2020.1781497\">10.1080/00295450.2020.1781497</a></span></b></p>
</html>"));
end SMR_High_fidelity;
