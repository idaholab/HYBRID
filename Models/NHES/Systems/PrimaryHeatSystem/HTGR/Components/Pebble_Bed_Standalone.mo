within NHES.Systems.PrimaryHeatSystem.HTGR.Components;
model Pebble_Bed_Standalone
    extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS,
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

  replaceable package Coolant_Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                      annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                             annotation(choicesAllMatching = true, dialog(group = "Media"));

  //Modelica.Units.SI.Power Q_Recup;
    package Medium = NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT;
    Modelica.Units.SI.Power Q_gen;
    Real cycle_eff;
    Real combined_cycle_eff;
    Modelica.Units.SI.Power Q_Trans;
    parameter Real eff = 0.9;
  TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    p_start=dataInitial.P_Core_Outlet,
    T_start=dataInitial.T_Core_Outlet,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-106,-74})));
  GasTurbine.Turbine.Turbine      turbine(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    pstart_out=dataInitial.P_Turbine_Ref,
    Tstart_in=dataInitial.TStart_In_Turbine,
    Tstart_out=dataInitial.TStart_Out_Turbine,
    eta0=data.Turbine_Efficiency,
    PR0=data.Turbine_Pressure_Ratio,
    w0=data.Turbine_Nominal_MassFlowRate)
            annotation (Placement(transformation(extent={{-88,-74},{-24,-28}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
    NTU=data.HX_Reheat_NTU,
    K_tube=data.HX_Reheat_K_tube,
    K_shell=data.HX_Reheat_K_shell,
    redeclare package Tube_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Shell_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    V_Tube=data.HX_Reheat_Tube_Vol,
    V_Shell=data.HX_Reheat_Shell_Vol,
    V_buffers=data.HX_Reheat_Buffer_Vol,
    p_start_tube=dataInitial.Recuperator_P_Tube,
    h_start_tube_inlet=dataInitial.Recuperator_h_Tube_Inlet,
    h_start_tube_outlet=dataInitial.Recuperator_h_Tube_Outlet,
    p_start_shell=dataInitial.Recuperator_P_Tube,
    h_start_shell_inlet=dataInitial.Recuperator_h_Shell_Inlet,
    h_start_shell_outlet=dataInitial.HX_Aux_h_tube_out,
    dp_init_tube=dataInitial.Recuperator_dp_Tube,
    dp_init_shell=dataInitial.Recuperator_dp_Shell,
    Q_init=-100000000,
    Cr_init=0.8,
    m_start_tube=dataInitial.Recuperator_m_Tube,
    m_start_shell=dataInitial.Recuperator_m_Shell)
    annotation (Placement(transformation(extent={{20,-52},{0,-32}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium
      = NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={36,-22})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    p_start=dataInitial.P_HP_Comp_Ref,
    T_start=data.T_Precooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={40,38})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary3(use_port=
        false, T=data.T_Precooler)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={2,36})));
  GasTurbine.Compressor.Compressor      compressor(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    pstart_in=dataInitial.P_LP_Comp_Ref,
    Tstart_in=dataInitial.TStart_LP_Comp_In,
    Tstart_out=dataInitial.TStart_LP_Comp_Out,
    eta0=data.LP_Comp_Efficiency,
    PR0=data.LP_Comp_P_Ratio,
    w0=data.LP_Comp_MassFlowRate)
            annotation (Placement(transformation(extent={{54,18},{98,50}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={106,12})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    p_start=dataInitial.P_LP_Comp_Ref,
    T_start=data.T_Intercooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.0),
    use_HeatPort=true,
    Q_gen=-Q_Trans)    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={104,-66})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
        false, T=data.T_Intercooler)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={132,-66})));
  GasTurbine.Compressor.Compressor      compressor1(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    allowFlowReversal=false,
    pstart_in=dataInitial.P_HP_Comp_Ref,
    Tstart_in=dataInitial.TStart_HP_Comp_In,
    Tstart_out=dataInitial.TStart_HP_Comp_Out,
    eta0=data.HP_Comp_Efficiency,
    PR0=data.HP_Comp_P_Ratio,
    w0=data.HP_Comp_MassFlowRate)
            annotation (Placement(transformation(extent={{25,-18},{-25,18}},
        rotation=0,
        origin={61,-100})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe1(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={46,-62})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = BaseClasses.He_HighT,
    p_spring=data.P_Release,
    K=data.K_P_Release,
    opening_init=0.)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,58})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = BaseClasses.He_HighT,
    p=data.P_Release,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={4,86})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
      Medium = BaseClasses.He_HighT) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-8,-86})));

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
                      dataInitial
    annotation (Placement(transformation(extent={{80,124},{100,144}})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
    NTU=1,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=3,
    V_Shell=3,
    V_buffers=1,
    p_start_tube=5920000,
    h_start_tube_inlet=3600e3,
    h_start_tube_outlet=2900e3,
    p_start_shell=1000000,
    h_start_shell_inlet=600e3,
    h_start_shell_outlet=1000e3,
    dp_init_tube=30000,
    dp_init_shell=40000,
    Q_init=-100000000,
    Cr_init=0.8,
    m_start_tube=296.1,
    m_start_shell=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-28})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=0,
    T=373.15,
    nPorts=1) annotation (Placement(transformation(extent={{-74,-6},{-54,14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-152,-36},{-132,-16}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Reheat_Waste(
    NTU=10,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=0.1,
    V_Shell=0.1,
    V_buffers=0.1,
    p_start_tube=1990000,
    h_start_tube_inlet=2307e3,
    h_start_tube_outlet=3600e3,
    p_start_shell=400000,
    h_start_shell_inlet=600e3,
    h_start_shell_outlet=700e3,
    dp_init_tube=30000,
    dp_init_shell=40000,
    Q_init=-1e7,
    Cr_init=0.8,
    m_start_tube=296.1,
    m_start_shell=296.1) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={32,-2})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary7(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-38,-4},{-18,16}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Intercooler_Source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=20,
    T=306.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,44},{140,64}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=450000,
    T_start=353.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    Q_gen=Q_Trans)
               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={132,0})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T1(redeclare package Medium
      = Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={142,28})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
      package Medium = BaseClasses.He_HighT) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={104,-34})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T2(redeclare package Medium
      = Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={66,4})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T3(redeclare package Medium
      = Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={18,-22})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    p_a_start=200000,
    p_b_start=1000,
    T_a_start=433.15,
    T_b_start=383.15,
    m_flow_start=65,
    m_flow_nominal=65,
    p_inlet_nominal=400000,
    p_outlet_nominal=1000,
    T_nominal=433.15)
    annotation (Placement(transformation(extent={{18,4},{-2,24}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{-28,28},{-8,48}})));
  TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package Medium =
        BaseClasses.He_HighT) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-130,-112})));
  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-8,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-166,-86},{-146,-66}})));
  Modelica.Blocks.Sources.Constant const1(k=850 + 273.15)
    annotation (Placement(transformation(extent={{-202,-86},{-182,-66}})));
  Nuclear.CoreSubchannels.Pebble_Bed_2                       core(
    redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Material =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,

    Q_fission_input=600000000,
    alpha_fuel=-5e-5,
    alpha_coolant=0.0,
    p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
    Q_nominal=600000000,
    SigmaF_start=26,
    p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
    T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
    T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
    m_flow_a_start=data.m_flow,
    exposeState_a=false,
    exposeState_b=false,
    Ts_start(displayUnit="degC"),
    fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare record Data_DH =
        TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,

    redeclare record Data_FP =
        TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,

    rho_input=CR.y,
    redeclare package Medium = BaseClasses.He_HighT,
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
    T_outlet=1123.15)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-62,-104})));
initial equation
  Q_Trans = 1e7;
equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
 Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
 cycle_eff = Q_gen / core.Q_total.y;
 combined_cycle_eff = (Q_gen + steamTurbine.Q_mech)/core.Q_total.y;
 der(Q_Trans) = eff*min(abs(Intercooler_Pre_Temp.port_a.m_flow*Medium.specificHeatCapacityCp(Medium.setState_pT(Intercooler_Pre_Temp.port_a.p, Intercooler_Pre_Temp.T))*(Intercooler_Pre_Temp.T-Intercooler_Source.T)), abs(Intercooler_Source.m_flow*(Intercooler_Source.Medium.specificEnthalpy_pT(Intercooler_Source.ports[1].p,Intercooler_Pre_Temp.T)-Intercooler_Source.Medium.specificEnthalpy_pT(Intercooler_Source.ports[1].p,Intercooler_Source.T))))-Q_Trans;
  connect(Precooler.heatPort, boundary3.port)
    annotation (Line(points={{34,38},{34,36},{12,36}},
                                              color={191,0,0}));
  connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{40,44},{
          26,44},{26,56},{62.8,56},{62.8,46.8}},
                                        color={0,127,255}));
  connect(Intercooler.heatPort, boundary4.port)
    annotation (Line(points={{110,-66},{122,-66}},     color={191,0,0}));
  connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
        points={{46,-85.6},{46,-72}},                                color={0,
          127,255}));
  connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{104,-72},
          {104,-86},{76,-86},{76,-85.6}},
                                        color={0,127,255}));
  connect(springBallValve.port_b,boundary5. ports[1])
    annotation (Line(points={{4,68},{4,76}},              color={0,127,255}));
  connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{4,48},{
          4,44},{40,44}},                         color={0,127,255}));
  connect(Reheater.Shell_in, transportDelayPipe1.port_b)
    annotation (Line(points={{20,-44},{46,-44},{46,-52}},
                                                      color={0,127,255}));
  connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{0,-44},
          {-8,-44},{-8,-46},{-10,-46},{-10,-76},{-8,-76}},
                                                     color={0,127,255}));
  connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-36.8,-32.6},
          {-36.8,-28},{-6,-28},{-6,-38},{0,-38}},
                                              color={0,127,255}));
  connect(Reheater.Tube_out, sensor_T.port_a)
    annotation (Line(points={{20,-38},{36,-38},{36,-32}},
                                                       color={0,127,255}));
  connect(Steam_Offtake.Shell_out, boundary1.ports[1]) annotation (Line(points={{-110,
          -26},{-132,-26}},                         color={0,127,255}));
  connect(boundary2.ports[1], Steam_Offtake.Shell_in) annotation (Line(points={{-54,4},
          {-48,4},{-48,-26},{-90,-26}},        color={0,127,255}));
  connect(Core_Outlet.port_b, Steam_Offtake.Tube_in) annotation (Line(points={{-106,
          -68},{-106,-42},{-114,-42},{-114,-32},{-110,-32}},
                                                      color={0,127,255}));
  connect(Steam_Offtake.Tube_out, turbine.inlet) annotation (Line(points={{-90,-32},
          {-75.2,-32},{-75.2,-32.6}},
                                    color={0,127,255}));
  connect(Steam_Reheat_Waste.Tube_in, sensor_T.port_b)
    annotation (Line(points={{36,-12},{36,-12}},
                                               color={0,127,255}));
  connect(Steam_Reheat_Waste.Tube_out, Precooler.port_a) annotation (Line(
        points={{36,8},{36,24},{40,24},{40,32}},  color={0,127,255}));
  connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{89.2,
          46.8},{106,46.8},{106,22}},       color={0,127,255}));
  connect(Water_T1.port_a, Intercooler_Source.ports[1])
    annotation (Line(points={{142,38},{142,54},{140,54}}, color={0,127,255}));
  connect(Core_Outlet1.port_a, Water_T1.port_b) annotation (Line(points={{132,6},
          {136,6},{136,10},{140,10},{140,18},{142,18}},
                                          color={0,127,255}));
  connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
      Line(points={{106,2},{106,-20},{104,-20},{104,-24}},
                                                         color={0,127,255}));
  connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
    annotation (Line(points={{104,-60},{104,-44}},
                                                 color={0,127,255}));
  connect(Core_Outlet1.port_b, Water_T2.port_a) annotation (Line(points={{132,-6},
          {82,-6},{82,4},{76,4}},    color={0,127,255}));
  connect(Water_T2.port_b, Steam_Reheat_Waste.Shell_in) annotation (Line(points={{56,4},{
          48,4},{48,14},{30,14},{30,8}},                                 color=
          {0,127,255}));
  connect(Water_T3.port_a, Steam_Reheat_Waste.Shell_out)
    annotation (Line(points={{28,-22},{30,-22},{30,-12}},
                                                       color={0,127,255}));
  connect(steamTurbine.shaft_b, generator.shaft) annotation (Line(points={{-2,14},
          {-12,14},{-12,24},{-32,24},{-32,37.9},{-28.1,37.9}}, color={0,0,0}));
  connect(Water_T3.port_b, steamTurbine.portHP) annotation (Line(points={{8,-22},
          {2,-22},{2,0},{20,0},{20,16},{22,16},{22,20},{18,20}},  color={0,127,255}));
  connect(steamTurbine.portLP, boundary7.ports[1]) annotation (Line(points={{-2,20},
          {-10,20},{-10,6},{-18,6}},       color={0,127,255}));
  connect(Core_Outlet_T.T,CR. u_m) annotation (Line(points={{-136,-112},{-156,-112},
          {-156,-88}},      color={0,0,127}));
  connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-130,
          -122},{-106,-122},{-106,-80}},       color={0,127,255}));
  connect(const1.y,CR. u_s) annotation (Line(points={{-181,-76},{-168,-76}},
                                 color={0,0,127}));
  connect(Core_Inlet_T.port_b, core.port_a) annotation (Line(points={{-8,-96},{
          -8,-104},{-52,-104}}, color={0,127,255}));
  connect(Core_Outlet.port_a, core.port_b) annotation (Line(points={{-106,-80},
          {-78,-80},{-78,-104},{-72,-104}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-90},{78,86}}, fileName=
              "modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
end Pebble_Bed_Standalone;
