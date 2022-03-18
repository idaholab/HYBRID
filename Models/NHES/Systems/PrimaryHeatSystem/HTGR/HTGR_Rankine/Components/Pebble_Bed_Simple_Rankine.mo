within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components;
model Pebble_Bed_Simple_Rankine
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Rankine CS,
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
       Modelica.Media.IdealGases.SingleGases.He  constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                              "Core coolant"                   annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2 "Core fuel material for thermodynamic properties"                                  annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =     Media.Solids.Graphite_5  "Pebble internal material"                         annotation(dialog(group = "Media"),choicesAllMatching=true);
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
    annotation (Placement(transformation(extent={{80,124},{100,144}})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
    NTU=1.25,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium =
        Coolant_Medium,
    redeclare package Shell_medium = Aux_Heat_App_Medium,
    V_Tube=3,
    V_Shell=3,
    p_start_tube=6030000,
    h_start_tube_inlet=3600e3,
    h_start_tube_outlet=2900e3,
    p_start_shell=1000000,
    h_start_shell_inlet=600e3,
    h_start_shell_outlet=1000e3,
    dp_init_tube=30000,
    dp_init_shell=40000,
    Q_init=-100000000,
    Cr_init=0.8,
    m_start_tube=300,
    m_start_shell=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,8})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Aux_Heat_App_Medium,
    use_m_flow_in=false,
    m_flow=55,
    T=353.15,
    nPorts=1) annotation (Placement(transformation(extent={{-58,38},{-38,58}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Aux_Heat_App_Medium,
    p=8000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-106,-44},{-86,-24}})));
  Brayton_Systems.Compressor_Controlled compressor_Controlled(
    redeclare package Medium = Coolant_Medium,
    explicitIsentropicEnthalpy=false,
    pstart_in=5500000,
    Tstart_in=398.15,
    Tstart_out=423.15,
    use_w0_port=true,
    PR0=1.05,
    w0nom=300) annotation (Placement(transformation(extent={{40,14},{60,34}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Coolant_Medium,
      R=1000)
    annotation (Placement(transformation(extent={{50,-50},{30,-30}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={88,-8})));
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
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,-42})));

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
    p_outlet_nominal=8000,
    T_nominal=673.15)
    annotation (Placement(transformation(extent={{-8,-50},{-28,-30}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{-76,-80},{-96,-60}})));
  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{84,76},{96,90}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={14,-42})));
initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
  eff = steamTurbine.Q_mech/core.Q_total.y;
  connect(boundary2.ports[1], Steam_Offtake.Shell_in) annotation (Line(points={
          {-38,48},{-14,48},{-14,18},{-2,18}}, color={0,127,255}));
  connect(compressor_Controlled.inlet, Steam_Offtake.Tube_out) annotation (Line(
        points={{44,32},{4,32},{4,18}},                                  color=
          {0,127,255}));
  connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{88,-18},
          {88,-42},{74,-42}},   color={0,127,255}));
  connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
    annotation (Line(points={{56,32},{56,38},{88,38},{88,2}},
                                                          color={0,127,255}));
  connect(resistance.port_a, core.port_b)
    annotation (Line(points={{47,-40},{50,-40},{50,-42},{54,-42}},
                                                   color={0,127,255}));
  connect(boundary1.ports[1], steamTurbine.portLP)
    annotation (Line(points={{-86,-34},{-28,-34}}, color={0,127,255}));
  connect(steamTurbine.portHP, Steam_Offtake.Shell_out)
    annotation (Line(points={{-8,-34},{-2,-34},{-2,-2}}, color={0,127,255}));
  connect(generator.shaft, steamTurbine.shaft_b) annotation (Line(points={{-75.9,
          -70.1},{-28,-70.1},{-28,-40},{-28,-40}}, color={0,0,0}));
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
    annotation (Line(points={{33,-40},{28,-40},{28,-42},{24,-42}},
                                                 color={0,127,255}));
  connect(sensor_T.port_b, Steam_Offtake.Tube_in)
    annotation (Line(points={{4,-42},{2,-42},{2,-6},{4,-6},{4,-2}},
                                                       color={0,127,255}));
  connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
      points={{-30,100},{100,100},{100,-54},{14,-54},{14,-45.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
      Line(
      points={{30,100},{30,84},{50,84},{50,32.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{100,100},{100,-8},{91.6,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>The simple Rankine integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </p>
<p>This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </p>
</html>"));
end Pebble_Bed_Simple_Rankine;
