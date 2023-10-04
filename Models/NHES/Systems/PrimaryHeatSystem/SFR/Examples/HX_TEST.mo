within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model HX_TEST
  package Tube_Medium = NHES.Media.SolarSalt.SolarSalt;
  package Shell_Medium = TRANSFORM.Media.Fluids.Sodium.Sodium_Incompressible;

  Modelica.Units.SI.Power Q_HX;

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        Shell_Medium,
    m_flow=300,
    T=741.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-118,-20},{-98,0}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium =
        Shell_Medium,
    p=100000,
    T=1073.15,
    nPorts=1) annotation (Placement(transformation(extent={{156,-20},{136,0}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium =
        Tube_Medium,
    m_flow=1300,
    T=573.15,
    nPorts=1) annotation (Placement(transformation(extent={{116,-4},{96,16}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium =
        Tube_Medium,
    p=100000,
    T=1073.15,
    nPorts=1) annotation (Placement(transformation(extent={{-102,-4},{-82,16}})));

  Fluid.HeatExchangers.Generic_HXs.UTubeHX heatExchanger(
    redeclare model Geometry =
        NHES.Fluid.HeatExchangers.Utilities.Geometries.UTubeHX (
        nV=6,
        nTubes=1500,
        nR=3,
        dimension_shell=0.04,
        crossArea_shell=1500*2*0.04*0.04,
        length_shell=4.46,
        angle_shell=-pi/2,
        dimension_tube=0.0254,
        length_tube=4.46,
        length_tube_two=22.3),
    redeclare package Medium_shell = Shell_Medium,
    redeclare package Medium_tube = Tube_Medium,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    counterCurrent=false,
    redeclare model FlowModel_shell =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    redeclare model HeatTransfer_tube_one =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare model HeatTransfer_tube_two =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region)
    annotation (Placement(transformation(extent={{60,40},{-24,-28}})));

  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h(redeclare package
      Medium =
        Shell_Medium)
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h1(redeclare package
      Medium =
        Shell_Medium)
    annotation (Placement(transformation(extent={{78,-20},{98,0}})));
equation

  Q_HX = sensor_h.port_a.m_flow*(sensor_h.h_out-sensor_h1.h_out);
  connect(boundary2.ports[1], heatExchanger.port_a_tube) annotation (Line(
        points={{96,6},{60,6}},
        color={0,127,255}));
  connect(heatExchanger.port_b_tube, boundary3.ports[1]) annotation (Line(
        points={{-24,6},{-82,6}}, color={0,127,255}));
  connect(sensor_h.port_a, boundary.ports[1])
    annotation (Line(points={{-70,-10},{-98,-10}}, color={0,127,255}));
  connect(sensor_h.port_b, heatExchanger.port_a_shell)
    annotation (Line(points={{-50,-10},{-24,-9.64}}, color={0,127,255}));
  connect(sensor_h1.port_a, heatExchanger.port_b_shell)
    annotation (Line(points={{78,-10},{60,-9.64}}, color={0,127,255}));
  connect(sensor_h1.port_b, boundary1.ports[1])
    annotation (Line(points={{98,-10},{136,-10}}, color={0,127,255}));
  annotation (                    experiment(StopTime=100000,
        __Dymola_Algorithm="Esdirk45a"));
end HX_TEST;
