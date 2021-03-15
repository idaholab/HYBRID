within NHES.Fluid.Pipes.BaseClasses;
partial model PartialGenericPipeParameters "Summary of generic pipe parameters"

  import Modelica.Fluid.Types.Dynamics;
  //import Modelica.Media.Interfaces.Choices.IndependentVariables;
  import Modelica.Fluid.Types.ModelStructure;
  import NHES.Fluid.Types.LumpedLocation;

  outer Modelica.Fluid.System system "System properties";

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // Volume geometry parameters
  parameter Real nParallel(min=1)=1 "Number of identical parallel flow devices"
    annotation(Dialog(group="Geometry"));
  parameter SI.Length[nV] lengths "Lengths of volumes"
    annotation (Dialog(group="Geometry"));
  parameter SI.Area[nV] crossAreas "Cross-sectional flow areas of volumes"
   annotation (Dialog(group="Geometry"));
  parameter SI.Length[nV] dimensions "Hydraulic diameters of volumes"
   annotation (Dialog(group="Geometry"));
  parameter SI.Length[nV] perimeters=4*crossAreas./dimensions "Wetted perimeters of volumes"
   annotation (Dialog(group="Geometry"));
  parameter SI.Height[nV] roughnesses "Average heights of volume surface asperities"
    annotation (Dialog(group="Geometry"));

  // Static head
  parameter SI.Length height_a=0
    "Elevation at port_a: Reference value only. No impact on calculations."
    annotation (Dialog(group="Static head"), Evaluate=true);
  parameter SI.Length[nV] dheights=fill(0,nV)
    "Height(port_b) - Height(port_a) distributed by flow segment"
    annotation (Dialog(group="Static head"), Evaluate=true);

  // Pressure loss model
  replaceable model FlowModel =
    NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Wall friction, gravity, momentum flow"
      annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);

  // Assumptions
  parameter Boolean allowFlowReversal = system.allowFlowReversal
"= true to allow flow reversal, false restricts to design direction (m_flows >= zeros(m))"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  parameter Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Dynamics massDynamics=system.massDynamics
    "Formulation of mass balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balances"
    annotation (Evaluate=true, Dialog(tab="Assumptions", group="Dynamics"));
  parameter Boolean use_HeatTransfer = false
    "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Assumptions", group="Heat transfer"));
  replaceable model HeatTransfer =
      NHES.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
      annotation (Dialog(tab="Assumptions", group="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);
  parameter SI.Area[nV] surfaceAreas = {perimeters[i]*lengths[i] for i in 1:nV}
    "Heat transfer surface area of each volume node"
  annotation (Dialog(tab="Assumptions", group="Heat transfer"));
  parameter SI.Power[nV] Qint_flows=zeros(nV)
    "Internal heat generation in each volume"
    annotation (Dialog(tab="Assumptions", group="Heat transfer"));

  // Advanced
  parameter Integer nV(min=1)=2 "Number of discrete volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  parameter ModelStructure modelStructure=ModelStructure.av_vb
    "Determines whether flow or volume models are present at the ports"
    annotation (Dialog(tab="Advanced"), Evaluate=true);

  parameter Boolean useLumpedPressure=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  parameter LumpedLocation lumpPressureAt = LumpedLocation.port_a
    "Location of pressure for flow calculations"
      annotation(Dialog(tab="Advanced",enable = if useLumpedPressure and modelStructure<>ModelStructure.av_vb then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);

 //Initialization
  parameter Medium.AbsolutePressure p_a_start=system.p_start
      "Pressure at port a"
    annotation(Dialog(tab = "Initialization",group="Start Value: Absolute Pressure"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Pressure at port b"
    annotation(Dialog(tab = "Initialization",group="Start Value: Absolute Pressure"));
  parameter Medium.AbsolutePressure[nV] ps_start=
    if nV > 1 then
      linspace(p_a_start,p_b_start,nV) else {(p_a_start + p_b_start)/2}
    "Pressures {port_a,...,port_b}"
    annotation(Dialog(tab = "Initialization",group="Start Value: Absolute Pressure"));

  parameter Boolean use_Ts_start=true "Use T_start if true, otherwise h_start"
     annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Temperature"));

  parameter Medium.Temperature T_a_start=system.T_start
      "Temperature at port a"
    annotation(Dialog(tab = "Initialization",group="Start Value: Temperature", enable = use_Ts_start));
  parameter Medium.Temperature T_b_start=T_a_start
      "Temperature at port b"
    annotation(Dialog(tab = "Initialization",group="Start Value: Temperature", enable = use_Ts_start));
  parameter Medium.Temperature[nV] Ts_start=
    if use_Ts_start then
      if nV > 1 then
         linspace(T_a_start,T_b_start,nV)
      else
        {(T_a_start+T_b_start)/2}
    else
      {Medium.temperature_phX(
        ps_start[i],
        hs_start[i],
        Xs_start) for i in 1:nV} "Temperatures {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Temperature", enable = use_Ts_start));

  parameter Medium.SpecificEnthalpy h_a_start=Medium.specificEnthalpy_pTX(p_a_start,T_a_start,Xs_start)
      "Specific enthalpy at port a"
    annotation(Dialog(tab = "Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));
  parameter Medium.SpecificEnthalpy h_b_start=Medium.specificEnthalpy_pTX(p_b_start,T_b_start,Xs_start)
      "Specific enthalpy at port b"
    annotation(Dialog(tab = "Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));
  parameter Medium.SpecificEnthalpy[nV] hs_start=
    if use_Ts_start then
      {Medium.specificEnthalpy_pTX(
        ps_start[i],
        Ts_start[i],
        Xs_start) for i in 1:nV}
    else
      if nV > 1 then
        linspace(h_a_start,h_b_start,nV)
      else
        {(h_a_start+h_b_start)/2}
    "Specific enthalpies {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));

  parameter Medium.MassFraction Xs_start[Medium.nX]=Medium.X_default
    "Mass fractions m_i/m"
    annotation (Dialog(tab="Initialization",group="Start Value: Mass Fractions", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty Cs_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Trace substances"
    annotation (Dialog(tab="Initialization",group="Start Value: Trace Substances", enable=Medium.nC > 0));
  parameter Medium.MassFlowRate m_flow_a_start = system.m_flow_start
    "Mass flow rate at port_a"
     annotation(Dialog(tab = "Initialization",group="Start Value: Mass Flow Rate"));
  parameter Medium.MassFlowRate m_flow_b_start = -m_flow_a_start
    "Mass flow rate at port_b"
     annotation(Dialog(tab = "Initialization",group="Start Value: Mass Flow Rate"));
  parameter Medium.MassFlowRate[nV+1] m_flows_start = linspace(m_flow_a_start,-m_flow_b_start,nV+1)
    "Mass flow rates {port_a,...,port_b}"
     annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Mass Flow Rate"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialGenericPipeParameters;
