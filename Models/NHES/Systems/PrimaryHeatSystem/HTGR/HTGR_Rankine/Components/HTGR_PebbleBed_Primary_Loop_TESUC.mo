within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components;
model HTGR_PebbleBed_Primary_Loop_TESUC
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable ControlSystems.CS_Rankine_Primary CS,
    redeclare replaceable ED_Dummy ED,
    redeclare replaceable Data.Data_HTGR_Pebble data(
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
      HX_Reheat_Buffer_Vol=0.1,
      nPebble=220000));
  input Modelica.Units.SI.Pressure input_steam_pressure;
  replaceable package Coolant_Medium =
       Modelica.Media.IdealGases.SingleGases.He  constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

  //Modelica.Units.SI.Power Q_Recup;

  replaceable Data.DataInitial_HTGR_Pebble
                      dataInitial(P_LP_Comp_Ref=4000000)
    annotation (Placement(transformation(extent={{78,120},{98,140}})));

  TRANSFORM.Blocks.RealExpression CR_reactivity
    annotation (Placement(transformation(extent={{90,84},{102,98}})));

  Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
    annotation (Placement(transformation(extent={{-150,72},{-138,86}})));
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

  Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
    annotation (Placement(transformation(extent={{-92,98},{-80,112}})));
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
    Q_fission_input(displayUnit="MW") = 100000000,
    alpha_fuel=-5e-5,
    alpha_coolant=0.0,
    p_b_start(displayUnit="bar") = 3915000,
    Q_nominal(displayUnit="MW") = 125000000,
    SigmaF_start=26,
    p_a_start(displayUnit="bar") = 3920000,
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
    nParallel=1,
    Fh=1.4,
    n_hot=25,
    Teffref_fuel=1273.15,
    Teffref_coolant=923.15,
    T_inlet=723.15,
    T_outlet=1123.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-78,38})));

  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
      = Coolant_Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-78,-2})));
  Brayton_Systems.Compressor_Controlled compressor_Controlled(
    redeclare package Medium = Coolant_Medium,
    explicitIsentropicEnthalpy=false,
    pstart_in=3910000,
    pstart_out=3920000,
    Tstart_in=398.15,
    Tstart_out=423.15,
    use_w0_port=true,
    PR0=1.05,
    w0nom=300)
    annotation (Placement(transformation(extent={{-44,-24},{-64,-4}})));
  TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    dp_nominal=100000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-42,-56})));
  Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-42,-79})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=4000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium
      = Coolant_Medium) annotation (Placement(transformation(
        extent={{-5,-7},{5,7}},
        rotation=270,
        origin={-39,63})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    nParallel=3,
    redeclare model FlowModel_shell =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,

    p_b_start_shell=3910000,
    p_a_start_tube=14100000,
    p_b_start_tube=14000000,
    use_Ts_start_tube=true,
    T_a_start_tube=481.15,
    T_b_start_tube=813.15,
    h_a_start_tube=500e3,
    h_b_start_tube=2e3,
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,

    p_a_start_shell=3915000,
    T_a_start_shell=1023.15,
    T_b_start_shell=523.15,
    m_flow_a_start_shell=50,
    m_flow_a_start_tube=100,
    redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_i_shell(displayUnit="m") = 0.011,
        D_o_shell=0.022,
        crossAreaEmpty_shell=5000*0.01,
        length_shell=60,
        nTubes=5000,
        nV=4,
        dimension_tube(displayUnit="mm") = 0.0254,
        length_tube=360,
        th_wall=0.003,
        nR=3),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare package Medium_shell = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={29,18})));

initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
      points={{-30,100},{-74,100},{-74,105},{-79.4,105}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
          {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
  connect(compressor_Controlled.outlet,sensor_m_flow. port_a)
    annotation (Line(points={{-60,-6},{-62,-6},{-62,-2},{-68,-2}},
                                                          color={0,127,255},
      thickness=0.5));
  connect(compressor_Controlled.inlet,STHX. port_b_shell) annotation (Line(
        points={{-48,-6},{22,-6},{22,2},{23.94,2},{23.94,6}},
                                                      color={0,127,255}));
  connect(Primary_PRV.port_a,compressor_Controlled. inlet) annotation (Line(
        points={{-34,-56},{-28,-56},{-28,-38},{-38,-38},{-38,-26},{-40,-26},{
          -40,-6},{-48,-6}},
                           color={0,127,255}));
  connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
          -72.4},{-42,-62.4}},        color={0,0,127}));
  connect(Primary_PRV.port_b,boundary1. ports[1])
    annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                   color={0,127,255}));
  connect(sensor_T.port_b,STHX. port_a_shell) annotation (Line(points={{-39,58},
          {-39,34},{23.94,34},{23.94,30}},  color={0,127,255}));
  connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
          80},{-39,80},{-39,68}},
                              color={0,127,255}));
  connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
      points={{-30,100},{-30,63},{-36.48,63}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(STHX.port_a_tube, port_a) annotation (Line(points={{29,6},{29,-24},{
          36,-24},{36,-33},{97,-33}}, color={0,127,255}));
  connect(STHX.port_b_tube, port_b) annotation (Line(points={{29,30},{28,30},{
          28,49},{97,49}}, color={0,127,255}));
  connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
      Line(
      points={{30,100},{114,100},{114,-100},{-108,-100},{-108,-2},{-54,-2},{-54,
          -5.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
      points={{-30,100},{-74,100},{-74,79},{-137.4,79}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
end HTGR_PebbleBed_Primary_Loop_TESUC;
