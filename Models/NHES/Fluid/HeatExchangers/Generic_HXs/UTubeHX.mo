within NHES.Fluid.HeatExchangers.Generic_HXs;
model UTubeHX
  "Built as effectively a new iteration of the Generic_HX in TRANSFORM. Note that the counterCurrent variable refers directly to tube_one and inversely to tube_two. Only the default geometry should be used for this heat exchanger. Tubes are assumed to be constant in number and general values from tube_one to tube_two with exception for the length. The length information should be passed to shell as well for appropriate calculations of the heat transfer area."
  import TRANSFORM.Math.linspace_1D;
  import TRANSFORM.Math.fillArray_1D;
  import TRANSFORM.Math.linspaceRepeat_1D;
  import TRANSFORM.Fluid.Types.LumpedLocation;
  import Modelica.Fluid.Types.Dynamics;
  outer TRANSFORM.Fluid.SystemTF systemTF;
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_tube(redeclare package
      Medium = Medium_tube) annotation (Placement(transformation(extent={{-110,-10},
            {-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b_tube(redeclare package
      Medium = Medium_tube) annotation (Placement(transformation(extent={{90,-10},
            {110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_shell(redeclare package
      Medium = Medium_shell) annotation (Placement(transformation(extent={{90,36},
            {110,56}}), iconTransformation(extent={{90,36},{110,56}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b_shell(redeclare package
      Medium = Medium_shell) annotation (Placement(transformation(extent={{-110,
            36},{-90,56}}), iconTransformation(extent={{-110,36},{-90,56}})));
  parameter Real nParallel=1 "# of identical parallel HXs";
  replaceable model Geometry =
      Utilities.Geometries.UTubeHX
    constrainedby TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.GenericHX
    "Geometry" annotation (choicesAllMatching=true);
  replaceable package Medium_shell =
      Modelica.Media.Interfaces.PartialMedium
    "Shell side medium" annotation (choicesAllMatching=true);
  replaceable package Medium_tube = Modelica.Media.Interfaces.PartialMedium
    "Tube side medium" annotation (choicesAllMatching=true);
  replaceable package Material_tubeWall =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Tube wall material" annotation (
      choicesAllMatching=true);
  parameter Boolean counterCurrent=true
    "Swap shell side temperature and flux vector order";
  replaceable model FlowModel_shell =
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
    constrainedby TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
    "Shell side flow models (i.e., momentum, pressure loss, wall friction)"
    annotation (choicesAllMatching=true, Dialog(group="Pressure Loss"));
  replaceable model HeatTransfer_shell =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
    constrainedby TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
    "Shell side coefficient of heat transfer" annotation (choicesAllMatching=true,
      Dialog(group="Heat Transfer"));
  replaceable model FlowModel_tube =
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
    constrainedby TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
    "Tube side flow models (i.e., momentum, pressure loss, wall friction)"
    annotation (choicesAllMatching=true, Dialog(group="Pressure Loss"));
  replaceable model HeatTransfer_tube_one =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
    constrainedby TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
    "Tube side coefficient of heat transfer" annotation (choicesAllMatching=true,
      Dialog(group="Heat Transfer"));
        replaceable model HeatTransfer_tube_two =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal constrainedby
    TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
    "Tube side coefficient of heat transfer" annotation (choicesAllMatching=
        true, Dialog(group="Heat Transfer"));
  // Shell Initialization
  parameter SI.AbsolutePressure[geometry.nV] ps_start_shell=linspace_1D(
      p_a_start_shell,
      p_b_start_shell,
      geometry.nV) "Pressure" annotation (Dialog(tab="Shell Initialization",
        group="Start Value: Absolute Pressure"));
  parameter SI.AbsolutePressure p_a_start_shell=Medium_shell.p_default
    "Pressure at port a" annotation (Dialog(tab="Shell Initialization", group="Start Value: Absolute Pressure"));
  parameter SI.AbsolutePressure p_b_start_shell= p_a_start_shell + (if m_flow_a_start_shell > 0 then -1e3 elseif m_flow_a_start_shell < 0 then -1e3 else 0)
    "Pressure at port b" annotation (Dialog(tab="Shell Initialization", group="Start Value: Absolute Pressure"));
  parameter Boolean use_Ts_start_shell=true
    "Use T_start if true, otherwise h_start" annotation (Evaluate=true, Dialog(
        tab="Shell Initialization", group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_shell[geometry.nV]=linspace_1D(
      T_a_start_shell,
      T_b_start_shell,
      geometry.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Shell Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_shell));
  parameter SI.Temperature T_a_start_shell=Medium_shell.T_default
    "Temperature at port a" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_shell));
  parameter SI.Temperature T_b_start_shell=T_a_start_shell
    "Temperature at port b" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_shell));
  parameter SI.SpecificEnthalpy[geometry.nV] hs_start_shell=if not
      use_Ts_start_shell then linspace_1D(
      h_a_start_shell,
      h_b_start_shell,
      geometry.nV) else {Medium_shell.specificEnthalpy_pTX(
      ps_start_shell[i],
      Ts_start_shell[i],
      Xs_start_shell[i, 1:Medium_shell.nX]) for i in 1:geometry.nV}
    "Specific enthalpy" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_shell));
  parameter SI.SpecificEnthalpy h_a_start_shell=
      Medium_shell.specificEnthalpy_pTX(
      p_a_start_shell,
      T_a_start_shell,
      X_a_start_shell) "Specific enthalpy at port a" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_shell));
  parameter SI.SpecificEnthalpy h_b_start_shell=
      Medium_shell.specificEnthalpy_pTX(
      p_b_start_shell,
      T_b_start_shell,
      X_b_start_shell) "Specific enthalpy at port b" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_shell));
  parameter SI.MassFraction Xs_start_shell[geometry.nV,Medium_shell.nX]=
      linspaceRepeat_1D(
      X_a_start_shell,
      X_b_start_shell,
      geometry.nV) "Mass fraction" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Species Mass Fraction",
      enable=Medium_shell.nXi > 0));
  parameter SI.MassFraction X_a_start_shell[Medium_shell.nX]=Medium_shell.X_default
    "Mass fraction at port a" annotation (Dialog(tab="Shell Initialization",
        group="Start Value: Species Mass Fraction"));
  parameter SI.MassFraction X_b_start_shell[Medium_shell.nX]=X_a_start_shell
    "Mass fraction at port b" annotation (Dialog(tab="Shell Initialization",
        group="Start Value: Species Mass Fraction"));
  parameter TRANSFORM.Units.ExtraProperty Cs_start_shell[geometry.nV,
    Medium_shell.nC]=linspaceRepeat_1D(
      C_a_start_shell,
      C_b_start_shell,
      geometry.nV) "Mass-Specific value" annotation (Dialog(
      tab="Shell Initialization",
      group="Start Value: Trace Substances",
      enable=Medium_shell.nC > 0));
  parameter TRANSFORM.Units.ExtraProperty C_a_start_shell[Medium_shell.nC]=fill(
       0, Medium_shell.nC) "Mass-Specific value at port a" annotation (Dialog(
        tab="Shell Initialization", group="Start Value: Trace Substances"));
  parameter TRANSFORM.Units.ExtraProperty C_b_start_shell[Medium_shell.nC]=
      C_a_start_shell "Mass-Specific value at port b" annotation (Dialog(tab="Shell Initialization",
        group="Start Value: Trace Substances"));
  parameter SI.MassFlowRate[geometry.nV + 1] m_flows_start_shell=linspace(
      m_flow_a_start_shell,
      -m_flow_b_start_shell,
      geometry.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(tab="Shell Initialization",
        group="Start Value: Mass Flow Rate"));
  parameter SI.MassFlowRate m_flow_a_start_shell=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Shell Initialization", group="Start Value: Mass Flow Rate"));
  parameter SI.MassFlowRate m_flow_b_start_shell=-m_flow_a_start_shell
    "Mass flow rate at port_b" annotation (Dialog(tab="Shell Initialization",
        group="Start Value: Mass Flow Rate"));
  // Tube Initialization
  parameter SI.AbsolutePressure[geometry.nV] ps_start_tube_one=linspace_1D(
      p_a_start_tube,
      0.5*p_b_start_tube+0.5*p_a_start_tube,
      geometry.nV) "Pressure" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Absolute Pressure"));
          parameter SI.AbsolutePressure[geometry.nV] ps_start_tube_two=linspace_1D(
      0.5*p_b_start_tube+0.5*p_a_start_tube, p_b_start_tube,
      geometry.nV) "Pressure" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Absolute Pressure"));

  parameter SI.AbsolutePressure p_a_start_tube=Medium_tube.p_default
    "Pressure at port a" annotation (Dialog(tab="Tube Initialization", group="Start Value: Absolute Pressure"));
  parameter SI.AbsolutePressure p_b_start_tube= p_a_start_tube + (if m_flow_a_start_tube > 0 then -1e3 elseif m_flow_a_start_tube < 0 then -1e3 else 0)
    "Pressure at port b" annotation (Dialog(tab="Tube Initialization", group="Start Value: Absolute Pressure"));
  parameter Boolean use_Ts_start_tube=true
    "Use T_start if true, otherwise h_start" annotation (Evaluate=true, Dialog(
        tab="Tube Initialization", group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_tube_one[geometry.nV]=linspace_1D(
      T_a_start_tube,
      0.5*T_a_start_tube+0.5*T_b_start_tube,
      geometry.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Tube Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_tube));
  parameter SI.Temperature Ts_start_tube_two[geometry.nV]=linspace_1D(
      0.5*T_a_start_tube+0.5*T_b_start_tube, T_b_start_tube,
      geometry.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Tube Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_tube));

  parameter SI.Temperature T_a_start_tube=Medium_tube.T_default
    "Temperature at port a" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_tube));
  parameter SI.Temperature T_b_start_tube=T_a_start_tube
    "Temperature at port b" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start_tube));
  parameter SI.SpecificEnthalpy[geometry.nV] hs_start_tube_one=if not
      use_Ts_start_tube then linspace_1D(
      h_a_start_tube,
      0.5*h_a_start_tube+0.5*h_b_start_tube,
      geometry.nV) else {Medium_tube.specificEnthalpy_pTX(
      ps_start_tube_one[i],
      Ts_start_tube_one[i],
      Xs_start_tube[i, 1:Medium_tube.nX]) for i in 1:geometry.nV}
    "Specific enthalpy" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_tube));
        parameter SI.SpecificEnthalpy[geometry.nV] hs_start_tube_two=if not
      use_Ts_start_tube then linspace_1D(
      0.5*h_a_start_tube+0.5*h_b_start_tube,
      h_b_start_tube,
      geometry.nV) else {Medium_tube.specificEnthalpy_pTX(
      ps_start_tube_two[i],
      Ts_start_tube_two[i],
      Xs_start_tube[i, 1:Medium_tube.nX]) for i in 1:geometry.nV}
    "Specific enthalpy" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_tube));
  parameter SI.SpecificEnthalpy h_a_start_tube=Medium_tube.specificEnthalpy_pTX(
      p_a_start_tube,
      T_a_start_tube,
      X_a_start_tube) "Specific enthalpy at port a" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_tube));
  parameter SI.SpecificEnthalpy h_b_start_tube=Medium_tube.specificEnthalpy_pTX(
      p_b_start_tube,
      T_b_start_tube,
      X_b_start_tube) "Specific enthalpy at port b" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start_tube));
  parameter SI.MassFraction Xs_start_tube[geometry.nV,Medium_tube.nX]=
      linspaceRepeat_1D(
      X_a_start_tube,
      X_b_start_tube,
      geometry.nV) "Mass fraction" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Species Mass Fraction",
      enable=Medium_tube.nXi > 0));
  parameter SI.MassFraction X_a_start_tube[Medium_tube.nX]=Medium_tube.X_default
    "Mass fraction at port a" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Species Mass Fraction"));
  parameter SI.MassFraction X_b_start_tube[Medium_tube.nX]=X_a_start_tube
    "Mass fraction at port b" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Species Mass Fraction"));
  parameter TRANSFORM.Units.ExtraProperty Cs_start_tube[geometry.nV,Medium_tube.nC]=
     linspaceRepeat_1D(
      C_a_start_tube,
      C_b_start_tube,
      geometry.nV) "Mass-Specific value" annotation (Dialog(
      tab="Tube Initialization",
      group="Start Value: Trace Substances",
      enable=Medium_tube.nC > 0));
  parameter TRANSFORM.Units.ExtraProperty C_a_start_tube[Medium_tube.nC]=fill(0,
      Medium_tube.nC) "Mass-Specific value at port a" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Trace Substances"));
  parameter TRANSFORM.Units.ExtraProperty C_b_start_tube[Medium_tube.nC]=
      C_a_start_tube "Mass-Specific value at port b" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Trace Substances"));
  parameter SI.MassFlowRate[geometry.nV + 1] m_flows_start_tube=linspace(
      m_flow_a_start_tube,
      -m_flow_b_start_tube,
      geometry.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(tab="Tube Initialization",
        group="Start Value: Mass Flow Rate"));
  parameter SI.MassFlowRate m_flow_a_start_tube=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Tube Initialization", group="Start Value: Mass Flow Rate"));
  parameter SI.MassFlowRate m_flow_b_start_tube=-m_flow_a_start_tube
    "Mass flow rate at port_b" annotation (Dialog(tab="Tube Initialization",
        group="Start Value: Mass Flow Rate"));
  // Tube Wall Initialization
  parameter SI.Temperature Ts_wall_start_one[geometry.nR,geometry.nV]=
     linspaceRepeat_1D(
      Ts_wall_start_tubeSide_one,
      if counterCurrent then Modelica.Math.Vectors.reverse(
        Ts_wall_start_shellSide) else Ts_wall_start_shellSide,
      geometry.nR) "Tube wall temperature" annotation (Dialog(tab="Wall Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_wall_start_two[geometry.nR,geometry.nV]=
     linspaceRepeat_1D(
      Ts_wall_start_tubeSide_two,
      if not counterCurrent then Modelica.Math.Vectors.reverse(
        Ts_wall_start_shellSide) else Ts_wall_start_shellSide,
      geometry.nR) "Tube wall temperature" annotation (Dialog(tab="Wall Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_wall_start_tubeSide_one[geometry.nV]=
      Medium_tube.temperature_phX(
      ps_start_tube_one,
      hs_start_tube_one,
      Xs_start_tube) "Tube side wall temperature" annotation (Dialog(tab="Wall Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_wall_start_tubeSide_two[geometry.nV]=
      Medium_tube.temperature_phX(
      ps_start_tube_two,
      hs_start_tube_two,
      Xs_start_tube) "Tube side wall temperature" annotation (Dialog(tab="Wall Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_wall_start_shellSide[geometry.nV]=
      Medium_shell.temperature_phX(
      ps_start_shell,
      hs_start_shell,
      Xs_start_shell) "Shell side wall temperature" annotation (Dialog(tab="Wall Initialization",
        group="Start Value: Temperature"));
  // Advanced
  parameter Modelica.Fluid.Types.Dynamics energyDynamics[3]={Dynamics.DynamicFreeInitial,
      Dynamics.DynamicFreeInitial,Dynamics.DynamicFreeInitial}
    "Formulation of energy balances {shell,tube,tubeWall}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics[2]=energyDynamics[1:2]
    "Formulation of mass balances {shell,tube}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics traceDynamics[2]=massDynamics
    "Formulation of trace substance balances {shell,tube}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics[2]={Dynamics.SteadyState,
      Dynamics.SteadyState} "Formulation of momentum balances {shell,tube}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Boolean allowFlowReversal_shell=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Advanced", group="Shell Side"));
  parameter Boolean exposeState_a_shell=true
    "=true, p is calculated at port_a else m_flow"
    annotation (Dialog(tab="Advanced", group="Shell Side"));
  parameter Boolean exposeState_b_shell=false
    "=true, p is calculated at port_b else m_flow"
    annotation (Dialog(tab="Advanced", group="Shell Side"));
  parameter Boolean useLumpedPressure_shell=false
    "=true to lump pressure states together"
    annotation (Dialog(tab="Advanced", group="Shell Side"), Evaluate=true);
  parameter LumpedLocation lumpPressureAt_shell=LumpedLocation.port_a
    "Location of pressure for flow calculations" annotation (Dialog(
      tab="Advanced",
      group="Shell Side",
      enable=if useLumpedPressure_shell and not exposeState_a_shell and not exposeState_b_shell then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties_shell=false
    "=true to take port properties for flow models from internal control volumes"
    annotation (Dialog(tab="Advanced", group="Shell Side"), Evaluate=true);
  parameter Boolean allowFlowReversal_tube=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Advanced", group="Tube Side"));
  parameter Boolean exposeState_a_tube=true
    "=true, p is calculated at port_a else m_flow"
    annotation (Dialog(tab="Advanced", group="Tube Side"));
  parameter Boolean exposeState_b_tube=false
    "=true, p is calculated at port_b else m_flow"
    annotation (Dialog(tab="Advanced", group="Tube Side"));
  parameter Boolean useLumpedPressure_tube=false
    "=true to lump pressure states together"
    annotation (Dialog(tab="Advanced", group="Tube Side"), Evaluate=true);
  parameter LumpedLocation lumpPressureAt_tube=LumpedLocation.port_a
    "Location of pressure for flow calculations" annotation (Dialog(
      tab="Advanced",
      group="Tube Side",
      enable=if useLumpedPressure_tube and not exposeState_a_tube and not exposeState_b_tube then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties_tube=false
    "=true to take port properties for flow models from internal control volumes"
    annotation (Dialog(tab="Advanced", group="Tube Side"), Evaluate=true);
  parameter Boolean adiabaticDims[2]={false,false}
    "=true, toggle off conduction heat transfer in dimension {1,2}"
    annotation (Dialog(tab="Advanced", group="Tube Wall"));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.CounterFlow counterFlow(
      counterCurrent=counterCurrent, n=geometry.nV) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-16})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface shell(
    redeclare package Medium = Medium_shell,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = HeatTransfer_shell,
    use_Ts_start=use_Ts_start_shell,
    p_a_start=p_a_start_shell,
    p_b_start=p_b_start_shell,
    T_a_start=T_a_start_shell,
    T_b_start=T_b_start_shell,
    h_a_start=h_a_start_shell,
    h_b_start=h_b_start_shell,
    ps_start=ps_start_shell,
    hs_start=hs_start_shell,
    Ts_start=Ts_start_shell,
    nParallel=nParallel,
    Ts_wall(start=transpose(TRANSFORM.Math.fillArray_1D(Ts_wall_start_shellSide,
          geometry.nSurfaces_shell))),
    redeclare model FlowModel = FlowModel_shell,
    energyDynamics=energyDynamics[1],
    massDynamics=massDynamics[1],
    traceDynamics=traceDynamics[1],
    exposeState_a=exposeState_a_shell,
    exposeState_b=exposeState_b_shell,
    momentumDynamics=momentumDynamics[1],
    useInnerPortProperties=useInnerPortProperties_shell,
    useLumpedPressure=useLumpedPressure_shell,
    lumpPressureAt=lumpPressureAt_shell,
    m_flow_a_start=m_flow_a_start_shell,
    m_flow_b_start=m_flow_b_start_shell,
    m_flows_start=m_flows_start_shell,
    Xs_start=Xs_start_shell,
    Cs_start=Cs_start_shell,
    X_a_start=X_a_start_shell,
    X_b_start=X_b_start_shell,
    C_a_start=C_a_start_shell,
    C_b_start=C_b_start_shell,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe (
        nV=geometry.nV,
        crossAreas=geometry.crossAreas_shell,
        perimeters=geometry.perimeters_shell,
        dlengths=geometry.dlengths_shell,
        roughnesses=geometry.roughnesses_shell,
        surfaceAreas=geometry.surfaceAreas_shell,
        dheights=geometry.dheights_shell,
        height_a=geometry.height_a_shell,
        dimensions=geometry.dimensions_shell,
        nSurfaces=geometry.nSurfaces_shell,
        angles=geometry.angles_shell),
    redeclare model InternalHeatGen = InternalHeatGen_shell,
    redeclare model InternalTraceGen = InternalTraceGen_shell) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,46})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWall             tube_one(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wall.StraightPipe (
        dimension=geometry.dimension_tube,
        crossArea=geometry.crossArea_tube,
        perimeter=geometry.perimeter_tube,
        length=geometry.length_tube,
        roughness=geometry.roughness_tube,
        angle=geometry.angle_tube,
        dheight=geometry.dheight_tube,
        nV=geometry.nV,
        nSurfaces=geometry.nSurfaces_tube,
        height_a=geometry.height_a_tube,
        nR=geometry.nR,
        th_wall=geometry.th_wall),
    redeclare package Medium = Medium_tube,
    redeclare package Material = Material_tubeWall,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = HeatTransfer_tube_one,
    use_Ts_start=true,
    p_a_start=p_a_start_tube,
    p_b_start=0.5*p_a_start_tube + 0.5*p_b_start_tube,
    T_a_start=T_a_start_tube,
    T_b_start=0.5*T_a_start_tube + 0.5*T_b_start_tube,
    h_a_start=h_a_start_tube,
    h_b_start=0.5*h_a_start_tube + 0.5*h_b_start_tube,
    ps_start=ps_start_tube_one,
    hs_start=hs_start_tube_one,
    Ts_start=Ts_start_tube_one,
    redeclare model FlowModel = FlowModel_tube,
    nParallel=geometry.nTubes*nParallel,
    energyDynamics=energyDynamics[2],
    massDynamics=massDynamics[2],
    traceDynamics=traceDynamics[2],
    exposeState_a=exposeState_a_tube,
    exposeState_b=exposeState_b_tube,
    momentumDynamics=momentumDynamics[2],
    useInnerPortProperties=useInnerPortProperties_tube,
    useLumpedPressure=useLumpedPressure_tube,
    lumpPressureAt=lumpPressureAt_tube,
    m_flow_a_start=m_flow_a_start_tube,
    m_flow_b_start=m_flow_b_start_tube,
    m_flows_start=m_flows_start_tube,
    Xs_start=Xs_start_tube,
    Cs_start=Cs_start_tube,
    X_a_start=X_a_start_tube,
    X_b_start=X_b_start_tube,
    C_a_start=C_a_start_tube,
    C_b_start=C_b_start_tube,
    redeclare model InternalHeatGen = InternalHeatGen_tube,
    use_HeatTransferOuter=true,
    T_a1_start=T_a_start_tube,
    T_b1_start=T_a_start_tube,
    T_a2_start=T_a_start_tube,
    T_b2_start=T_a_start_tube,
    exposeState_outerWall=false)                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,-80})));

  replaceable model InternalTraceGen_tube =
      TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
    annotation (Dialog(group="Trace Mass Transfer"),choicesAllMatching=true);
  replaceable model InternalTraceGen_shell =
      TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
    annotation (Dialog(group="Trace Mass Transfer"),choicesAllMatching=true);
  replaceable model InternalHeatGen_tube =
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
      annotation (Dialog(group="Heat Transfer"),choicesAllMatching=true);
  replaceable model InternalHeatGen_shell =
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
      annotation (Dialog(group="Heat Transfer"),choicesAllMatching=true);

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.CounterFlow counterFlow1(
      counterCurrent=not (counterCurrent),                   n=geometry.nV)
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,-16})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWall tube_two(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wall.StraightPipe (
        dimension=geometry.dimension_tube,
        crossArea=geometry.crossArea_tube,
        perimeter=geometry.perimeter_tube,
        length=geometry.length_tube_two,
        roughness=geometry.roughness_tube,
        angle=geometry.angle_tube_two,
        dheight=geometry.dheight_tube_two,
        nV=geometry.nV,
        nSurfaces=geometry.nSurfaces_tube,
        nR=geometry.nR,
        th_wall=geometry.th_wall),
    nParallel=nParallel,
    redeclare package Medium = Medium_tube,
    ps_start=ps_start_tube_two,
    Ts_start=Ts_start_tube_two,
    hs_start=hs_start_tube_two,
    Xs_start=Xs_start_tube,
    Cs_start=Cs_start_tube,
    p_a_start=0.5*p_a_start_tube + 0.5*p_b_start_tube,
    p_b_start=p_b_start_tube,
    T_a_start=0.5*T_a_start_tube + 0.5*T_b_start_tube,
    T_b_start=T_b_start_tube,
    h_a_start=h_a_start_tube*0.5 + 0.5*h_b_start_tube,
    h_b_start=h_b_start_tube,
    X_a_start=X_a_start_tube,
    X_b_start=X_b_start_tube,
    C_a_start=C_a_start_tube,
    C_b_start=C_b_start_tube,
    m_flow_a_start=m_flow_a_start_tube,
    m_flow_b_start=m_flow_b_start_tube,
    m_flows_start=m_flows_start_tube,
    redeclare model FlowModel =
        FlowModel_tube,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = HeatTransfer_tube_two,
    redeclare package Material =
        Material_tubeWall,
    counterCurrent=false,
    use_HeatTransferOuter=true,
    T_a1_start=T_b_start_tube,
    T_b1_start=T_b_start_tube,
    T_a2_start=T_b_start_tube,
    T_b2_start=T_b_start_tube,
    exposeState_outerWall=false,
    redeclare model InternalHeatModel_wall =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration)
    annotation (Placement(transformation(extent={{22,-90},{42,-70}})));

  Geometry geometry
    annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
equation
  //    SI.TemperatureDifference DT_lm "Log mean temperature difference";
  //    SI.ThermalConductance UA "Overall heat transfer conductance";
  //
  //    SI.CoefficientOfHeatTransfer U_shell "Overall heat transfer coefficient - shell side";
  //    SI.CoefficientOfHeatTransfer U_tube "Overall heat transfer coefficient - tube side";
  //
  //    SI.CoefficientOfHeatTransfer alphaAvg_shell "Average shell side heat transfer coefficient";
  //    SI.ThermalResistance R_shell;
  //
  //    SI.CoefficientOfHeatTransfer alphaAvg_tube;
  //    SI.ThermalResistance R_tube;
  //   alphaAvg_shell = sum(shell.heatTransfer.alphas)/geometry.nV;
  //   R_shell = 1/(alphaAvg_shell*sum(shell.surfaceAreas));
  //
  //   alphaAvg_tube = sum(tube.heatTransfer.alphas)/geometry.nV;
  //   R_tube = 1/(alphaAvg_tube*sum(tube.surfaceAreas));
  //
  //   DT_lm = SMR160.Models.Fluid.HeatExchangers.Utilities.Functions.LMTD(
  //             T_hi=shell.mediums[1].T,
  //             T_ho=shell.mediums[geometry.nV].T,
  //             T_ci=tube.mediums[1].T,
  //             T_co=tube.mediums[geometry.nV].T,
  //             counterCurrent=counterCurrent);
  //
  //   UA = SMR160.Models.Fluid.HeatExchangers.Utilities.Functions.UA(
  //             n=3,
  //             isSeries={true,true,true},
  //             R=[R_tube; 1e-6; R_shell]);
  //
  //   U_shell = UA/sum(shell.surfaceAreas);
  //   U_tube = UA/sum(tube.surfaceAreas);
  connect(shell.port_a, port_a_shell) annotation (Line(
      points={{10,46},{70,46},{100,46}},
      color={0,127,255},
      thickness=0.5));
  connect(port_b_shell, shell.port_b)
    annotation (Line(points={{-100,46},{-55,46},{-10,46}}, color={0,127,255}));
  connect(port_a_tube, tube_one.port_a) annotation (Line(points={{-100,0},{-80,0},
          {-80,-80},{-50,-80}}, color={0,127,255}));
  connect(tube_two.heatPorts, counterFlow1.port_a) annotation (Line(points={{32,-75},
          {32,-26}},                        color={191,0,0}));
  connect(tube_two.port_a, tube_one.port_b)
    annotation (Line(points={{22,-80},{-30,-80}}, color={0,127,255}));
  connect(tube_two.port_b, port_b_tube) annotation (Line(points={{42,-80},{70,-80},
          {70,-30},{96,-30},{96,-2},{100,-2},{100,0}}, color={0,127,255}));
  connect(tube_one.heatPorts, counterFlow.port_a)
    annotation (Line(points={{-40,-75},{-40,-26}}, color={191,0,0}));
  connect(counterFlow.port_b, shell.heatPorts[:, 1]) annotation (Line(points={{-40,-6},
          {-40,14},{0,14},{0,28},{-1.11022e-16,28},{-1.11022e-16,41}},
                                                             color={191,0,0}));
  connect(counterFlow1.port_b, shell.heatPorts[:, 2]) annotation (Line(points={{
          32,-6},{32,16},{6,16},{6,28},{0,28},{0,41}}, color={191,0,0}));
  annotation (
    defaultComponentName="heatExchanger",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Ellipse(
          extent={{10,28.5},{-10,-28.5}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_b_shell,
          origin={-100,45.5},
          rotation=360),
        Ellipse(
          extent={{10,28.5},{-10,-28.5}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_a_shell,
          origin={100,45.5},
          rotation=0),
        Rectangle(
          extent={{-90,2},{90,-2}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={0,-28},
          rotation=360),
        Rectangle(
          extent={{-90,16},{90,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,63,125}, if showColors then dynColor else {
              0,63,125}),
          origin={0,46},
          rotation=360),
        Rectangle(
          extent={{-90,26},{90,-26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,128,255}, if showColors then dynColor_tube
               else {0,128,255}),
          origin={0,0},
          rotation=360),
        Rectangle(
          extent={{-90,16},{90,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,63,125}, if showColors then dynColor else {
              0,63,125}),
          origin={0,-46},
          rotation=360),
        Rectangle(
          extent={{-90,2},{90,-2}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={0,28},
          rotation=360),
        Polygon(
          points={{-6,12},{20,0},{-6,-10},{-6,12}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,63,255},
          fillPattern=FillPattern.Solid,
          origin={38,0},
          rotation=360),
        Line(
          points={{45,0},{-45,0}},
          color={0,63,255},
          smooth=Smooth.None,
          origin={-13,0},
          rotation=360),
        Polygon(
          points={{6,11},{-20,-1},{6,-11},{6,11}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-40,46},
          rotation=360),
        Line(
          points={{45,0},{-45,0}},
          color={0,128,255},
          smooth=Smooth.None,
          origin={11,45},
          rotation=360),
        Line(
          points={{45,0},{-45,0}},
          color={0,128,255},
          smooth=Smooth.None,
          origin={11,-47},
          rotation=360),
        Ellipse(
          extent={{10,28.5},{-10,-28.5}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_a_tube,
          origin={-100,-0.5},
          rotation=0),
        Polygon(
          points={{6,11},{-20,-1},{6,-11},{6,11}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-40,-46},
          rotation=360),
        Ellipse(
          extent={{10,28.5},{-10,-28.5}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_b_tube,
          origin={100,-0.5},
          rotation=360),
        Text(
          extent={{-149,-68},{151,-108}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true,showName))}),
    Documentation(info="<html>
<p>A generic heat exchanger for any relatively simple general purpose heat transfer process.</p>
<p><br>- Currently the nodes on the shell and tube side must be equal. The lengths do not however there are no geometry checks to ensure reasonable user input.</p>
<p>- The wall is currently fixed as a 2D cylinder but may be generalized in the future to allow user to select wall geometry. The 2D cyclinder though does not require the tubes/shell to be cylinders but will potentially impact the results depending on what thermal resistance dominates.</p>
</html>"));
end UTubeHX;
