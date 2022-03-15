within NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses;
model TRISO_Core_In_Progress
  replaceable package Coolant = Modelica.Media.Water.StandardWater;
  NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.TRISO fuelModel(
    nParallel=2.5e9,
      n_Power_Region=4, redeclare package Fuel_Kernel_Material =
        TRANSFORM.Media.Solids.UO2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const[fuelModel.n_Power_Region](k=150e6)
    annotation (Placement(transformation(extent={{-68,-8},{-48,12}})));
  NHES.Fluid.Pipes.StraightPipe    coolantSubchannel(
    use_HeatTransfer=true,
    isCircular=false,
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    p_a_start=5100000,
    p_b_start=5000000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    diameter=1,
    perimeter=0.001*1000000,
    roughness=1e-4,
    length=10,
    nParallel=1,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    allowFlowReversal=true,
    redeclare model FlowModel =
        NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    redeclare model HeatTransfer =
        NHES.Fluid.Pipes.BaseClasses.HeatTransfer.DittusBoelter,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nV=fuelModel.n_Power_Region,
    height_a=0,
    dheight=-6,
    useLumpedPressure=false,
    useInnerPortProperties=true,
    use_Ts_start=true,
    T_a_start=923.15,
    T_b_start=1123.15,
    m_flow_a_start=boundary.m_flow)
      annotation (Placement(transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={38,-38})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    m_flow=305,
    T=923.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-50,-48},{-30,-28}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    p=5000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{108,-48},{88,-28}})));
equation
  connect(fuelModel.Power_in, const.y)
    annotation (Line(points={{-11,0},{-30,0},{-30,2},{-47,2}},
                                               color={0,0,127}));
  connect(coolantSubchannel.heatPorts, fuelModel.heatPorts_b) annotation (Line(
        points={{38.15,-32.28},{38.15,-16},{38,-16},{38,2},{10.2,2},{10.2,0.1}},
        color={127,0,0}));
  connect(coolantSubchannel.port_a, boundary.ports[1])
    annotation (Line(points={{23,-38},{-30,-38}}, color={0,127,255}));
  connect(coolantSubchannel.port_b, boundary1.ports[1])
    annotation (Line(points={{53,-38},{88,-38}}, color={0,127,255}));
  annotation ();
end TRISO_Core_In_Progress;
