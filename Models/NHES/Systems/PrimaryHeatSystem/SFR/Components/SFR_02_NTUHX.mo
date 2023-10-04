within NHES.Systems.PrimaryHeatSystem.SFR.Components;
model SFR_02_NTUHX
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable
      NHES.Systems.PrimaryHeatSystem.SFR.CS.CS_01 CS, redeclare Data.Data_Dummy
      data);
    replaceable package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT
    constrainedby Modelica.Media.Interfaces.PartialMedium              annotation(choicesAllMatching=true);
    replaceable package Medium_IHX_Loop =
      TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                                                  annotation(choicesAllMatching=true);

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium
      = Coolant)
    annotation (Placement(transformation(extent={{-6,46},{14,66}})));
  TRANSFORM.Blocks.RealExpression CR
    annotation (Placement(transformation(extent={{88,92},{102,108}})));
  Nuclear.CoreSubchannels.SFR      coreSubchannel1(
    nAssembliesIF=11,
    nAssembliesOF=31,
    nAssembliesIRB=25,
    nAssembliesRB=60,
    redeclare package Medium = Coolant,
    redeclare package Rods_IF = Media.Solids.UPu10Zr20,
    redeclare package Rods_OF = Media.Solids.UPu10Zr20,
    redeclare package Rods_IRB = Media.Solids.UZr20,
    redeclare package Rods_RB = Media.Solids.UZr20,
    redeclare package Fuel_gap_material = Media.Solids.Sodium,
    redeclare package Fuel_Cladding = Media.Solids.HT9,
    redeclare model Geometry = NHES.Nuclear.New_Geometries.Generic_SFR (
        nPins=271,
        dimension=0.0074,
        length=1.20,
        angle=pi/2),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    Q_nominal=100000000,
    rho_input=CR.y,
    dBeta=-0.0034,
    alpha_IF=-9.22e-4,
    alpha_OF=-9.22e-4,
    alpha_IRB=-1.96e-3,
    alpha_RB=-1.2e-3,
    alpha_coolant=0.0,
    Teffref_fuel_IF=873.15,
    Teffref_fuel_OF=873.15,
    Teffref_fuel_IRB=873.15,
    Teffref_fuel_RB=873.15,
    Teffref_coolant=648.15,
    T_Gap_Init=773.15,
    T_Clad_Init=673.15,
    p_a_start=170000,
    p_b_start=160000,
    T_a_start=595.15,
    T_b_start=743.15,
    internal_blanket_in_design=true,
    R_IRB=43,
    R_IF=17,
    R_OF=17,
    R_RB=43) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-62,0})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_Outlet_Riser(
    redeclare package Medium = Coolant,
    p_a_start=160000,
    p_b_start=110000,
    T_a_start=743.15,
    T_b_start=743.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=4.0,
        length=10,
        angle=pi/2,
        nV=2),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-64,40})));
  TRANSFORM.Fluid.Volumes.ExpansionTank hot_plenum(
    redeclare package Medium = Coolant,
    A=75,
    V0=75*3,
    p_surface=100000,
    p_start=100000,
    level_start=0.0,
    h_start=300e3)
    annotation (Placement(transformation(extent={{34,52},{54,72}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium = Coolant,
    p_a_start=120000,
    p_b_start=110000,
    T_a_start=743.15,
    T_b_start=743.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=4.0,
        length=3.78,
        angle=-pi/2,
        nV=2),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={52,16})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                           IHX(
    tube_av_b=false,
    shell_av_b=false,
    NTU=4.8,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Medium_IHX_Loop,
    redeclare package Shell_medium = Coolant,
    V_Tube=17.84,
    V_Shell=17.84,
    dh_Shell=-4.46,
    use_T_start_tube=true,
    T_start_tube_inlet=493.15,
    T_start_tube_outlet=673.15,
    p_start_shell=110000,
    use_T_start_shell=true,
    T_start_shell_inlet=873.15,
    T_start_shell_outlet=723.15,
    Q_init=400000000)                        annotation (Placement(
        transformation(
        extent={{16,15},{-16,-15}},
        rotation=90,
        origin={55,-26})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe2(
    redeclare package Medium = Coolant,
    p_a_start=110000,
    p_b_start=100000,
    T_a_start=593.15,
    T_b_start=593.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=4.0,
        length=3.78,
        angle=-pi/2,
        nV=2),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={52,-78})));
  TRANSFORM.Fluid.Volumes.SimpleVolume  cold_plenum(
    redeclare package Medium = Coolant,
    p_start=100000,
    T_start=593.15,
    h_start=300e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=75))
    annotation (Placement(transformation(extent={{-8,-104},{12,-84}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Coolant,
    nParallel=1,
    dp_nominal=100000,
    m_flow_nominal=2550,
    use_port=true)
    annotation (Placement(transformation(extent={{-34,-84},{-54,-104}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface core_inlet(
    redeclare package Medium = Coolant,
    p_a_start=160000,
    p_b_start=110000,
    T_a_start=595.15,
    T_b_start=595.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=4.0,
        length=1.0,
        angle=pi/2,
        nV=2),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-62,-40})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium
      = Coolant)
    annotation (Placement(transformation(extent={{18,-84},{38,-104}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate       sensor_m_flow(redeclare package
      Medium = Coolant)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-62,-70})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium_IHX_Loop)                                                                       annotation (Placement(
        transformation(extent={{86,-48},{108,-26}}), iconTransformation(extent={
            {86,-48},{108,-26}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium_IHX_Loop)                                                                        annotation (Placement(
        transformation(extent={{86,34},{108,56}}), iconTransformation(extent={{86,
            34},{108,56}})));
equation
  connect(actuatorBus.CR_Reactivity, CR.u) annotation (Line(
      points={{30,100},{86.6,100}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_Temp, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,72},{4,72},{4,59.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_T.port_a, Core_Outlet_Riser.port_b)
    annotation (Line(points={{-6,56},{-64,56},{-64,50}}, color={0,127,255}));
  connect(coreSubchannel1.port_b, Core_Outlet_Riser.port_a) annotation (Line(
        points={{-62,10},{-62,26},{-64,26},{-64,30}},     color={0,127,255}));
  connect(sensor_T.port_b, hot_plenum.port_a) annotation (Line(points={{14,56},
          {37,56}},                color={0,127,255}));
  connect(hot_plenum.port_b, pipe1.port_a) annotation (Line(points={{51,56},{52,
          56},{52,26}},              color={0,127,255}));
  connect(cold_plenum.port_a, pump.port_a)
    annotation (Line(points={{-4,-94},{-34,-94}}, color={0,127,255}));
  connect(coreSubchannel1.port_a, core_inlet.port_b)
    annotation (Line(points={{-62,-10},{-62,-30}}, color={0,127,255}));
  connect(actuatorBus.Pump_Speed, pump.inputSignal) annotation (Line(
      points={{30,100},{32,100},{32,88},{104,88},{104,-128},{-36,-128},{-36,-101},
          {-44,-101}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pipe2.port_b, sensor_T1.port_b)
    annotation (Line(points={{52,-88},{52,-94},{38,-94}}, color={0,127,255}));
  connect(sensor_T1.port_a, cold_plenum.port_b)
    annotation (Line(points={{18,-94},{8,-94}},  color={0,127,255}));
  connect(sensorBus.IHX_Outlet_Temp, sensor_T1.T) annotation (Line(
      points={{-30,100},{-88,100},{-88,-112},{28,-112},{28,-97.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(IHX.Shell_in, pipe1.port_b) annotation (Line(points={{52,-10},{52,6}},
                       color={0,127,255}));
  connect(IHX.Shell_out, pipe2.port_a) annotation (Line(points={{52,-42},{52,-68}},
                              color={0,127,255}));
  connect(pump.port_b, sensor_m_flow.port_a) annotation (Line(points={{-54,-94},
          {-62,-94},{-62,-80}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, core_inlet.port_a)
    annotation (Line(points={{-62,-60},{-62,-50}}, color={0,127,255}));
  connect(sensorBus.PrimaryMassFlow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-62,100},{-62,104},{-88,104},{-88,-70},{-65.6,-70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_a, IHX.Tube_in) annotation (Line(points={{97,-37},{70,-37},{70,-50},
          {61,-50},{61,-42}}, color={0,127,255}));
  connect(IHX.Tube_out, port_b) annotation (Line(points={{61,-10},{62,-10},{62,
          2},{74,2},{74,46},{97,46},{97,45}},
                                            color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-58,44},{64,-36}},
          textColor={28,108,200},
          textString="SFR")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=15,
      __Dymola_Algorithm="Esdirk45a"));
end SFR_02_NTUHX;
