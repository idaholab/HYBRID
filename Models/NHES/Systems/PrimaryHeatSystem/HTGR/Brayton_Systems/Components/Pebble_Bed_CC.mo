within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Components;
model Pebble_Bed_CC
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Dummy CS,
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
      HX_Reheat_Shell_Vol=0.1));

  replaceable package Coolant_Medium =
       Modelica.Media.IdealGases.SingleGases.He  constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                          annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

  //Modelica.Units.SI.Power Q_Recup;

    Modelica.Units.SI.Power Q_gen;
    Real cycle_eff;

    Modelica.Units.SI.Power Q_Trans;
    parameter Real eff = 0.9;
  TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
    redeclare package Medium =
        Coolant_Medium,
    p_start=dataInitial.P_Core_Outlet,
    T_start=dataInitial.T_Core_Outlet,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-20})));
  GasTurbine.Turbine.Turbine      turbine(
    redeclare package Medium =
       Coolant_Medium,
    pstart_out=dataInitial.P_Turbine_Ref,
    Tstart_in=dataInitial.TStart_In_Turbine,
    Tstart_out=dataInitial.TStart_Out_Turbine,
    eta0=data.Turbine_Efficiency,
    PR0=data.Turbine_Pressure_Ratio,
    w0=data.Turbine_Nominal_MassFlowRate)
            annotation (Placement(transformation(extent={{-72,-16},{-20,22}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
    NTU=data.HX_Reheat_NTU,
    K_tube=data.HX_Reheat_K_tube,
    K_shell=data.HX_Reheat_K_shell,
    redeclare package Tube_medium =
        Coolant_Medium,
    redeclare package Shell_medium =
        Coolant_Medium,
    V_Tube=data.HX_Reheat_Tube_Vol,
    V_Shell=data.HX_Reheat_Shell_Vol,
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
    annotation (Placement(transformation(extent={{10,-36},{-10,-16}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Coolant_Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={12,-6})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
    redeclare package Medium =
        Coolant_Medium,
    p_start=dataInitial.P_HP_Comp_Ref,
    T_start=data.T_Precooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={26,34})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Precooler_Temp(use_port=
        false, T=data.T_Precooler) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-2,34})));
  GasTurbine.Compressor.Compressor      compressor(
    redeclare package Medium =
        Coolant_Medium,
    pstart_in=dataInitial.P_LP_Comp_Ref,
    Tstart_in=dataInitial.TStart_LP_Comp_In,
    Tstart_out=dataInitial.TStart_LP_Comp_Out,
    eta0=data.LP_Comp_Efficiency,
    PR0=data.LP_Comp_P_Ratio,
    w0=data.LP_Comp_MassFlowRate)
            annotation (Placement(transformation(extent={{40,28},{84,60}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe(
    redeclare package Medium =
        Coolant_Medium,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={84,20})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
    redeclare package Medium =
        Coolant_Medium,
    p_start=dataInitial.P_LP_Comp_Ref,
    T_start=data.T_Intercooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.0),
    use_HeatPort=true,
    Q_gen=-Q_Trans)    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={84,-62})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Intercooler_Temp(use_port=
        false, T=data.T_Intercooler) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-62})));
  GasTurbine.Compressor.Compressor      compressor1(
    redeclare package Medium =
        Coolant_Medium,
    allowFlowReversal=false,
    pstart_in=dataInitial.P_HP_Comp_Ref,
    Tstart_in=dataInitial.TStart_HP_Comp_In,
    Tstart_out=dataInitial.TStart_HP_Comp_Out,
    eta0=data.HP_Comp_Efficiency,
    PR0=data.HP_Comp_P_Ratio,
    w0=data.HP_Comp_MassFlowRate)
            annotation (Placement(transformation(extent={{25,18},{-25,-18}},
        rotation=0,
        origin={-1,-94})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe1(
    redeclare package Medium =
        Coolant_Medium,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-52})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = Coolant_Medium,
    p_spring=data.P_Release,
    K=data.K_P_Release,
    opening_init=0.) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,58})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = Coolant_Medium,
    p=data.P_Release,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={4,86})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
      Medium = Coolant_Medium) annotation (Placement(transformation(
        extent={{-6,8},{6,-8}},
        rotation=180,
        origin={-16,-46})));



  Data.DataInitial_HTGR_Pebble dataInitial
    annotation (PlaceMikkment(transformation(extent={{80,124},{100,144}})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
    shell_av_b=false,
    NTU=1.6,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium =
        Coolant_Medium,
    redeclare package Shell_medium = Aux_Heat_App_Medium,
    V_Tube=3,
    V_Shell=3,
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
        rotation=270,
        origin={-90,20})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Reheat_Waste(
    NTU=10,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium =
        Coolant_Medium,
    redeclare package Shell_medium = Waste_Heat_App_Medium,
    V_Tube=0.1,
    V_Shell=0.1,
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
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={46,-12})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Waste_Heat_Vol(
    redeclare package Medium = Waste_Heat_App_Medium,
    p_start=450000,
    T_start=353.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    Q_gen=Q_Trans) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={66,-58})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
      package Medium = Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={84,-32})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CC_Mid_Temp(redeclare package
      Medium = Waste_Heat_App_Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={66,4})));
  TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package Medium =
        Coolant_Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-68,-58})));
  Modelica.Fluid.Interfaces.FluidPort_a combined_cycle_port_a(redeclare package
      Medium = Waste_Heat_App_Medium)                         annotation (
      Placement(transformation(extent={{22,-110},{42,-90}}),
                                                           iconTransformation(
          extent={{22,-110},{42,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b combined_cycle_port_b(redeclare package
      Medium = Waste_Heat_App_Medium)                         annotation (
      Placement(transformation(extent={{-66,-110},{-46,-90}}),
                                                             iconTransformation(
          extent={{-66,-110},{-46,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a auxiliary_heating_port_a(redeclare
      package Medium =
               Aux_Heat_App_Medium)  annotation (
      Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b auxiliary_heating_port_b(redeclare
      package Medium =
               Aux_Heat_App_Medium)  annotation (
      Placement(transformation(extent={{-110,-56},{-90,-36}}),
                                                             iconTransformation(
          extent={{-110,-56},{-90,-36}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CC_Inlet_Temp(redeclare package
      Medium = Waste_Heat_App_Medium) annotation (Placement(
        transformation(
        extent={{8,7},{-8,-7}},
        rotation=270,
        origin={66,-85})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CC_Outlet_Temp(redeclare package
      Medium = Waste_Heat_App_Medium) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={44,-74})));
  Nuclear.CoreSubchannels.Pebble_Bed_2 core(
    redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Material = NHES.Media.Solids.Graphite_5,
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
    rho_input=CR_reactivity.y,
    redeclare package Medium = Coolant_Medium,
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
    Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,0.04361119,
        0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,0.051676198,0.051725935,
        0.048691804,0.051083234,0.050675546,0.049468838,0.047862888,0.045913065,
        0.041222844,0.038816801,0.035268536,0.029550046,0.022746578,0.011373949},
    Fh=1.4,
    n_hot=25,
    Teffref_fuel=1273.15,
    Teffref_coolant=923.15,
    T_inlet=723.15,
    T_outlet=1123.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-46})));

  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a annotation (
      Placement(transformation(extent={{90,10},{110,30}}),
        iconTransformation(extent={{90,10},{110,30}})));
  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{74,78},{86,92}})));
  TRANSFORM.Blocks.RealExpression PR_Compressor
    annotation (Placement(transformation(extent={{74,66},{86,80}})));
  Modelica.Blocks.Sources.RealExpression Core_M_flow(y=core.port_a.m_flow)
    annotation (Placement(transformation(extent={{-60,104},{-48,118}})));
initial equation
  Q_Trans = 1e7;
equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
 Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
 cycle_eff = Q_gen / core.Q_total.y;

 der(Q_Trans) =eff*min(abs(Intercooler_Pre_Temp.port_a.m_flow*
    Coolant_Medium.specificHeatCapacityCp(Coolant_Medium.setState_pT(
    Intercooler_Pre_Temp.port_a.p, Intercooler_Pre_Temp.T))*(
    Intercooler_Pre_Temp.T - CC_Inlet_Temp.T)), abs(CC_Inlet_Temp.port_a.m_flow*
    (CC_Inlet_Temp.Medium.specificEnthalpy_pT(CC_Inlet_Temp.port_a.p,
    Intercooler_Pre_Temp.T) - CC_Inlet_Temp.Medium.specificEnthalpy_pT(CC_Inlet_Temp.port_a.p,
    CC_Inlet_Temp.T)))) - Q_Trans;
    port_a.W = Q_gen;
  connect(Precooler.heatPort, Precooler_Temp.port)
    annotation (Line(points={{20,34},{8,34}}, color={191,0,0}));
  connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{26,40},{
          26,56},{48,56},{48,56.8},{48.8,56.8}},
                                        color={0,127,255}));
  connect(Intercooler.heatPort, Intercooler_Temp.port)
    annotation (Line(points={{90,-62},{100,-62}}, color={191,0,0}));
  connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
        points={{-16,-108.4},{-16,-116},{-74,-116},{-74,-72},{20,-72},{20,-62}},
                                                                     color={0,
          127,255}));
  connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{84,-68},
          {84,-118},{14,-118},{14,-108.4}},
                                        color={0,127,255}));
  connect(springBallValve.port_b,boundary5. ports[1])
    annotation (Line(points={{4,68},{4,76}},              color={0,127,255}));
  connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{4,48},{
          4,44},{26,44},{26,40}},                 color={0,127,255}));
  connect(Reheater.Shell_in, transportDelayPipe1.port_b)
    annotation (Line(points={{10,-28},{20,-28},{20,-42}},
                                                      color={0,127,255}));
  connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{-10,-28},
          {-10,-46}},                                color={0,127,255}));
  connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-30.4,18.2},
          {-30.4,18},{-12,18},{-12,-22},{-10,-22}},
                                              color={0,127,255}));
  connect(Reheater.Tube_out, sensor_T.port_a)
    annotation (Line(points={{10,-22},{26,-22},{26,-16},{12,-16}},
                                                       color={0,127,255}));
  connect(Core_Outlet.port_b, Steam_Offtake.Tube_in) annotation (Line(points={{-68,-14},
          {-86,-14},{-86,10}},                        color={0,127,255}));
  connect(Steam_Offtake.Tube_out, turbine.inlet) annotation (Line(points={{-86,30},
          {-86,34},{-60,34},{-60,20},{-61.6,20},{-61.6,18.2}},
                                    color={0,127,255}));
  connect(Steam_Reheat_Waste.Tube_in, sensor_T.port_b)
    annotation (Line(points={{42,-22},{42,-26},{28,-26},{28,8},{12,8},{12,4}},
                                               color={0,127,255}));
  connect(Steam_Reheat_Waste.Tube_out, Precooler.port_a) annotation (Line(
        points={{42,-2},{42,20},{26,20},{26,28}}, color={0,127,255}));
  connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{75.2,
          56.8},{74,56.8},{74,58},{84,58},{84,30}},
                                            color={0,127,255}));
  connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
      Line(points={{84,10},{84,-22}},                    color={0,127,255}));
  connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
    annotation (Line(points={{84,-56},{84,-42}}, color={0,127,255}));
  connect(Waste_Heat_Vol.port_b, CC_Mid_Temp.port_a) annotation (Line(points={{66,-52},
          {66,-8},{80,-8},{80,4},{76,4}},
                                      color={0,0,0}));
  connect(CC_Mid_Temp.port_b, Steam_Reheat_Waste.Shell_in) annotation (Line(
        points={{56,4},{48,4},{48,-2}},                color={0,0,0}));
  connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-68,-48},
          {-68,-26}},                          color={0,127,255}));
  connect(auxiliary_heating_port_a, Steam_Offtake.Shell_in) annotation (Line(
        points={{-100,60},{-86,60},{-86,36},{-92,36},{-92,30}},
        color={0,0,0}));
  connect(Steam_Offtake.Shell_out, auxiliary_heating_port_b) annotation (Line(
        points={{-92,10},{-92,-46},{-100,-46}},
        color={0,0,0}));
  connect(combined_cycle_port_a, CC_Inlet_Temp.port_a) annotation (Line(points={{32,-100},
          {32,-86},{54,-86},{54,-96},{66,-96},{66,-93}}, color={0,0,0}));
  connect(CC_Inlet_Temp.port_b, Waste_Heat_Vol.port_a)
    annotation (Line(points={{66,-77},{66,-64}},color={0,0,0}));
  connect(Steam_Reheat_Waste.Shell_out, CC_Outlet_Temp.port_a)
    annotation (Line(points={{48,-22},{48,-26},{54,-26},{54,-74}},
                                                          color={0,0,0}));
  connect(CC_Outlet_Temp.port_b, combined_cycle_port_b) annotation (Line(points={{34,-74},
          {-38,-74},{-38,-84},{-56,-84},{-56,-100}},
                                         color={0,0,0}));
  connect(core.port_a, Core_Inlet_T.port_b) annotation (Line(points={{-30,-46},{
          -22,-46}},                      color={0,127,255}));
  connect(core.port_b, Core_Outlet.port_a) annotation (Line(points={{-50,-46},{-68,
          -46},{-68,-26}},
                 color={0,127,255}));
  connect(combined_cycle_port_b, combined_cycle_port_b)
    annotation (Line(points={{-56,-100},{-56,-100}}, color={0,127,255}));
  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{66,100},{66,85},{72.8,85}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, Core_Outlet_T.T) annotation (Line(
      points={{-30,100},{-30,74},{-114,74},{-114,-60},{-82,-60},{-82,-58},{-74,-58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.PR_Compressor, PR_Compressor.u) annotation (Line(
      points={{30,100},{30,73},{72.8,73}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Core_Mass_Flow, Core_M_flow.y) annotation (Line(
      points={{-30,100},{-47.4,111}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-92},{78,84}}, fileName=
              "modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>The core model used here is the current pebble bed model that uses TRISO structured fuel. </p>
<p>Five ports allow this model to be interconnected to outside components. There are four fluid ports and one electrical port. The electrical port should be connected to some grid or electrical distribution model. </p>
<p>Two ports on the side of the model are used for a thermal application by removing heat from the Helium coolant upstream of the turbine. Note that this is not a bypass flow as it has been in steam systems, although that may be used in the future (the system should be evaluated to determine which method is more efficient). </p>
<p>The two fluid ports on the bottom of the model feed and remove the combined cycle fluid (nominally steam). The combined cycle heat removal is calculated upstream of the intercooler and precooler. This means that the intercooler and precooler temperatures continue to dictate system temperatures. </p>
<p>The system has only been tested (as of March 2022) with Helium coolant, but any gas package should operate properly. </p>
<p>A breakdown of the components: </p>
<p>The core model is effectively a replaceable heat source. The default is a pebble bed system, and a prismatic fuel model will be forthcoming. </p>
<p>The turbine model uses inputs from the data structure to describe its size and efficiency characteristics. </p>
<p>The recuperating heat exchanger is of NTU type. There is no description in the literature to describe the actual geometry of a recuperating heat exchanger of this size. The NTU HX is used for simulation speed, and the NTU value describes the effective size of that heat exchanger. </p>
<p>The precooler and intercooler are named to match the diagram included in the documentation of the overall Brayton_Systems package. The boundary conditions applied there dictate the fluid flow temperatures. In the future, a heat exchanger to evaluate the necessary cooling requirements could replace these boundary conditions. </p>
<p>The compression of the Helium is split into two stages, each coming immediately after a cooling stage. </p>
<p>It is necessary to have pressure relief within the system. In this model, this is done via a spring valve that opens just upstream of the first compressor. </p>
</html>"));
end Pebble_Bed_CC;
