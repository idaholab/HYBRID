within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components;
model HTGR_PebbleBed_Primary_Loop
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Rankine_Primary CS,
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
  input Modelica.Units.SI.Pressure input_steam_pressure;
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
    annotation (Placement(transformation(extent={{32,-40},{12,-60}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Coolant_Medium,
      R=1000)
    annotation (Placement(transformation(extent={{-8,32},{4,46}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-22,-34})));
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
        origin={-38,14})));

  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{90,84},{102,98}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(
        extent={{-5,-7},{5,7}},
        rotation=270,
        origin={53,35})));

  Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
    annotation (Placement(transformation(extent={{-92,84},{-80,98}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
                        annotation (Placement(
        transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
            {86,-44},{108,-22}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
                        annotation (Placement(
        transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
            38},{108,60}})));
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
    redeclare package Medium_shell = Coolant_Medium)
                        annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={63,-4})));

  Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
    annotation (Placement(transformation(extent={{-94,98},{-82,112}})));
initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

  connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-32,-34},
          {-38,-34},{-38,4}},   color={0,127,255},
      thickness=0.5));
  connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
    annotation (Line(points={{16,-58},{16,-34},{-12,-34}},color={0,127,255},
      thickness=0.5));
  connect(resistance.port_a, core.port_b)
    annotation (Line(points={{-6.2,39},{-38,39},{-38,24}},
                                                   color={0,127,255},
      thickness=0.5));
  connect(resistance.port_b, sensor_T.port_a)
    annotation (Line(points={{2.2,39},{42,39},{42,44},{53,44},{53,40}},
                                                 color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
      points={{-30,100},{64,100},{64,35},{55.52,35}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
      Line(
      points={{30,100},{110,100},{110,-68},{22,-68},{22,-58.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,82},{-74,82},{-74,-48},{-22,-48},{-22,-37.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_b, STHX.port_b_tube) annotation (Line(points={{97,49},{84,49},{84,
          14},{60,14},{60,8},{63,8}}, color={0,127,255}));
  connect(port_a, STHX.port_a_tube)
    annotation (Line(points={{97,-33},{63,-33},{63,-16}}, color={0,127,255}));
  connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
        points={{57.94,-16},{56,-16},{56,-58},{28,-58}}, color={0,127,255}));
  connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{57.94,8},
          {58,8},{58,28},{53,28},{53,30}}, color={0,127,255}));
  connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
      points={{-30,100},{-74,100},{-74,105},{-81.4,105}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, Thermal_Power.y) annotation (Line(
      points={{-30,100},{-74,100},{-74,91},{-79.4,91}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=30,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>The primary side of a HTGR reactor with a heat exchanger set up to send heat to a Rankine cycle to produce electricity. The pebble bed reactor core used is the same as in the Brayton cycle reactor style. </p>
<p>This model is used in the third example in this package. As it is taken from the Rankine_Complex model, that model should be used as a reference. </p>
</html>"));
end HTGR_PebbleBed_Primary_Loop;
