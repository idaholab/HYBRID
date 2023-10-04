within NHES.Systems.PrimaryHeatSystem.SFR.Components;
model SFR_02
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable
      NHES.Systems.PrimaryHeatSystem.SFR.CS.CS_01 CS, redeclare Data.Data_Dummy
      data);
    package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;

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
    Q_nominal=400000000,
    rho_input=CR.y,
    dBeta=-0.0034,
    alpha_IF=-9.22e-4,
    alpha_OF=-9.22e-4,
    alpha_IRB=-1.96e-3,
    alpha_RB=-1.2e-3,
    alpha_coolant=0.0,
    T_Gap_Init=773.15,
    T_Clad_Init=673.15,
    p_a_start=170000,
    p_b_start=160000,
    T_a_start=623.15,
    T_b_start=973.15,
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
    T_a_start=873.15,
    T_b_start=873.15,
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
    annotation (Placement(transformation(extent={{34,62},{54,82}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium = Coolant,
    p_a_start=160000,
    p_b_start=110000,
    T_a_start=873.15,
    T_b_start=873.15,
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
        origin={52,32})));
  Fluid.HeatExchangers.Generic_HXs.UTubeHX IHX(
    redeclare model Geometry =
        NHES.Fluid.HeatExchangers.Utilities.Geometries.UTubeHX (
        nV=6,
        nTubes=2500,
        nR=3,
        dimension_shell=0.04,
        crossArea_shell=0.04*0.04*5000,
        length_shell=4.46,
        angle_shell=-pi/2,
        dimension_tube=0.0254,
        length_tube=4.6,
        angle_tube=-pi/2,
        length_tube_two=13.38,
        angle_tube_two=-0.0059312729818504),
    redeclare package Medium_shell = Coolant,
    redeclare package Medium_tube =
        Coolant,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304_TRACE,
    counterCurrent=false,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
    redeclare model HeatTransfer_tube_one =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
    redeclare model HeatTransfer_tube_two =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple)
                                             annotation (Placement(
        transformation(
        extent={{-16,-15},{16,15}},
        rotation=90,
        origin={59,-24})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe2(
    redeclare package Medium = Coolant,
    p_a_start=160000,
    p_b_start=110000,
    T_a_start=873.15,
    T_b_start=873.15,
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
        origin={48,-78})));
  TRANSFORM.Fluid.Volumes.ExpansionTank cold_plenum(
    redeclare package Medium = Coolant,
    A=75,
    V0=75*3,
    p_surface=100000,
    p_start=100000,
    level_start=0.0,
    h_start=300e3)
    annotation (Placement(transformation(extent={{-6,-98},{14,-78}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Coolant,
    dp_nominal=100000,
    m_flow_nominal=2550,
    use_port=true)
    annotation (Placement(transformation(extent={{-34,-84},{-54,-104}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface core_inlet(
    redeclare package Medium = Coolant,
    p_a_start=160000,
    p_b_start=110000,
    T_a_start=873.15,
    T_b_start=873.15,
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
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Coolant,
    m_flow=2255,
    T=594.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{150,-68},{130,-48}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Coolant,
    p=100000,
    T=1073.15,
    nPorts=1) annotation (Placement(transformation(extent={{140,6},{120,26}})));
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
  connect(sensor_T.port_b, hot_plenum.port_a) annotation (Line(points={{14,56},{
          30,56},{30,66},{37,66}}, color={0,127,255}));
  connect(hot_plenum.port_b, pipe1.port_a) annotation (Line(points={{51,66},{50,
          66},{50,46},{52,46},{52,42}},
                                     color={0,127,255}));
  connect(pipe1.port_b, IHX.port_a_shell) annotation (Line(points={{52,22},{52.1,
          -8}},                          color={0,127,255}));
  connect(IHX.port_b_shell, pipe2.port_a) annotation (Line(points={{52.1,-40},{52.1,
          -62},{48,-62},{48,-68}},
                              color={0,127,255}));
  connect(cold_plenum.port_a, pump.port_a)
    annotation (Line(points={{-3,-94},{-34,-94}}, color={0,127,255}));
  connect(coreSubchannel1.port_a, core_inlet.port_b)
    annotation (Line(points={{-62,-10},{-62,-30}}, color={0,127,255}));
  connect(pump.port_b, core_inlet.port_a) annotation (Line(points={{-54,-94},{-62,
          -94},{-62,-50}}, color={0,127,255}));
  connect(actuatorBus.Pump_Speed, pump.inputSignal) annotation (Line(
      points={{30,100},{32,100},{32,88},{104,88},{104,-128},{-36,-128},{-36,-101},
          {-44,-101}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pipe2.port_b, sensor_T1.port_b)
    annotation (Line(points={{48,-88},{48,-94},{38,-94}}, color={0,127,255}));
  connect(sensor_T1.port_a, cold_plenum.port_b)
    annotation (Line(points={{18,-94},{11,-94}}, color={0,127,255}));
  connect(sensorBus.IHX_Outlet_Temp, sensor_T1.T) annotation (Line(
      points={{-30,100},{-66,100},{-66,98},{-112,98},{-112,-112},{28,-112},{28,-97.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(boundary.ports[1], IHX.port_a_tube) annotation (Line(points={{130,-58},
          {98,-58},{98,-52},{59,-52},{59,-40}}, color={0,127,255}));
  connect(boundary1.ports[1], IHX.port_b_tube) annotation (Line(points={{120,16},
          {66,16},{66,-8},{59,-8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=15,
      __Dymola_Algorithm="Esdirk45a"));
end SFR_02;
