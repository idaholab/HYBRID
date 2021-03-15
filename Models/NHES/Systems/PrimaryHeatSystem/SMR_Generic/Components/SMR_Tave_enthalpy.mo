within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components;
model SMR_Tave_enthalpy

  extends BaseClasses.Partial_SubSystem_A(
    replaceable package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=system.allowFlowReversal,
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_GenericModule_SMR data,
    port_b(redeclare package Medium = Modelica.Media.Water.StandardWater),
    port_a(redeclare package Medium = Modelica.Media.Water.StandardWater));

Real Tave=(Tcore_inlet.T+Tcore_exit.T)/2.0;

  Modelica.Fluid.Pipes.DynamicPipe Lower_Riser(
    crossArea=2.313,
    isCircular=true,
    diameter=1.716,
    p_a_start=system.p_ambient,
    allowFlowReversal=true,
    use_HeatTransfer=false,
    p_b_start=system.p_ambient,
    length=2.865,
    height_ab=2.865,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T_start=data.T_hot)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,-54})));
  Modelica.Fluid.Pipes.DynamicPipe DownComer(
    crossArea=2.388,
    isCircular=true,
    diameter=1.744,
    p_a_start=system.p_ambient,
    p_b_start=system.p_ambient,
    length=8.521,
    height_ab=-8.521,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T_start(displayUnit="K") = data.T_cold)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={22,-52})));
  Modelica.Fluid.Pipes.DynamicPipe Upper_Riser(
    crossArea=1.431,
    isCircular=true,
    diameter=1.35,
    p_a_start=system.p_ambient,
    length=7.925,
    height_ab=7.925,
    p_b_start=system.p_ambient,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T_start=data.T_hot)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,-20})));
  inner Modelica.Fluid.System system(
      T_ambient(displayUnit="K") = 531.48,
    p_ambient(displayUnit="bar") = 12755300,
    m_flow_start=100)
    annotation (Placement(transformation(extent={{-120,120},{-100,140}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Modelica.Media.Water.StandardWater, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-18,-114},{-34,-98}})));
  Modelica.Fluid.Sensors.Temperature Tcore_exit(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-94,-74},{-106,-62}})));
  Modelica.Fluid.Pipes.DynamicPipe PressurizerandTopper(
    crossArea=1.431,
    isCircular=true,
    diameter=1.35,
    p_a_start=system.p_ambient,
    p_b_start=system.p_ambient,
    length=0.823,
    height_ab=0.823,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T_start=data.T_hot)
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,14})));
  Modelica.Fluid.Sensors.Temperature Tcore_inlet(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-92,-108},{-106,-120}})));
  TRANSFORM.Fluid.FittingsAndResistances.PipeLoss pipeLoss(
    allowFlowReversal=true,
    m_flow_start=100,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.PipeLossResistance.Circle
        (dimension_avg=0.4),
    K_ab=635.0) annotation (Placement(transformation(extent={{-14,26},{6,46}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=67,
    use_input=true)                                      annotation (
      Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={81,-63})));
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
    m_flow_a_start_tube=data.m_flow,
    ps_start_shell=dataInitial.p_start_STHX_shell,
    Ts_start_shell=dataInitial.T_start_STHX_shell,
    ps_start_tube=dataInitial.p_start_STHX_tube,
    hs_start_tube=dataInitial.h_start_STHX_tube,
    Ts_wall_start=dataInitial.T_start_STHX_tubeWall,
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
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
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater)
                                                                  annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={27,0})));

  Components.Data.DataInitial dataInitial(p_start_pressurizer=12755300)
    annotation (Placement(transformation(extent={{80,120},{100,140}})));
  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{40,-38},{56,-52}})));
  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{34,52},{50,38}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port pressurizer(
    p_start=dataInitial.p_start_pressurizer,
    h_start=dataInitial.h_start_pressurizer,
    A=0.25*Modelica.Constants.pi*data.d_pressurizer^2,
    level_start=dataInitial.level_start_pressurizer,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    "pressurizer.Medium.bubbleEnthalpy(Medium.setSat_p(pressurizer.p_start))"
    annotation (Placement(transformation(extent={{-54,70},{-34,90}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume pressurizer_tee(
    V=0.001,
    p_start=dataInitial.p_start_pressurizer_tee,
    T_start=dataInitial.T_start_pressurizer_tee,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-50,30},{-38,42}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance teeTopressurizer(R=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-44,56})));
  TRANSFORM.Nuclear.CoreSubchannels.Regions_3 core(
    redeclare package Material_2 = TRANSFORM.Media.Solids.Helium,
    redeclare package Material_3 = TRANSFORM.Media.Solids.ZrNb_E125,
    nParallel=data.nAssembly,
    p_b_start(displayUnit="Pa"),
    Q_nominal=data.Q_total,
    SigmaF_start=26,
    T_start_1=data.T_avg + 400,
    T_start_2=data.T_avg + 130,
    T_start_3=data.T_avg + 30,
    p_a_start(displayUnit="Pa") = data.p,
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
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
        (
        nPins=data.nRodFuel_assembly,
        nPins_nonFuel=data.nRodNonFuel_assembly,
        width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
        rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
            data.r_outer_fuelRod},
        length=data.length_core,
        angle=1.5707963267949),
    redeclare package Material_1 = TRANSFORM.Media.Solids.UO2,
    rho_input=CR_reactivity.y,
    Teffref_fuel=764.206,
    Teffref_coolant=565.392)
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,-90})));

  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater,
                                         allowFlowReversal=false)
    annotation (Placement(transformation(extent={{66,-82},{48,-64}})));

  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{-54,128},{-42,140}})));
  Modelica.Blocks.Sources.RealExpression Q_total(y=core.Q_total.y)
    "total thermal power"
    annotation (Placement(transformation(extent={{-76,118},{-64,130}})));
  Modelica.Fluid.Sensors.Pressure Secondary_Side_Pressure(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{70,68},{90,88}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy Steam_exit_enthalpy(redeclare package
              Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{18,56},{36,74}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy Feed_Enthalpy(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{46,-24},{62,-8}})));
equation

  connect(Lower_Riser.port_b, Upper_Riser.port_a)
    annotation (Line(points={{-76,-44},{-76,-30}},
                                                 color={0,127,255}));
  connect(Upper_Riser.port_b, PressurizerandTopper.port_a)
    annotation (Line(points={{-76,-10},{-76,4}}, color={0,127,255}));
  connect(DownComer.port_b, massFlowRate.port_a)
    annotation (Line(points={{22,-62},{22,-106},{-18,-106}},
                                                         color={0,127,255}));
  connect(DownComer.port_a, STHX.port_b_shell)
    annotation (Line(points={{22,-42},{22,-12},{21.94,-12}},
                                                           color={0,127,255}));
  connect(pipeLoss.port_b, STHX.port_a_shell) annotation (Line(points={{6,36},{
          21.94,36},{21.94,12}},  color={0,127,255}));
  connect(temperature2.port, STHX.port_a_tube) annotation (Line(points={{48,-38},
          {50,-38},{50,-34},{36,-34},{36,-12},{27,-12}},
                                                     color={0,127,255}));
  connect(temperature3.port, STHX.port_b_tube)
    annotation (Line(points={{42,52},{27,52},{27,12}}, color={0,127,255}));
  connect(PressurizerandTopper.port_b, pressurizer_tee.port_1)
    annotation (Line(points={{-76,24},{-76,36},{-50,36}}, color={0,127,255}));
  connect(pressurizer_tee.port_2, pipeLoss.port_a)
    annotation (Line(points={{-38,36},{-14,36}},color={0,127,255}));
  connect(teeTopressurizer.port_b, pressurizer.port)
    annotation (Line(points={{-44,63},{-44,71.6}}, color={0,127,255}));
  connect(pressurizer_tee.port_3, teeTopressurizer.port_a)
    annotation (Line(points={{-44,42},{-44,49}}, color={0,127,255}));
  connect(core.port_b, Lower_Riser.port_a)
    annotation (Line(points={{-76,-80},{-76,-64}}, color={0,127,255}));
  connect(massFlowRate.port_b, core.port_a) annotation (Line(points={{-34,
          -106},{-76,-106},{-76,-100}},
                                color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, massFlowRate1.port_a)
    annotation (Line(points={{70,-63},{70,-73},{66,-73}},
                                                 color={0,127,255}));
  connect(massFlowRate1.port_b, STHX.port_a_tube)
    annotation (Line(points={{48,-73},{27,-73},{27,-12}},color={0,127,255}));

  connect(STHX.port_b_tube, port_b) annotation (Line(points={{27,12},{27,20},
          {74,20},{74,60},{104,60}},color={0,127,255}));
  connect(port_a, pump_SimpleMassFlow1.port_a) annotation (Line(points={{104,
          -6},{96,-6},{96,-63},{92,-63}}, color={0,127,255}));
  connect(sensorBus.Q_total, Q_total.y) annotation (Line(
      points={{-29.9,100.1},{-48,100.1},{-48,100},{-60,100},{-60,124},{-63.4,
          124}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.reactivity_ControlRod, CR_reactivity.u) annotation (
      Line(
      points={{30.1,100.1},{-60,100.1},{-60,134},{-55.2,134}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Tcore_inlet.port, core.port_a) annotation (Line(points={{-99,-108},
          {-100,-108},{-100,-104},{-76,-104},{-76,-100}},
                                                    color={0,127,255}));
  connect(Tcore_exit.port, Lower_Riser.port_a) annotation (Line(points={{-100,-74},
          {-76,-74},{-76,-64}}, color={0,127,255}));
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
      points={{30,100},{62,100},{62,28},{81,28},{81,-54.97}},
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{100,140}}),
                         graphics={Bitmap(extent={{-114,-90},{110,90}},fileName=
             "modelica://NHES/Resources/Images/Systems/PHS/Schematic-of-a-NuScale-power-module.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{100,
            140}})));
end SMR_Tave_enthalpy;
