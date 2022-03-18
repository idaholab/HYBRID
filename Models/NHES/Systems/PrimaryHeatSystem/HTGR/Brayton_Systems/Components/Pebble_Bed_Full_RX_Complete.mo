within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Components;
model Pebble_Bed_Full_RX_Complete
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
      Modelica.Media.IdealGases.SingleGases.He                                    constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                                              annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                      annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                             annotation(choicesAllMatching = true, dialog(group = "Media"));

  //Modelica.Units.SI.Power Q_Recup;
    package Medium =
      Modelica.Media.IdealGases.SingleGases.He;
    Modelica.Units.SI.Power Q_gen;
    Real cycle_eff;

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
        origin={-66,-26})));

  GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium =
        Coolant_Medium,
    pstart_out=dataInitial.P_Turbine_Ref,
    Tstart_in=dataInitial.TStart_In_Turbine,
    Tstart_out=dataInitial.TStart_Out_Turbine,
    eta0=data.Turbine_Efficiency,
    PR0=data.Turbine_Pressure_Ratio,
    w0=data.Turbine_Nominal_MassFlowRate)
    annotation (Placement(transformation(extent={{-80,46},{-16,0}})));

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
    annotation (Placement(transformation(extent={{18,-18},{-2,2}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Coolant_Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,10})));
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
        origin={38,38})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary3(use_port=
        false, T=data.T_Precooler)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={2,36})));
  GasTurbine.Compressor.Compressor compressor(
    redeclare package Medium =
        Coolant_Medium,
    pstart_in=dataInitial.P_LP_Comp_Ref,
    Tstart_in=dataInitial.TStart_LP_Comp_In,
    Tstart_out=dataInitial.TStart_LP_Comp_Out,
    eta0=data.LP_Comp_Efficiency,
    PR0=data.LP_Comp_P_Ratio,
    w0=data.LP_Comp_MassFlowRate)
    annotation (Placement(transformation(extent={{54,18},{98,50}})));

  TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
    redeclare package Medium =
        Coolant_Medium,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={100,20})));

  TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
    redeclare package Medium =
        Coolant_Medium,
    p_start=dataInitial.P_LP_Comp_Ref,
    T_start=data.T_Intercooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,-54})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
        false, T=data.T_Intercooler)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={78,-54})));
  GasTurbine.Compressor.Compressor compressor1(
    redeclare package Medium =
        Coolant_Medium,
    allowFlowReversal=false,
    pstart_in=dataInitial.P_HP_Comp_Ref,
    Tstart_in=dataInitial.TStart_HP_Comp_In,
    Tstart_out=dataInitial.TStart_HP_Comp_Out,
    eta0=data.HP_Comp_Efficiency,
    PR0=data.HP_Comp_P_Ratio,
    w0=data.HP_Comp_MassFlowRate) annotation (Placement(transformation(
        extent={{25,-18},{-25,18}},
        rotation=0,
        origin={73,-92})));

  TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe1(
    redeclare package Medium =
        Coolant_Medium,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={56,-38})));

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
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={4,86})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
      Medium = Coolant_Medium) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-8,-42})));

 /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.Coolant_Medium,
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

  Data.DataInitial_HTGR_Pebble dataInitial
    annotation (Placement(transformation(extent={{80,124},{100,144}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
      package Medium = Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={100,-16})));
  TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package Medium =
        Coolant_Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-76,-78})));
  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-8,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-102,-52},{-82,-32}})));
  Modelica.Blocks.Sources.Constant const1(k=850 + 273.15)
    annotation (Placement(transformation(extent={{-136,-52},{-116,-32}})));
  Nuclear.CoreSubchannels.Pebble_Bed_2 core(
    redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Material = Media.Solids.Graphite_5,
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
        origin={-36,-64})));

initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
 Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
 cycle_eff = Q_gen / core.Q_total.y;

  connect(Precooler.heatPort, boundary3.port)
    annotation (Line(points={{32,38},{32,36},{12,36}},
                                              color={191,0,0}));
  connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{38,44},{
          26,44},{26,56},{62.8,56},{62.8,46.8}},
                                        color={0,127,255}));
  connect(Intercooler.heatPort, boundary4.port)
    annotation (Line(points={{94,-54},{88,-54}},       color={191,0,0}));
  connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
        points={{58,-77.6},{58,-52},{56,-52},{56,-48}},              color={0,
          127,255}));
  connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{100,-60},
          {100,-70},{88,-70},{88,-77.6}},
                                        color={0,127,255}));
  connect(springBallValve.port_b,boundary5. ports[1])
    annotation (Line(points={{4,68},{4,76}},              color={0,127,255}));
  connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{4,48},{
          4,44},{38,44}},                         color={0,127,255}));
  connect(Reheater.Shell_in, transportDelayPipe1.port_b)
    annotation (Line(points={{18,-10},{56,-10},{56,-28}},
                                                      color={0,127,255}));
  connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{-2,-10},
          {-8,-10},{-8,-32}},                        color={0,127,255}));
  connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-28.8,4.6},
          {-28.8,-12},{-10,-12},{-10,-4},{-2,-4}},
                                              color={0,127,255}));
  connect(Reheater.Tube_out, sensor_T.port_a)
    annotation (Line(points={{18,-4},{38,-4},{38,0}},  color={0,127,255}));
  connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{89.2,
          46.8},{90,46.8},{90,46},{100,46},{100,30}},
                                            color={0,127,255}));
  connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
      Line(points={{100,10},{100,-6}},                   color={0,127,255}));
  connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
    annotation (Line(points={{100,-48},{100,-26}},
                                                 color={0,127,255}));
  connect(Core_Outlet_T.T,CR. u_m) annotation (Line(points={{-82,-78},{-92,-78},
          {-92,-54}},       color={0,0,127}));
  connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-76,-68},
          {-76,-64},{-66,-64},{-66,-32}},      color={0,127,255}));
  connect(const1.y,CR. u_s) annotation (Line(points={{-115,-42},{-104,-42}},
                                 color={0,0,127}));
  connect(Core_Inlet_T.port_b, core.port_a) annotation (Line(points={{-8,-52},{
          -8,-64},{-26,-64}},   color={0,127,255}));
  connect(Core_Outlet.port_a, core.port_b) annotation (Line(points={{-66,-32},{
          -66,-64},{-46,-64}},              color={0,127,255}));
  connect(Core_Outlet.port_b, turbine.inlet) annotation (Line(points={{-66,-20},
          {-66,0},{-67.2,0},{-67.2,4.6}},
                                       color={0,127,255}));
  connect(sensor_T.port_b, Precooler.port_a)
    annotation (Line(points={{38,20},{38,32}}, color={0,127,255}));
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
<p>This model is self-contained. It is recommended that anyone attempting to modify the HTGR-Brayton system begins by copying this model (including testing new control methods). </p>
<p>The core model used here is the current pebble bed model that uses TRISO structured fuel. </p>
<p>The system has only been tested (as of March 2022) with Helium coolant, but any gas package should operate properly. </p>
<p>A breakdown of the components: </p>
<p>The core model is effectively a replaceable heat source. The default is a pebble bed system, and a prismatic fuel model will be forthcoming. </p>
<p>The turbine model uses inputs from the data structure to describe its size and efficiency characteristics. </p>
<p>The recuperating heat exchanger is of NTU type. There is no description in the literature to describe the actual geometry of a recuperating heat exchanger of this size. The NTU HX is used for simulation speed, and the NTU value describes the effective size of that heat exchanger. </p>
<p>The precooler and intercooler are named to match the diagram included in the documentation of the overall Brayton_Systems package. The boundary conditions applied there dictate the fluid flow temperatures. In the future, a heat exchanger to evaluate the necessary cooling requirements could replace these boundary conditions. </p>
<p>The compression of the Helium is split into two stages, each coming immediately after a cooling stage. </p>
</html>"));
end Pebble_Bed_Full_RX_Complete;
