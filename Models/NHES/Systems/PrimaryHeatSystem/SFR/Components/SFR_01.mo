within NHES.Systems.PrimaryHeatSystem.SFR.Components;
model SFR_01
    extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_01 CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_Dummy data);
    package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Coolant,
    m_flow=2255,
    T=594.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,-50},{-92,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Coolant,
    p=100000,
    T=1073.15,
    nPorts=1) annotation (Placement(transformation(extent={{146,-50},{126,-30}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Coolant)
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
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
    redeclare model Geometry =
        NHES.Nuclear.New_Geometries.Generic_SFR (
        nPins=271,
        dimension=0.0074,
        length=1.19),
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
    R_RB=43) annotation (Placement(transformation(extent={{-54,-50},{-34,-30}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe(
    redeclare package Medium = Coolant,
    p_a_start=160000,
    p_b_start=110000,
    T_a_start=873.15,
    T_b_start=873.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=4.0,
        length=4.0,
        angle=pi/2,
        nV=2),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL)
    annotation (Placement(transformation(extent={{-4,-50},{16,-30}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank(
    redeclare package Medium = Coolant,
    A=75,
    V0=75*3,
    p_surface=100000,
    p_start=100000,
    level_start=0.0,
    h_start=300e3)
    annotation (Placement(transformation(extent={{72,-46},{92,-26}})));
equation
  connect(actuatorBus.CR_Reactivity, CR.u) annotation (Line(
      points={{30,100},{86.6,100}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_Temp, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,74},{40,74},{40,-36.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(boundary.ports[1], coreSubchannel1.port_a)
    annotation (Line(points={{-92,-40},{-54,-40}}, color={0,127,255}));
  connect(sensor_T.port_a, pipe.port_b)
    annotation (Line(points={{30,-40},{16,-40}}, color={0,127,255}));
  connect(coreSubchannel1.port_b, pipe.port_a)
    annotation (Line(points={{-34,-40},{-4,-40}}, color={0,127,255}));
  connect(sensor_T.port_b, tank.port_a) annotation (Line(points={{50,-40},{68,-40},
          {68,-42},{75,-42}}, color={0,127,255}));
  connect(tank.port_b, boundary1.ports[1])
    annotation (Line(points={{89,-42},{89,-40},{126,-40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=15,
      __Dymola_Algorithm="Esdirk45a"));
end SFR_01;
