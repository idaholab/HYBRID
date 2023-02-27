within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example_01b
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        Coolant,
    m_flow=2255,
    T=594.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium =
        Coolant,
    p=100000,
    T=1073.15,
    nPorts=1) annotation (Placement(transformation(extent={{106,-10},{86,10}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Coolant)
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  TRANSFORM.Controls.LimPID CR(k=1e-8, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{6,32},{26,52}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=741.483)
    annotation (Placement(transformation(extent={{-32,32},{-12,52}})));
  Nuclear.CoreSubchannels.SFR_Individual_Geometries      coreSubchannel1(
    nAssembliesReg1=11,
    nAssembliesReg2=31,
    nAssembliesReg3=25,
    nAssembliesReg4=60,
    redeclare package Medium = Coolant,
    redeclare package Rods_R1 = Media.Solids.UPu10Zr20,
    redeclare package Rods_R2 = Media.Solids.UPu10Zr20,
    redeclare package Rods_R3 = Media.Solids.UZr20,
    redeclare package Rods_R4 = Media.Solids.UZr20,
    redeclare package Fuel_gap_R1 = Media.Solids.Sodium,
    redeclare model Geometry_R1 = Nuclear.New_Geometries.Generic_SFR (
        nPins=271,
        dimension=0.0054,
        length=1.2,
        angle=pi/2),
    redeclare package Fuel_Cladding_R1 = Media.Solids.HT9,
    R_R3=43,
    R_R1=17,
    R_R2=17,
    R_R4=43,
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    Q_nominal=100000000,
    rho_input=CR.y,
    dBeta=-0.0034,
    alpha_Reg1=-9.22e-4,
    alpha_Reg2=-9.22e-4,
    alpha_Reg3=-1.96e-3,
    alpha_Reg4=-1.2e-3,
    alpha_coolant=0.0,
    Teffref_coolant=648.15,
    p_a_start=170000,
    p_b_start=160000,
    T_a_start=595.15,
    T_b_start=743.15)
             annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,0})));

equation
  connect(boundary1.ports[1], sensor_T.port_b)
    annotation (Line(points={{86,0},{26,0}}, color={0,127,255}));
  connect(sensor_T.T, CR.u_m)
    annotation (Line(points={{16,3.6},{16,30}}, color={0,0,127}));
  connect(CR.u_s, realExpression.y)
    annotation (Line(points={{4,42},{-11,42}}, color={0,0,127}));
  connect(coreSubchannel1.port_b, sensor_T.port_a)
    annotation (Line(points={{-24,0},{6,0}}, color={0,127,255}));
  connect(coreSubchannel1.port_a, boundary.ports[1])
    annotation (Line(points={{-44,0},{-86,0}}, color={0,127,255}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example_01b;
