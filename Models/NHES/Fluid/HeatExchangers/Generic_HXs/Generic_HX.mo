within NHES.Fluid.HeatExchangers.Generic_HXs;
model Generic_HX
  "A simple (i.e., no inlet/outlet plenum considerations, etc.) generic heat exchanger where concurrent/counter flow is specified mass flow direction."

  import Modelica.Fluid.Types.ModelStructure;
  import NHES.Fluid.Types.LumpedLocation;

  outer Modelica.Fluid.System system "System wide properties";

  Modelica.Fluid.Interfaces.FluidPort_a port_a_tube(redeclare package Medium =
        Medium_tube)
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_tube(redeclare package Medium =
        Medium_tube)
    annotation (Placement(transformation(extent={{-70,90},{-50,110}}),
        iconTransformation(extent={{-10,90},{10,110}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a_shell(redeclare package Medium =
        Medium_shell)
    annotation (Placement(transformation(extent={{50,90},{70,110}}),
        iconTransformation(extent={{36,90},{56,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_shell(redeclare package Medium =
        Medium_shell)
    annotation (Placement(transformation(extent={{50,-110},{70,-90}}),
        iconTransformation(extent={{36,-110},{56,-90}})));

  parameter Real nParallel = 1 "# of identical parallel STHXs";

  replaceable package Medium_shell =
      Modelica.Media.Interfaces.PartialMedium "Shell side medium"
    annotation (__Dymola_choicesAllMatching=true);

  replaceable package Medium_tube =
      Modelica.Media.Interfaces.PartialMedium "Tube side medium"
    annotation (__Dymola_choicesAllMatching=true);
  replaceable package Tube_Material =
      NHES.Media.Interfaces.PartialAlloy      "Tube wall material"
                         annotation (
     __Dymola_choicesAllMatching=true);

  parameter Boolean counterCurrent=true
    "Swap temperature and flux vector order";

  // Shell Parameters
  parameter SI.Length length_shell "Shell length"
    annotation(Dialog(tab="Shell Parameters",group="Geometry"));
  parameter SI.Area crossArea_shell "Cross-sectional flow are of shell"
    annotation(Dialog(tab="Shell Parameters",group="Geometry"));
  parameter SI.Length perimeter_shell "Wetted perimeter of shell region"
    annotation(Dialog(tab="Shell Parameters",group="Geometry"));
  parameter SI.Height roughness_shell=2.5e-5
    "Avg. height of surface asperities"
    annotation(Dialog(tab="Shell Parameters",group="Geometry"));

  replaceable model FlowModel_shell =
      NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Shell flow model"
    annotation (choicesAllMatching=true,Dialog(tab="Shell Parameters",group="Pressure Drop"));

  parameter SI.Length height_a_shell=0 "Elevation at shell port_a: Reference value only. No impact on calculations."
    annotation(Dialog(tab="Shell Parameters",group="Pressure Drop"), Evaluate=true);
  parameter SI.Length dheight_shell=0
    "Shell Height(port_b) - Height(port_a)"
    annotation(Dialog(tab="Shell Parameters",group="Pressure Drop"), Evaluate=true);

  replaceable model HeatTransfer_shell =
      NHES.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Shell heat transfer coefficient model"
    annotation (choicesAllMatching=true,Dialog(tab="Shell Parameters",group="Heat Transfer"));
  parameter SI.Area[nV_shell] surfaceAreas_shell = fill(pi*(diameter_tube+2*th_tube)*length_tube*nTubes/nV_shell,nV_shell)
    "Heat transfer surface area of each volume node"
  annotation (Dialog(tab="Shell Parameters",group="Heat Transfer"));

  // Tube Parameters
  parameter Real nTubes=1 "Number of tubes in shell side of heat exchanger"
    annotation(Dialog(tab="Tube Parameters",group="Geometry"));
  parameter SI.Length length_tube=length_shell "Tube length"
    annotation(Dialog(tab="Tube Parameters",group="Geometry"));
  parameter Boolean isCircular_tube=true
    "= true if cross sectional area is circular"
    annotation(Dialog(tab="Tube Parameters",group="Geometry"));
  parameter SI.Diameter diameter_tube=if isCircular_tube then 0 else 4*crossArea_tube/perimeter_tube  "Inner Hydraulic diameter"
    annotation(Dialog(tab="Tube Parameters",group="Geometry",enable=isCircular_tube));
  parameter SI.Area crossArea_tube=pi*diameter_tube*diameter_tube/4 "Inner cross sectional area"
    annotation(Dialog(tab="Tube Parameters",group="Geometry",enable=not isCircular_tube));
  parameter SI.Length perimeter_tube=pi*diameter_tube "Inner wetted perimeter"
    annotation(Dialog(tab="Tube Parameters",group="Geometry",enable=not isCircular_tube));
  parameter SI.Length th_tube "Tube thickness"
    annotation(Dialog(tab="Tube Parameters",group="Geometry"));
  parameter SI.Height roughness_tube=2.5e-5 "Average height of surface asperities (default: smooth steel pipe)"
    annotation(Dialog(tab="Tube Parameters",group="Geometry"));
  parameter Integer nRadial(min=3)=3 "Nodes in radial direction in tube wall"
    annotation (Dialog(tab="Tube Parameters",group="Geometry"));

  replaceable model FlowModel_tube =
      NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Tube flow model"
    annotation (choicesAllMatching=true,Dialog(tab="Tube Parameters",group="Pressure Drop"));

  parameter SI.Length height_a_tube=0 "Elevation at tube port_a: Reference value only. No impact on calculations."
    annotation(Dialog(tab="Tube Parameters",group="Pressure Drop"), Evaluate=true);
  parameter SI.Length dheight_tube=0
    "Tube Height(port_b) - Height(port_a)"
    annotation(Dialog(tab="Tube Parameters",group="Pressure Drop"), Evaluate=true);

  replaceable model HeatTransfer_tube =
      NHES.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Tube heat transfer coefficient model"
    annotation (choicesAllMatching=true,Dialog(tab="Tube Parameters",group="Heat Transfer"));
  parameter SI.Area[nV_tube] surfaceAreas_tube = fill(pi*perimeter_tube*length_tube/nV_tube,nV_tube)
    "Heat transfer surface area of each volume node"
  annotation (Dialog(tab="Tube Parameters",group="Heat Transfer"));

  // Advanced
  parameter Integer nV_shell(min=3)=3
    "Number of discrete volumes"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Fluid.Types.ModelStructure modelStructure_shell=ModelStructure.av_b
    "Set ports as flow or volume models" annotation (Dialog(tab="Advanced",group="Shell Side"));
  parameter Boolean useLumpedPressure_shell=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced",group="Shell Side"),Evaluate=true);
  parameter LumpedLocation lumpPressureAt_shell= LumpedLocation.port_a
    "Location of pressure for flow calculations"
      annotation(Dialog(tab="Advanced",group="Shell Side",enable = if useLumpedPressure_shell and modelStructure_shell<>ModelStructure.av_vb then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties_shell=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced",group="Shell Side"),Evaluate=true);

  parameter Integer nV_tube(min=3)=nV_shell
    "Number of discrete volumes"
    annotation(Dialog(tab="Advanced",enable=false));
  parameter Modelica.Fluid.Types.ModelStructure modelStructure_tube=ModelStructure.av_b
    "Set ports as flow or volume models"
    annotation (Dialog(tab="Advanced",group="Tube Side"));
  parameter Boolean useLumpedPressure_tube=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced",group="Tube Side"),Evaluate=true);
  parameter LumpedLocation lumpPressureAt_tube= LumpedLocation.port_a
    "Location of pressure for flow calculations"
      annotation(Dialog(tab="Advanced",group="Tube Side",enable = if useLumpedPressure_tube and modelStructure_tube<>ModelStructure.av_vb then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties_tube=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced",group="Tube Side"),Evaluate=true);

  // Assumptions
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balances"
    annotation (Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=system.massDynamics
    "Formulation of mass balances"
    annotation (Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balances"
    annotation (Dialog(tab="Assumptions", group="Dynamics"));

  // Shell Initialization
  parameter SI.AbsolutePressure p_a_start_shell=system.p_start
    "Pressure at port a" annotation (Dialog(tab="Shell Initialization",group="Start Value: Pressure"));
  parameter SI.AbsolutePressure p_b_start_shell=p_a_start_shell
    "Pressure at port b" annotation (Dialog(tab="Shell Initialization",group="Start Value: Pressure"));
  parameter Medium_shell.AbsolutePressure[nV_shell] ps_start_shell=
    linspace(p_a_start_shell,p_b_start_shell,nV_shell)
    "Pressures {port_a,...,port_b}"
    annotation(Dialog(tab = "Shell Initialization",group="Start Value: Pressure"));

  parameter Boolean use_Ts_start_shell=true
    "Use T_start if true, otherwise h_start"
    annotation (Dialog(tab="Shell Initialization",group="Start Value: Temperature"));
  parameter Modelica.Media.Interfaces.Types.Temperature T_a_start_shell=system.T_start
    "Temperature at port a" annotation (Dialog(tab="Shell Initialization",group="Start Value: Temperature", enable = use_Ts_start_shell));
  parameter Modelica.Media.Interfaces.Types.Temperature T_b_start_shell=shell.T_a_start
    "Temperature at port b" annotation (Dialog(tab="Shell Initialization",group="Start Value: Temperature", enable = use_Ts_start_shell));
  parameter Medium_shell.Temperature[nV_shell] Ts_start_shell=
    if use_Ts_start_shell then
      linspace(T_a_start_shell,T_b_start_shell,nV_shell)
    else
      {Medium_shell.temperature_phX(
        ps_start_shell[i],
        hs_start_shell[i],
        Xs_start_shell) for i in 1:nV_shell} "Temperatures {a,...,b}"
    annotation(Evaluate=true, Dialog(tab = "Shell Initialization",group="Start Value: Temperature", enable = use_Ts_start_shell));

  parameter Modelica.Media.Interfaces.Types.SpecificEnthalpy h_a_start_shell=
      Medium_shell.specificEnthalpy_pTX(
      p_a_start_shell,
      T_a_start_shell,
      Xs_start_shell) "Specific enthalpy at port a"
    annotation (Dialog(tab="Shell Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start_shell));
  parameter Modelica.Media.Interfaces.Types.SpecificEnthalpy h_b_start_shell=
      Medium_shell.specificEnthalpy_pTX(
      p_b_start_shell,
      T_b_start_shell,
      Xs_start_shell) "Specific enthalpy at port b"
    annotation (Dialog(tab="Shell Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start_shell));
  parameter Medium_shell.SpecificEnthalpy[nV_shell] hs_start_shell=
    if use_Ts_start_shell then
      {Medium_shell.specificEnthalpy_pTX(
        ps_start_shell[i],
        Ts_start_shell[i],
        Xs_start_shell) for i in 1:nV_shell}
    else
      linspace(h_a_start_shell,h_b_start_shell,nV_shell)
    "Specific enthalpies {a,...,b}"
    annotation(Evaluate=true, Dialog(tab = "Shell Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start_shell));

  parameter Modelica.Media.Interfaces.Types.MassFraction Xs_start_shell[Medium_shell.nX]=
      Medium_shell.X_default "Mass fractions m_i/m"
      annotation (Dialog(tab="Shell Initialization",group="Start Value: Mass Fractions"));
  parameter Modelica.Media.Interfaces.Types.ExtraProperty Cs_start_shell[Medium_shell.nC]=
      fill(0, Medium_shell.nC) "Trace substances"
      annotation (Dialog(tab="Shell Initialization",group="Start Value: Trace Substances"));
  parameter SI.MassFlowRate m_flow_start_shell=system.m_flow_start
    "Mass flow rate" annotation (Dialog(tab="Shell Initialization",group="Start Value: Mass Flow Rate"));

  // Tube Initialization
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_a_start_tube=
      system.p_start "Pressure at port a"
    annotation (Dialog(tab = "Tube Initialization",group="Start Value: Absolute Pressure"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_b_start_tube=
      p_a_start_tube "Pressure at port b"
    annotation (Dialog(tab = "Tube Initialization",group="Start Value: Absolute Pressure"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure ps_start_tube[nV_tube]=
      if nV_tube > 1 then linspace(
      p_a_start_tube,
      p_b_start_tube,
      nV_tube) else {(p_a_start_tube + p_b_start_tube)/2}
    "Pressures {port_a,...,port_b}"
    annotation (Dialog(tab = "Tube Initialization",group="Start Value: Absolute Pressure"));

  parameter Boolean use_Ts_start_tube=true
    "Use T_start if true, otherwise h_start"
    annotation (Dialog(tab = "Tube Initialization",group="Start Value: Temperature"));

  parameter Modelica.Media.Interfaces.Types.Temperature T_a_start_tube=system.T_start
    "Temperature at port a" annotation (Dialog(tab = "Tube Initialization",group="Start Value: Temperature", enable = use_Ts_start_tube));
  parameter Modelica.Media.Interfaces.Types.Temperature T_b_start_tube=T_a_start_tube
    "Temperature at port b" annotation (Dialog(tab = "Tube Initialization",group="Start Value: Temperature", enable = use_Ts_start_tube));
  parameter Modelica.Media.Interfaces.Types.Temperature Ts_start_tube[nV_tube]=if
      use_Ts_start_tube then if nV_tube > 1 then linspace(
      T_a_start_tube,
      T_b_start_tube,
      nV_tube) else {(T_a_start_tube + T_b_start_tube)/2} else {
      Medium_tube.temperature_phX(
      ps_start_tube[i],
      hs_start_tube[i],
      Xs_start_tube) for i in 1:nV_tube} "Temperatures {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Tube Initialization",group="Start Value: Temperature", enable = use_Ts_start_tube));

  parameter Modelica.Media.Interfaces.Types.SpecificEnthalpy h_a_start_tube=
      Medium_tube.specificEnthalpy_pTX(p_a_start_tube, T_a_start_tube,Xs_start_tube)
    "Specific enthalpy at port a" annotation (Dialog(tab = "Tube Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start_tube));
  parameter Modelica.Media.Interfaces.Types.SpecificEnthalpy h_b_start_tube=
      Medium_tube.specificEnthalpy_pTX(p_b_start_tube, T_b_start_tube,Xs_start_tube)
    "Specific enthalpy at port b" annotation (Dialog(tab = "Tube Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start_tube));
  parameter Modelica.Media.Interfaces.Types.SpecificEnthalpy hs_start_tube[nV_tube]=
      if use_Ts_start_tube then {Medium_tube.specificEnthalpy_pTX(
      ps_start_tube[i],
      Ts_start_tube[i],
      Xs_start_tube) for i in 1:nV_tube} else if nV_tube > 1 then linspace(
      h_a_start_tube,
      h_b_start_tube,
      nV_tube) else {(h_a_start_tube + h_b_start_tube)/2}
    "Specific enthalpies {port_a,...,port_b}"
    annotation (Evaluate=true, Dialog(tab = "Tube Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start_tube));

  parameter Modelica.Media.Interfaces.Types.MassFraction Xs_start_tube[Medium_tube.nX]=
     Medium_tube.X_default "Mass fractions m_i/m"
    annotation (Dialog(tab="Tube Initialization",group="Start Value: Mass Fractions", enable=Medium_tube.nXi > 0));

  parameter Modelica.Media.Interfaces.Types.ExtraProperty Cs_start_tube[Medium_tube.nC]=
     fill(0, Medium_tube.nC) "Trace substances"
    annotation (Dialog(tab="Tube Initialization",group="Start Value: Trace Substances", enable=Medium_tube.nC > 0));

  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    m_flow_start_tube=system.m_flow_start "Mass flow rate at port_a"
    annotation (Dialog(tab = "Tube Initialization",group="Start Value: Mass Flow Rate"));
  parameter Modelica.Media.Interfaces.Types.Temperature Tref = 0.5*(sum(Ts_start_shell)/nV_shell + sum(Ts_start_tube)/nV_tube)
                                                                                                                    "Wall reference temperature"
     annotation (Dialog(tab = "Tube Initialization",group="Start Value: Wall Temperature"));
  parameter Modelica.Media.Interfaces.Types.Temperature[nRadial,nV_tube] Twall_start=[fill(Tref, nRadial-1, nV_tube); {if counterCurrent then Modelica.Math.Vectors.reverse(Ts_start_shell) else Ts_start_shell}]
     "Wall temperatures"
     annotation (Dialog(tab = "Tube Initialization",group="Start Value: Wall Temperature"));

  Pipes.StraightPipe tube(
    use_HeatTransfer=true,
    redeclare package Medium = Medium_tube,
    roughness=roughness_tube,
    height_a=height_a_tube,
    dheight=dheight_tube,
    allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    momentumDynamics=momentumDynamics,
    modelStructure=modelStructure_tube,
    redeclare model FlowModel = FlowModel_tube,
    redeclare model HeatTransfer = HeatTransfer_tube,
    T_a_start=T_a_start_tube,
    T_b_start=T_b_start_tube,
    h_a_start=h_a_start_tube,
    h_b_start=h_b_start_tube,
    p_a_start=p_a_start_tube,
    p_b_start=p_b_start_tube,
    ps_start=ps_start_tube,
    use_Ts_start=use_Ts_start_tube,
    Ts_start=Ts_start_tube,
    hs_start=hs_start_tube,
    Xs_start=Xs_start_tube,
    Cs_start=Cs_start_tube,
    length=length_tube,
    nV=nV_tube,
    useLumpedPressure=useLumpedPressure_tube,
    lumpPressureAt=lumpPressureAt_tube,
    useInnerPortProperties=useInnerPortProperties_tube,
    diameter=diameter_tube,
    m_flow_a_start=m_flow_start_tube,
    nParallel=nParallel*nTubes,
    isCircular=isCircular_tube,
    perimeter=perimeter_tube,
    crossArea=crossArea_tube,
    surfaceAreas=surfaceAreas_tube,
    Ts_wall(start=tubewall.T_start[1, :]))
    annotation (Placement(transformation(
        extent={{-22,22},{22,-22}},
        rotation=90,
        origin={-60,0})));

  NHES.Thermal.Conduction.FiniteDifference.Cylinder_FD tubewall(
    redeclare package material = Tube_Material,
    energyDynamics=energyDynamics,
    nRadial=nRadial,
    nAxial=tube.nV,
    redeclare model SolutionMethod_FD =
        Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.AxVolCentered_2O,
    r=linspace( tubewall.r_inner,
                tubewall.r_outer,
                tubewall.nRadial),
    z=linspace( 0.5*tubewall.length/tubewall.nAxial,
                tubewall.length*(1 - 0.5/tubewall.nAxial),
                tubewall.nAxial),
    r_inner=0.5*tube.diameter,
    r_outer=tubewall.r_inner + th_tube,
    length=tube.length,
    T_start=Twall_start,
    Tref=Tref)
    annotation (Placement(transformation(extent={{-22,-22},{22,22}})));

  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD(nNodes=tubewall.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={0,-27})));

  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD1(nNodes=tubewall.nRadial) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=90,
        origin={0,27})));

  NHES.Thermal.Conduction.FiniteDifference.Interfaces.ScalePower scalePower_WallToTube(nElem=
        integer(tube.nParallel), nNodes=tube.nV)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));

  NHES.Thermal.Conduction.FiniteDifference.Interfaces.ScalePower scalePower_WallToShell(
    nElem=integer(tube.nParallel),
    counterCurrent=counterCurrent,
    nNodes=tube.nV)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Pipes.StraightPipe shell(
    use_HeatTransfer=true,
    redeclare package Medium = Medium_shell,
    allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    momentumDynamics=momentumDynamics,
    isCircular=false,
    crossArea=crossArea_shell,
    perimeter=perimeter_shell,
    roughness=roughness_shell,
    redeclare model HeatTransfer = HeatTransfer_shell,
    p_a_start=p_a_start_shell,
    p_b_start=p_b_start_shell,
    modelStructure=modelStructure_shell,
    redeclare model FlowModel = FlowModel_shell,
    length=length_shell,
    height_a=height_a_shell,
    dheight=dheight_shell,
    useLumpedPressure=useLumpedPressure_shell,
    lumpPressureAt=lumpPressureAt_shell,
    useInnerPortProperties=useInnerPortProperties_shell,
    ps_start=ps_start_shell,
    use_Ts_start=use_Ts_start_shell,
    T_a_start=T_a_start_shell,
    T_b_start=T_b_start_shell,
    Ts_start=Ts_start_shell,
    h_a_start=h_a_start_shell,
    h_b_start=h_b_start_shell,
    hs_start=hs_start_shell,
    m_flow_a_start=m_flow_start_shell,
    surfaceAreas=surfaceAreas_shell,
    Xs_start=Xs_start_shell,
    Cs_start=Cs_start_shell,
    nParallel=nParallel,
    nV=nV_shell,
    Ts_wall(start=tubewall.T_start[end, :]))
    annotation (Placement(transformation(
        extent={{22,-22},{-22,22}},
        rotation=90,
        origin={60,0})));

   SI.TemperatureDifference DT_lm "Log mean temperature difference";
   SI.ThermalConductance UA "Overall heat transfer conductance";

   SI.CoefficientOfHeatTransfer U_shell "Overall heat transfer coefficient - shell side";
   SI.CoefficientOfHeatTransfer U_tube "Overall heat transfer coefficient - tube side";

   SI.CoefficientOfHeatTransfer alphaAvg_shell "Average shell side heat transfer coefficient";
   SI.ThermalResistance R_shell;

   SI.CoefficientOfHeatTransfer alphaAvg_tube;
   SI.ThermalResistance R_tube;

equation

  alphaAvg_shell = sum(shell.heatTransfer.alphas)/nV_shell;
  R_shell = 1/(alphaAvg_shell*sum(shell.surfaceAreas));

  alphaAvg_tube = sum(tube.heatTransfer.alphas)/nV_tube;
  R_tube = 1/(alphaAvg_tube*sum(tube.surfaceAreas));

  DT_lm = NHES.Fluid.HeatExchangers.Utilities.Functions.LMTD(
            T_hi=shell.mediums[1].T,
            T_ho=shell.mediums[nV_shell].T,
            T_ci=tube.mediums[1].T,
            T_co=tube.mediums[nV_tube].T,
            counterCurrent=counterCurrent);

  UA = NHES.Fluid.HeatExchangers.Utilities.Functions.UA(
            n=3,
            isSeries={true,true,true},
            R=[R_tube; tubewall.solutionMethod.R_cond_radial; R_shell]);

  U_shell = UA/sum(shell.surfaceAreas);
  U_tube = UA/sum(tube.surfaceAreas);

  connect(adiabatic_FD1.port, tubewall.heatPorts_top)
    annotation (Line(points={{0,22},{0,13.42}}, color={191,0,0}));
  connect(adiabatic_FD.port, tubewall.heatPorts_bottom)
    annotation (Line(points={{0,-22},{0,-12.98}}, color={191,0,0}));
  connect(tube.port_b, port_b_tube)
    annotation (Line(points={{-60,22},{-60,100}}, color={0,127,255}));
  connect(tube.port_a, port_a_tube) annotation (Line(points={{-60,-22},{-60,-22},
          {-60,-100}}, color={0,127,255}));
  connect(scalePower_WallToTube.heatPorts_a, tubewall.heatPorts_inner)
    annotation (Line(points={{-20,0},{-12.98,0}}, color={127,0,0}));
  connect(scalePower_WallToTube.heatPorts_b, tube.heatPorts) annotation (Line(
        points={{-40,0},{-50.32,0},{-50.32,0.22}}, color={127,0,0}));

  connect(tubewall.heatPorts_outer, scalePower_WallToShell.heatPorts_a)
    annotation (Line(points={{12.98,0},{20,0}},           color={127,0,0}));
  connect(shell.port_b, port_b_shell)
    annotation (Line(points={{60,-22},{60,-100}}, color={0,127,255}));
  connect(port_a_shell, shell.port_a)
    annotation (Line(points={{60,100},{60,100},{60,22}}, color={0,127,255}));
  connect(scalePower_WallToShell.heatPorts_b, shell.heatPorts) annotation (Line(
        points={{40,0},{50.32,0},{50.32,-0.22}}, color={127,0,0}));
  annotation (defaultComponentName="STHX",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,2},{100,-2}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={-28,0},
          rotation=-90),
        Rectangle(
          extent={{-100,16},{100,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,63,125},
          origin={46,0},
          rotation=-90),
        Rectangle(
          extent={{-100,26},{100,-26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={0,0},
          rotation=-90),
        Rectangle(
          extent={{-100,16},{100,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,63,125},
          origin={-46,0},
          rotation=-90),
        Rectangle(
          extent={{-100,2},{100,-2}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={28,0},
          rotation=-90),
        Polygon(
          points={{20,15},{-20,0},{20,-15},{20,15}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,63,255},
          fillPattern=FillPattern.Solid,
          origin={0,51},
          rotation=-90),
        Line(
          points={{45,0},{-45,0}},
          color={0,63,255},
          smooth=Smooth.None,
          origin={-1,-13},
          rotation=-90),
        Polygon(
          points={{-20,15},{20,0},{-20,-15},{-20,15}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={46,-43},
          rotation=-90),
        Line(
          points={{45,0},{-45,0}},
          color={0,128,255},
          smooth=Smooth.None,
          origin={45,23},
          rotation=-90),
        Polygon(
          points={{-20,15},{20,0},{-20,-15},{-20,15}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-46,-43},
          rotation=-90),
        Line(
          points={{45,0},{-45,0}},
          color={0,128,255},
          smooth=Smooth.None,
          origin={-47,23},
          rotation=-90)}),
    Documentation(info="<html>
<p>A generic heat exchanger for any relatively simple general purpose heat transfer process.</p>
<p><br>- Currently the nodes on the shell and tube side must be equal. The lengths do not however there are no geometry checks to ensure reasonable user input.</p>
<p>- The wall is currently fixed as a 2D cylinder but may be generalized in the future to allow user to select wall geometry. The 2D cyclinder though does not require the tubes/shell to be cylinders but will potentially impact the results depending on what thermal resistance dominates.</p>
</html>"));
end Generic_HX;
