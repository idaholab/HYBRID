within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components;
model HTGR_PebbleBed_Primary_Loop_HeOut
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
    annotation (Placement(transformation(extent={{-98,82},{-86,96}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
            {86,-44},{108,-22}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Coolant_Medium) annotation (Placement(
        transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
            38},{108,60}})));

  Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
    annotation (Placement(transformation(extent={{-98,108},{-86,122}})));
  Nuclear.CoreSubchannels.Pebble_Bed_New
                                       core(
    nV=8,
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
    SF_start_power={0.15,0.15,0.125,0.125,0.125,0.125,0.1,0.1},
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

  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Coolant_Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-78,-2})));
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
    use_T_in=true,
    p=4000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Coolant_Medium) annotation (Placement(transformation(
        extent={{-5,-7},{5,7}},
        rotation=270,
        origin={-39,63})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium =
        Coolant_Medium) annotation (Placement(transformation(
        extent={{-5,-7},{5,7}},
        rotation=180,
        origin={7,-15})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Coolant_Medium,
    use_input=true,     m_flow_nominal=57)
    annotation (Placement(transformation(extent={{-32,-14},{-52,6}})));
initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

  connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
      points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,115},{-85.4,115}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
          {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
  connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
          -72.4},{-42,-62.4}},        color={0,0,127}));
  connect(Primary_PRV.port_b,boundary1. ports[1])
    annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                   color={0,127,255}));
  connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
          80},{-39,80},{-39,68}},
                              color={0,127,255}));
  connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
      points={{-30,100},{-30,63},{-36.48,63}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(boundary1.T_in, sensor_T1.T) annotation (Line(points={{-96,-54},{-124,
          -54},{-124,-92},{7,-92},{7,-17.52}}, color={0,0,127}));
  connect(port_a, sensor_T1.port_a)
    annotation (Line(points={{97,-33},{97,-15},{12,-15}}, color={0,127,255}));
  connect(sensor_T.port_b, port_b) annotation (Line(points={{-39,58},{-40,58},{-40,
          49},{97,49}}, color={0,127,255}));
  connect(pump.port_a, sensor_T1.port_b) annotation (Line(points={{-32,-4},{-18,
          -4},{-18,-15},{2,-15}}, color={0,127,255}));
  connect(pump.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{-52,-4},{-52,-2},{-68,-2}}, color={0,127,255}));
  connect(Primary_PRV.port_a, sensor_T1.port_b) annotation (Line(points={{-34,
          -56},{-16,-56},{-16,-40},{2,-40},{2,-15}}, color={0,127,255}));
  connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,89},{-85.4,89}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.mfeedpump, pump.in_m_flow) annotation (Line(
      points={{30,100},{30,10},{-42,10},{-42,3.3}},
      color={111,216,99},
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
end HTGR_PebbleBed_Primary_Loop_HeOut;
