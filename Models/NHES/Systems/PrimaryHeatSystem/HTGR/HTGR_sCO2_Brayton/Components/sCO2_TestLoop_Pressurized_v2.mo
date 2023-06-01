within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_sCO2_Brayton.Components;
model sCO2_TestLoop_Pressurized_v2
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_sCO2_Brayton_v2 CS,
    redeclare replaceable HTGR_sCO2_Brayton.ED_Dummy ED,
    redeclare Data.Data_HTGR_Pebble data(
      Q_total=600000000,
      Q_total_el=300000000,
      K_P_Release=10000,
      m_flow=296,
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
      HX_Reheat_Buffer_Vol=0.1,
      nPebble=220000));
    Real eff;
  replaceable package Coolant_Medium =
       Modelica.Media.IdealGases.SingleGases.He  constrainedby Modelica.Media.Interfaces.PartialMedium   "Core coolant"                   annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2 "Core fuel material for thermodynamic properties"                                  annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =     Media.Solids.Graphite_5  "Pebble internal material"                         annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

  Data.DataInitial_HTGR_Pebble
                      dataInitial(P_LP_Comp_Ref=4000000)
    annotation (Placement(transformation(extent={{76,120},{96,140}})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase PrimaryHX(
    NTU=8.292,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Coolant_Medium,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=3,
    V_Shell=3,
    p_start_tube=6030000,
    h_start_tube_inlet=3600e3,
    h_start_tube_outlet=2900e3,
    p_start_shell=20170000,
    h_start_shell_inlet=1078600,
    h_start_shell_outlet=1287000,
    dp_init_tube=30000,
    dp_init_shell=600000,
    Q_init=-200e6,
    Cr_init=0.5814,
    m_start_tube=300,
    m_start_shell=2867)
                     annotation (Placement(transformation(
        extent={{-12,14},{12,-14}},
        rotation=270,
        origin={26,0})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    use_m_flow_in=false,
    m_flow=2867,
    T=858.25,
    nPorts=1) annotation (Placement(transformation(extent={{114,8},{94,28}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    h=1148000,
    nPorts=1)
    annotation (Placement(transformation(extent={{118,-49},{98,-29}})));
  Brayton_Systems.Compressor_Controlled Blower(
    redeclare package Medium = Coolant_Medium,
    explicitIsentropicEnthalpy=false,
    pstart_in=5500000,
    Tstart_in=398.15,
    Tstart_out=423.15,
    use_w0_port=true,
    PR0=1.0001,
    w0nom=300) annotation (Placement(transformation(extent={{-14,10},{-34,30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance core_dp(redeclare package Medium = Coolant_Medium, R=1000)
    annotation (Placement(transformation(extent={{-38,-42},{-18,-22}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Coolant_Medium) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-78,16})));

  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{84,60},{96,74}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CoreOutTemp(redeclare package Medium = Coolant_Medium)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-32})));
  Nuclear.CoreSubchannels.Pebble_Bed_New
                                       core(
    redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Material = Media.Solids.Graphite_5,
    redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
            data.r_Pebble, nPebble=data.nPebble),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
    Q_fission_input(displayUnit="MW") = 600000000,
    alpha_fuel=-5e-5,
    alpha_coolant=0.0,
    p_b_start(displayUnit="bar") = 3915000,
    Q_nominal(displayUnit="MW") = 600000000,
    SigmaF_start=26,
    p_a_start(displayUnit="bar") = 3920000,
    T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
    T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
    m_flow_a_start=444,
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
    nParallel=1,
    Fh=1.4,
    n_hot=25,
    Teffref_fuel=1273.15,
    Teffref_coolant=923.15,
    T_inlet=723.15,
    T_outlet=1123.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,-32})));

  GasTurbine.Turbine.Turbine_v2 Turbine(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    pstart_out=8451000,
    Tstart_in=1023.15,
    Tstart_out=908.35,
    eta0=0.9,
    PR0=2.3180688,
    w0=2867)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={70,-52})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CoreInTemp(redeclare package Medium = Coolant_Medium)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-78,-10})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort ShellInSensor(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{80,8},{60,28}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort ShellOutSensor(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
    annotation (Placement(transformation(extent={{32,-44},{52,-24}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort TubeOutSensor( redeclare package Medium = Coolant_Medium) annotation (Placement(transformation(extent={{18,18},
            {-2,38}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Temp(T=733.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-54,54})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=5900000,
    T_start=863.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Coolant_Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-54,28})));
  TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
    redeclare package Medium = Coolant_Medium,
    dp_nominal=100000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={-8,60})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
    redeclare package Medium = Coolant_Medium,
    p=5600000,
    T=863.15,
    nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-7,83})));
  Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=180,
        origin={12,60})));
initial equation

equation
  eff = Turbine.Wt/core.Q_total.y;
  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{30,67},{82.8,67}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(core_dp.port_b, CoreOutTemp.port_a) annotation (Line(points={{-21,-32},{-10,-32}}, color={0,127,255}));
  connect(sensorBus.Core_Outlet_T, CoreOutTemp.T) annotation (Line(
      points={{-30,100},{-30,66},{-94,66},{-94,-74},{0,-74},{0,-35.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower.w0in)
    annotation (Line(
      points={{30,100},{30,44},{-24,44},{-24,28.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,66},{-94,66},{-94,16},{-81.6,16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(core.port_b, core_dp.port_a) annotation (Line(points={{-50,-32},{-35,-32}}, color={0,127,255}));
  connect(Turbine.outlet, boundary1.ports[1]) annotation (Line(points={{80.8,-40.8},{80.8,-40},{98,-40},{98,-39}},         color={0,127,255}));
  connect(core.port_a, CoreInTemp.port_b) annotation (Line(points={{-70,-32},{-78,-32},{-78,-20}},
                                                                                                color={0,127,255}));
  connect(CoreInTemp.port_a, sensor_m_flow.port_b) annotation (Line(points={{-78,0},{-78,6}}, color={0,127,255}));
  connect(ShellInSensor.port_b, PrimaryHX.Shell_in) annotation (Line(points={{60,18},{28.8,18},{28.8,12}},  color={0,127,255}));
  connect(PrimaryHX.Shell_out, ShellOutSensor.port_a) annotation (Line(points={{28.8,-12},{28.8,-34},{32,-34}}, color={0,127,255}));
  connect(ShellOutSensor.port_b, Turbine.inlet) annotation (Line(points={{52,-34},{58,-34},{58,-38},{59.2,-38},{59.2,-40.8}},color={0,127,255}));
  connect(Blower.inlet, TubeOutSensor.port_b) annotation (Line(points={{-18,28},{-2,28}}, color={0,127,255}));
  connect(TubeOutSensor.port_a, PrimaryHX.Tube_out) annotation (Line(points={{18,28},{20,28},{20,12},{20.4,12}},
                                                                                                         color={0,127,255}));
  connect(PrimaryHX.Tube_in, CoreOutTemp.port_b) annotation (Line(points={{20.4,-12},{20.4,-32},{10,-32}},  color={0,127,255}));
  connect(Cooler.heatPort, Temp.port) annotation (Line(points={{-54,34},{-54,44}}, color={191,0,0}));
  connect(Blower.outlet, Cooler.port_b) annotation (Line(points={{-30,28},{-48,28}}, color={0,127,255}));
  connect(Cooler.port_a, sensor_m_flow.port_a) annotation (Line(points={{-60,28},{-78,28},{-78,26}},
                                                                                                  color={0,127,255}));
  connect(ShellInSensor.port_a, boundary2.ports[1]) annotation (Line(points={{80,18},{94,18}}, color={0,127,255}));
  connect(Primary_PRV.port_b, Pressurizer.ports[1]) annotation (Line(points={{-8,68},{-8,76},{-7,76}}, color={0,127,255}));
  connect(Primary_PRV.opening, Thermal_Power1.y) annotation (Line(points={{-1.6,60},{5.4,60}}, color={0,0,127}));
  connect(Primary_PRV.port_a, TubeOutSensor.port_b) annotation (Line(points={{-8,52},{-8,28},{-2,28}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1e6,
      __Dymola_NumberOfIntervals=591,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="esdirk45a"),
    Documentation(info="<html>
    <p>The simple sCO2 Brayton integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </p>
<p>This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </p>
</html>"),
    __Dymola_experimentFlags(Advanced(
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=0.001)));
end sCO2_TestLoop_Pressurized_v2;
