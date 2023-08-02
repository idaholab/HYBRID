within NHES.Fluid.HeatExchangers.Generic_HXs.Examples;
model UTubeExample
  extends Modelica.Icons.Example;
  UTubeHX heatExchanger(
    redeclare model Geometry =
        NHES.Fluid.HeatExchangers.Utilities.Geometries.UTubeHX (
        nV=6,
        nTubes=1,
        nR=3,
        dimension_shell=0.04,
        length_shell=10,
        dimension_tube=0.0254,
        length_tube=15,
        length_tube_two=10),
    redeclare package Medium_shell =
        Modelica.Media.IdealGases.SingleGases.He,
    redeclare package Medium_tube =
        Modelica.Media.IdealGases.SingleGases.He,
    redeclare package Material_tubeWall =
        TRANSFORM.Media.Solids.SS304,
    counterCurrent=false,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (nSurfaces=2),
    redeclare model FlowModel_tube =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
        (nFM=geometry.nV),
    redeclare model HeatTransfer_tube_one =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare model HeatTransfer_tube_two =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    p_a_start_shell=3010000,
    p_b_start_shell=3000000,
    T_a_start_shell=673.15,
    T_b_start_shell=698.15,
    m_flow_a_start_shell=0.2,
    p_a_start_tube=4010000,
    p_b_start_tube=4000000,
    T_a_start_tube=1123.15,
    T_b_start_tube=1073.15,
    m_flow_a_start_tube=0.2)
    annotation (Placement(transformation(extent={{-32,-26},{52,42}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow=0.2,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,-2},{-78,18}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow=0.2,
    T=1123.15,
    nPorts=1) annotation (Placement(transformation(extent={{126,14},{106,34}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    p=3000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-104,40},{-84,60}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    p=4000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{134,-10},{114,10}})));
equation
  connect(heatExchanger.port_a_tube, boundary.ports[1])
    annotation (Line(points={{-32,8},{-78,8}}, color={0,127,255}));
  connect(heatExchanger.port_a_shell, boundary1.ports[1]) annotation (Line(
        points={{52,23.64},{80,23.64},{80,24},{106,24}}, color={0,127,255}));
  connect(heatExchanger.port_b_tube, boundary3.ports[1]) annotation (Line(
        points={{52,8},{108,8},{108,0},{114,0}}, color={0,127,255}));
  connect(heatExchanger.port_b_shell, boundary2.ports[1]) annotation (Line(
        points={{-32,23.64},{-48,23.64},{-48,26},{-60,26},{-60,50},{-84,50}},
        color={0,127,255}));
end UTubeExample;
