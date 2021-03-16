within NHES.Systems.PrimaryHeatSystem.Westinghouse4LoopPWR;
model NSSS
  import TRANSFORM;
  extends BaseClasses.Partial_SubSystem_A(
    replaceable package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=system.allowFlowReversal,
    redeclare replaceable CS_Default CS,
    redeclare replaceable ED_Default ED,
    port_a_nominal(
      p=data.p_shellSide,
      h=Medium.specificEnthalpy_pT(port_a_nominal.p,data.T_inlet_shell),
      m_flow=data.m_flow_shellSide_total),
    port_b_nominal(p=data.p_shellSide, h=data.h_vsat),
    redeclare Data.Data_Basic data,
    FuelConsumption(y=(1 + 0.169)*Q_total.y/(200*1.6e-13*6.022e23/0.235)));

  package Medium_PHTS = Modelica.Media.Water.StandardWater
    "Primary heat transport system medium" annotation (Dialog(enable=false));

  TRANSFORM.Nuclear.CoreSubchannels.Regions_3 coreSubchannel(
    redeclare package Medium = Medium_PHTS,
    redeclare package Material_1 = TRANSFORM.Media.Solids.UO2,
    redeclare package Material_2 = TRANSFORM.Media.Solids.Helium,
    redeclare package Material_3 = TRANSFORM.Media.Solids.ZrNb_E125,
    exposeState_b=true,
    nParallel=data.nAssembly,
    redeclare model Geometry =
      TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
        (
        nPins=data.nRodFuel_assembly,
        nPins_nonFuel=data.nRodNonFuel_assembly,
        width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
        length=data.length_fuel,
        angle=1.5707963267949,
        rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
            data.r_outer_fuelRod}),
    p_a_start(displayUnit="Pa") = data.p_nominal,
    p_b_start(displayUnit="Pa"),
    T_a_start(displayUnit="K") = data.T_core_inlet_nominal,
    T_b_start(displayUnit="K") = data.T_core_outlet_nominal,
    m_flow_a_start=data.m_flow_nominal,
    Q_nominal=data.Q_total_th,
    redeclare model HeatTransfer =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    T_start_1=data.T_core_avg + 400,
    T_start_2=data.T_core_avg + 130,
    T_start_3=data.T_core_avg + 30,
    redeclare record Data_DH =
      TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
    redeclare record Data_FP =
      TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_TeIXe_U235,
    SigmaF_start=26,
    rho_input=CR_reactivity.y,
    Ts_start_1(displayUnit="K") = transpose([1203.67,1085.61,791.52; 1214.4,
      1095.39,799.042; 1224.58,1104.66,806.171; 1234.08,1113.31,812.824]),
    Ts_start_2(displayUnit="K") = transpose([791.487,703.419,611.338; 799.007,
      711.324,619.721; 806.135,718.811,627.654; 812.786,725.793,635.045]),
    Ts_start_3(displayUnit="K") = transpose([611.339,601.765,592.762; 619.722,
      610.192,601.231; 627.656,618.166,609.245; 635.048,625.596,616.71]),
    Ts_start(displayUnit="degC") = {574.134,582.884,591.218,599.063},
    mCs_fp_start=fill(0, coreSubchannel.kinetics.fissionProducts.nC),
    Teffref_fuel=978.463,
    Teffref_coolant=587.8) annotation (Placement(transformation(
        extent={{-7,-6},{7,6}},
        rotation=90,
        origin={-60,-30})));

  TRANSFORM.Fluid.Volumes.SimpleVolume core_outletPlenum(
    redeclare package Medium = Medium_PHTS,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder (
        length=data.length_outlet_plenum,
        crossArea=data.crossArea_outlet_plenum,
        angle=1.5707963267949),
    p_start=data.p_nominal,
    T_start=data.T_core_outlet_nominal) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={-60,10})));

  TRANSFORM.Fluid.Volumes.SimpleVolume core_inletPlenum(
    redeclare package Medium = Medium_PHTS,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder (
        length=data.length_inlet_plenum,
        crossArea=data.crossArea_inlet_plenum,
        angle=1.5707963267949),
    p_start(displayUnit="Pa") = data.p_nominal,
    T_start(displayUnit="K") = data.T_core_inlet_nominal) annotation (
      Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-60,-68})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface DownComer(
    redeclare package Medium = Medium_PHTS,
    energyDynamics=system.energyDynamics,
    momentumDynamics=system.momentumDynamics,
    p_a_start(displayUnit="Pa") = data.p_nominal,
    p_b_start(displayUnit="Pa"),
    T_a_start(displayUnit="K") = data.T_core_inlet_nominal,
    T_b_start(displayUnit="K"),
    m_flow_a_start=data.m_flow_nominal,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        crossArea=data.crossArea_downcomer,
        length=data.length_downcomer,
        perimeter=data.perimeter_downcomer,
        angle=-1.5707963267949)) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={-40,-40})));

  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume PressurizerHeader(
    redeclare package Medium = Medium_PHTS,
    V=0.01,
    p_start(displayUnit="Pa") = data.p_nominal,
    T_start(displayUnit="K") = data.T_core_outlet_nominal)
    annotation (Placement(transformation(extent={{-32,48},{-24,56}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_toPzr(R=1,
      redeclare package Medium = Medium_PHTS) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-28,63})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_coreOutlet(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        origin={-60,-8.5},
        extent={{-5.5,-5},{5.5,5}},
        rotation=90)));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_coreInlet(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        extent={{-5.5,-5},{5.5,5}},
        rotation=90,
        origin={-60,-50.5})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_toHeader(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={-48,52})));
  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port  pressurizer(
    redeclare package Medium = Medium_PHTS,
    p_start(displayUnit="Pa") = data.p_nominal,
    h_start=pressurizer.Medium.bubbleEnthalpy(Medium.setSat_p(pressurizer.p_start)),
    level_start=0.5*data.length_pzr,
    A=0.25*Modelica.Constants.pi*data.dimension_pzr^2)
    annotation (Placement(transformation(extent={{-34,70},{-22,82}})));

  inner TRANSFORM.Fluid.System system(
    m_flow_start=4712,
    p_start(displayUnit="MPa") = 15500000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=565.15)
    annotation (Placement(transformation(extent={{80,110},{100,130}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_SGtubeOutlet(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        origin={24,-26.5},
        extent={{5.5,-5},{-5.5,5}},
        rotation=90)));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_SGtubeInlet(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        origin={24,24.5},
        extent={{5.5,-5},{-5.5,5}},
        rotation=90)));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_SGshellInlet(
      redeclare package Medium = Medium, R=1*p_units/data.m_flow_shellSide_total)
    annotation (Placement(transformation(
        origin={36,-26.5},
        extent={{-5.5,-5},{5.5,5}},
        rotation=90)));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_SGshellOutlet(
      redeclare package Medium = Medium, R=1*p_units/data.m_flow_shellSide_total)
    annotation (Placement(transformation(
        origin={36,24.5},
        extent={{-5.5,-5},{5.5,5}},
        rotation=90)));
  TRANSFORM.Fluid.Volumes.SimpleVolume SG_InletPlenum(
    redeclare package Medium = Medium_PHTS,
    p_start=data.p_nominal,
    T_start=data.T_core_outlet_nominal,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1)) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={24,42})));

  TRANSFORM.Fluid.Volumes.SimpleVolume SG_OutletPlenum(
    redeclare package Medium = Medium_PHTS,
    p_start=data.p_nominal,
    T_start=data.T_core_inlet_nominal,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1)) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={24,-50})));

  TRANSFORM.Fluid.Volumes.MixingVolume downcomer_SG(
    redeclare package Medium = Medium,
    energyDynamics=system.energyDynamics,
    nPorts_a=1,
    p_start=data.p_shellSide,
    T_start=data.T_inlet_shell,
    nPorts_b=1,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.volume_SG_downcomer)) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={56,-26})));

  TRANSFORM.Fluid.Sensors.Temperature T_Core_Inlet(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,-40},{-76,-48}})));
  TRANSFORM.Fluid.Sensors.Temperature T_Core_Outlet(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,-20},{-76,-12}})));

  Modelica.Blocks.Sources.RealExpression p_pressurizer(y=pressurizer.p)
    "pressurizer pressure"
    annotation (Placement(transformation(extent={{-76,128},{-64,140}})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_fromHeader(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={-14,52})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX steamGenerator(
    redeclare package Material_tubeWall =
        TRANSFORM.Media.Solids.Inconel690,
    energyDynamics={system.energyDynamics,system.energyDynamics,system.energyDynamics},
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube = Medium_PHTS,
    redeclare model HeatTransfer_shell =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
    redeclare model HeatTransfer_tube =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    p_a_start_shell(displayUnit="bar") = data.p_shellSide,
    p_b_start_shell(displayUnit="bar"),
    Ts_start_shell(displayUnit="K"),
    T_a_start_shell(displayUnit="K"),
    T_b_start_shell(displayUnit="K"),
    use_Ts_start_shell=false,
    p_a_start_tube(displayUnit="Pa") = data.p_nominal,
    p_b_start_tube(displayUnit="Pa"),
    T_a_start_tube=data.T_core_outlet_nominal,
    T_b_start_tube=data.T_core_inlet_nominal,
    m_flow_a_start_tube=data.m_flow_nominal,
    nParallel=data.nSG,
    m_flow_a_start_shell=data.m_flow_shellSide_total,
    h_b_start_shell=data.h_vsat - 1e5,
    h_a_start_shell=data.h_inlet_shell,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        nV=20,
        nR=3,
        D_o_shell=data.diameter_inner_lowerShell,
        length_shell=data.length_lowerShell,
        nTubes=data.nTubes,
        dimension_tube=data.diameter_inner_SGtube,
        length_tube=data.length_SGtube,
        th_wall=data.th_SGtube)) annotation (Placement(transformation(
        extent={{-13,-11},{13,11}},
        rotation=-90,
        origin={30,1})));

  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{-54,128},{-42,140}})));
  Modelica.Blocks.Sources.RealExpression Q_total(y=coreSubchannel.kinetics.Q_total)
    "total thermal power"
    annotation (Placement(transformation(extent={{-76,118},{-64,130}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface coldleg(
    redeclare package Medium = Medium_PHTS,
    p_a_start(displayUnit="Pa") = data.p_nominal,
    p_b_start(displayUnit="Pa"),
    T_a_start(displayUnit="K") = data.T_core_inlet_nominal,
    T_b_start(displayUnit="K"),
    m_flow_a_start=data.m_flow_nominal,
    exposeState_b=true,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=data.dimension_coldleg,
        length=data.length_coldleg,
        nV=2)) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-16,-22})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface hotLeg(
    redeclare package Medium = Medium_PHTS,
    p_a_start(displayUnit="Pa") = data.p_nominal,
    p_b_start(displayUnit="Pa"),
    T_b_start(displayUnit="K"),
    m_flow_a_start=data.m_flow_nominal,
    exposeState_b=true,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=data.dimension_hotleg,
        length=data.length_hotleg,
        nV=2),
    T_a_start(displayUnit="K") = data.T_core_outlet_nominal) annotation (
      Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={2,52})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_coldLeg(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        origin={0,-22.5},
        extent={{-5.5,-5},{5.5,5}},
        rotation=180)));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_hotLeg(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        origin={20,52.5},
        extent={{5.5,-5},{-5.5,5}},
        rotation=180)));

protected
  final parameter SI.Pressure p_units = 1;

public
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_downcomer(
      redeclare package Medium = Medium_PHTS, R=1*p_units/data.m_flow_nominal)
    annotation (Placement(transformation(
        origin={-32,-22.5},
        extent={{-5.5,-5},{5.5,5}},
        rotation=180)));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(m_flow_nominal=data.m_flow_nominal,
      redeclare package Medium = Medium,
    use_input=true)                      annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={4,-42})));
  TRANSFORM.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={74,20})));
  TRANSFORM.Fluid.Volumes.BoilerDrum drum(
    redeclare package Medium = Medium,
    p_vapor_start=data.p_shellSide,
    cp_wall=600,
    Twall_start=data.sat.Tsat,
    redeclare model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        length=data.length_upperShell,
        th_wall=data.th_shell,
        r_inner=data.r_outer_upperShell_eff),
    d_wall=7000)
    annotation (Placement(transformation(extent={{40,32},{60,52}})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_SGshellOutlet1(
      redeclare package Medium = Medium, R=1*p_units/data.m_flow_shellSide_total)
    annotation (Placement(transformation(
        origin={64,54.5},
        extent={{5.5,-5},{-5.5,5}},
        rotation=180)));
  TRANSFORM.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{74,48},{86,60}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5*data.m_flow_shellSide_total,
    use_input=true) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={56,0})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
      redeclare package Medium = Medium, use_input=true) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={74,-30})));
  Modelica.Blocks.Sources.RealExpression level(y=drum.level) "drum level"
    annotation (Placement(transformation(extent={{-76,108},{-64,120}})));
equation

  connect(res_toPzr.port_b, PressurizerHeader.port_3) annotation (Line(points={{
          -28,59.5},{-28,59.5},{-28,56}}, color={0,0,255}));
  connect(coreSubchannel.port_a, res_coreInlet.port_b)
    annotation (Line(points={{-60,-37},{-60,-46.65}}, color={0,127,255}));
  connect(PressurizerHeader.port_1, res_toHeader.port_b)
    annotation (Line(points={{-32,52},{-44.5,52}}, color={0,127,255}));
  connect(sensorBus.T_Core_Inlet, T_Core_Inlet.T) annotation (Line(
      points={{-29.9,100.1},{-98,100.1},{-98,-44},{-74.4,-44}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Outlet, T_Core_Outlet.T) annotation (Line(
      points={{-29.9,100.1},{-98,100.1},{-98,-16},{-74.4,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PressurizerHeader.port_2, res_fromHeader.port_a)
    annotation (Line(points={{-24,52},{-17.5,52}}, color={0,127,255}));

  connect(coreSubchannel.port_b, res_coreOutlet.port_a)
    annotation (Line(points={{-60,-23},{-60,-12.35}}, color={0,127,255}));
  connect(T_Core_Outlet.port, res_coreOutlet.port_a) annotation (Line(points={{-72,
          -20},{-60,-20},{-60,-12.35}}, color={0,127,255}));
  connect(T_Core_Inlet.port, coreSubchannel.port_a) annotation (Line(points={{-72,-40},
          {-60,-40},{-60,-37}},          color={0,127,255}));
  connect(sensorBus.Q_total, Q_total.y) annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{-60,100.1},{-60,124},{-63.4,124}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(core_outletPlenum.port_a, res_coreOutlet.port_b)
    annotation (Line(points={{-60,6.4},{-60,-4.65}}, color={0,127,255}));
  connect(res_coreInlet.port_a, core_inletPlenum.port_b)
    annotation (Line(points={{-60,-54.35},{-60,-64.4}}, color={0,127,255}));
  connect(DownComer.port_b, core_inletPlenum.port_a) annotation (Line(points={{-40,
          -46},{-40,-80},{-60,-80},{-60,-71.6}}, color={0,127,255}));
  connect(core_outletPlenum.port_b, res_toHeader.port_a) annotation (Line(
        points={{-60,13.6},{-60,52},{-51.5,52}}, color={0,127,255}));
  connect(SG_OutletPlenum.port_a, res_SGtubeOutlet.port_b)
    annotation (Line(points={{24,-46.4},{24,-30.35}}, color={0,127,255}));
  connect(SG_InletPlenum.port_b, res_SGtubeInlet.port_a)
    annotation (Line(points={{24,38.4},{24,28.35}}, color={0,127,255}));
  connect(res_downcomer.port_b, DownComer.port_a) annotation (Line(points={{-35.85,
          -22.5},{-40,-22.5},{-40,-34}}, color={0,127,255}));
  connect(res_SGshellInlet.port_b, steamGenerator.port_a_shell) annotation (
      Line(points={{36,-22.65},{36,-12},{35.06,-12}}, color={0,127,255}));
  connect(res_SGshellOutlet.port_a, steamGenerator.port_b_shell) annotation (
      Line(points={{36,20.65},{36,14},{35.06,14}}, color={0,127,255}));
  connect(res_SGtubeOutlet.port_a, steamGenerator.port_b_tube) annotation (Line(
        points={{24,-22.65},{24,-16},{30,-16},{30,-12}}, color={0,127,255}));
  connect(res_SGtubeInlet.port_b, steamGenerator.port_a_tube) annotation (Line(
        points={{24,20.65},{24,18},{30,18},{30,14}}, color={0,127,255}));
  connect(res_fromHeader.port_b, hotLeg.port_a)
    annotation (Line(points={{-10.5,52},{-4,52}}, color={0,127,255}));
  connect(hotLeg.port_b, res_hotLeg.port_a) annotation (Line(points={{8,52},{12,
          52},{12,52.5},{16.15,52.5}}, color={0,127,255}));
  connect(res_hotLeg.port_b, SG_InletPlenum.port_a) annotation (Line(points={{23.85,
          52.5},{24,52.5},{24,45.6}}, color={0,127,255}));
  connect(pump.port_a, SG_OutletPlenum.port_b) annotation (Line(points={{4,-52},
          {4,-60},{24,-60},{24,-53.6}}, color={0,127,255}));
  connect(res_downcomer.port_a, coldleg.port_b) annotation (Line(points={{-28.15,
          -22.5},{-25.075,-22.5},{-25.075,-22},{-22,-22}}, color={0,127,255}));
  connect(coldleg.port_a, res_coldLeg.port_b) annotation (Line(points={{-10,-22},
          {-6,-22},{-6,-22.5},{-3.85,-22.5}}, color={0,127,255}));
  connect(res_coldLeg.port_a, pump.port_b) annotation (Line(points={{3.85,-22.5},
          {3.85,-26.25},{4,-26.25},{4,-32}}, color={0,127,255}));
  connect(res_SGshellOutlet1.port_a, drum.steamPort) annotation (Line(points={{60.15,
          54.5},{57,54.5},{57,49.6}}, color={0,127,255}));
  connect(drum.riserPort, res_SGshellOutlet.port_b) annotation (Line(points={{43,34},
          {44,34},{44,32},{36,32},{36,28.35}},     color={0,127,255}));
  connect(pump_SimpleMassFlow.port_a, drum.downcomerPort)
    annotation (Line(points={{56,10},{56,34},{57,34}},color={0,127,255}));
  connect(pump_SimpleMassFlow.port_b, downcomer_SG.port_a[1]) annotation (Line(
        points={{56,-10},{56,-22.4}},          color={0,127,255}));
  connect(massFlowRate.port_b, drum.feedwaterPort)
    annotation (Line(points={{74,26},{74,42},{60,42}},  color={0,127,255}));
  connect(downcomer_SG.port_b[1], res_SGshellInlet.port_a) annotation (Line(
        points={{56,-29.6},{56,-38},{36,-38},{36,-30.35}}, color={0,127,255}));
  connect(actuatorBus.reactivity_ControlRod, CR_reactivity.u) annotation (
      Line(
      points={{30.1,100.1},{-2,100.1},{-2,102},{-58,102},{-58,134},{-55.2,134}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SGpump_m_flow, pump_SimpleMassFlow.in_m_flow)
    annotation (Line(
      points={{30.1,100.1},{100,100.1},{100,0},{63.3,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(res_SGshellOutlet1.port_b, massFlowRate1.port_a) annotation (Line(
        points={{67.85,54.5},{74,54.5},{74,54}}, color={0,127,255}));
  connect(massFlowRate1.port_b, port_b) annotation (Line(points={{86,54},{92,54},
          {92,40},{100,40}}, color={0,127,255}));
  connect(sensorBus.m_flow_boilerDrum, massFlowRate1.m_flow) annotation (Line(
      points={{-29.9,100.1},{8,100.1},{8,102},{80,102},{80,56.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_feedWater, massFlowRate.m_flow) annotation (Line(
      points={{-29.9,100.1},{8,100.1},{8,102},{98,102},{98,20},{76.16,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(massFlowRate.port_a, pump_SimpleMassFlow1.port_b)
    annotation (Line(points={{74,14},{74,-20}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_a, port_a)
    annotation (Line(points={{74,-40},{100,-40}}, color={0,127,255}));
  connect(actuatorBus.FWpump_m_flow, pump_SimpleMassFlow1.in_m_flow)
    annotation (Line(
      points={{30.1,100.1},{100,100.1},{100,-30},{81.3,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_a, port_a) annotation (Line(points={{100,-40},{95,-40},{95,-40},
          {100,-40}}, color={0,127,255}));
  connect(sensorBus.level_drum, level.y) annotation (Line(
      points={{-29.9,100.1},{-60,100.1},{-60,114},{-63.4,114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PHSpump_m_flow, pump.in_m_flow)
    annotation (Line(
      points={{30.1,100.1},{100,100.1},{100,-42},{11.3,-42}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_pressurizer, p_pressurizer.y)
    annotation (Line(
      points={{-29.9,100.1},{-60,100.1},{-60,134},{-63.4,134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(res_toPzr.port_a, pressurizer.port)
    annotation (Line(points={{-28,66.5},{-28,70.96}}, color={0,127,255}));
  annotation (
    defaultComponentName="PHS",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{72,-46},{68,-50},{84,-50},{80,-46},{72,-46}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-16,3},{16,-3}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255},
          origin={70,-41},
          rotation=180),
        Ellipse(
          extent={{70,-36},{82,-48}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Westinghouse: 4-Loop PWR"),
        Rectangle(
          extent={{-0.492602,1.39701},{17.9804,-1.39699}},
          lineColor={0,0,0},
          origin={-50.0196,32.603},
          rotation=180,
          fillColor={230,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{0.9,1.1334},{12.3937,-1.1334}},
          lineColor={0,0,0},
          origin={-67.8666,30.3395},
          rotation=90,
          fillColor={230,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.81827,5.40665},{66.3684,-5.40665}},
          lineColor={0,0,0},
          origin={-44.5933,-44.1817},
          rotation=90,
          fillColor={240,215,26},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.54667,5},{56.453,-5}},
          lineColor={0,0,0},
          origin={-48.453,41},
          rotation=0,
          fillColor={230,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.28,5},{46.7196,-5}},
          lineColor={0,0,0},
          origin={-38.7196,-41},
          rotation=0,
          fillColor={240,215,26},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-14,-44},{-18,-48},{-2,-48},{-6,-44},{-14,-44}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{-16,-34},{-4,-46}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-8,-37},{-8,-43},{-12,-40},{-8,-37}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-79,64},{-57,41}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-77,61},{-60,51}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-77,51},{-60,43}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-1.17337,6},{42.8266,-6}},
          lineColor={0,0,0},
          origin={-44,3.17337},
          rotation=90,
          fillColor={230,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-68,-24},{-20,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={240,215,26}),
        Ellipse(
          extent={{-68,16},{-20,8}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={230,0,0}),
        Rectangle(
          extent={{-68,12},{-20,-28}},
          lineColor={0,0,0},
          fillColor={200,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,12},{-60,-28}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,12},{-52,-28}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,12},{-44,-28}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,12},{-36,-28}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,12},{-28,-28}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,48},{-72,48},{-74,46},{-72,44},{-80,44}}, color={0,0,0}),
        Rectangle(
          extent={{-13,4},{13,-4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={230,0,0},
          origin={6,33},
          rotation=-90),
        Rectangle(
          extent={{-20,3},{20,-3}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={13,0},
          rotation=-90),
        Rectangle(
          extent={{-20,4},{20,-4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={20,0},
          rotation=-90),
        Rectangle(
          extent={{-0.693333,3.99999},{25.307,-4}},
          lineColor={0,0,0},
          origin={6,-45.307},
          rotation=90,
          fillColor={240,215,26},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{46,56},{76,50}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-13,4},{13,-4}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={20,33},
          rotation=90),
        Rectangle(
          extent={{-9,3},{9,-3}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255},
          origin={33,-37},
          rotation=360),
        Rectangle(
          extent={{-10,4},{10,-4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255},
          origin={20,-30},
          rotation=-90),
        Rectangle(
          extent={{-20,4},{20,-4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,136,0},
          origin={6,0},
          rotation=-90),
        Rectangle(
          extent={{14,58},{46,30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,42},{44,32}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{78,-39},{78,-45},{74,-42},{78,-39}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-32,3},{32,-3}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255},
          origin={39,-2},
          rotation=90),
        Rectangle(
          extent={{-40,3},{40,-3}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255},
          origin={57,-4},
          rotation=90),
        Rectangle(
          extent={{-7,3},{7,-3}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255},
          origin={53,35},
          rotation=180),
        Rectangle(
          extent={{70,42},{86,36}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-10,3},{10,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={73,46},
          rotation=90),
        Polygon(
          points={{30,-42},{26,-46},{42,-46},{38,-42},{30,-42}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{28,-32},{40,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{36,-35},{36,-41},{32,-38},{36,-35}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=10000,
      __Dymola_Algorithm="Esdirk45a"));
end NSSS;
