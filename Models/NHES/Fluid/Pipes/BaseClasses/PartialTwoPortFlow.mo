within NHES.Fluid.Pipes.BaseClasses;
partial model PartialTwoPortFlow
  "Base class for distributed flow models. Passes wall temperature to flowModel."

  import Modelica.Fluid.Types.ModelStructure;
  import NHES.Fluid.Types.LumpedLocation;

  // extending PartialTwoPort
  extends Modelica.Fluid.Interfaces.PartialTwoPort(
    final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb),
    final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

  // distributed volume model
  extends NHES.Fluid.Interfaces.PartialDistributedVolume(final
      fluidVolumes={crossAreas[i]*lengths[i] for i in 1:nV}*nParallel);

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
  final parameter SI.Length height_b=height_a + sum(dheights)
    "Elevation at port_b: Reference value only. No impact on calculations."
    annotation (Dialog(group="Static head", enable= false), Evaluate=true);
  parameter SI.Length[nV] dheights=fill(0,nV)
    "Height(port_b) - Height(port_a) distributed by flow segment"
    annotation (Dialog(group="Static head"), Evaluate=true);

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balances"
    annotation (Evaluate=true, Dialog(tab="Assumptions", group="Dynamics"));

  // Initialization
  parameter Medium.MassFlowRate m_flow_a_start = system.m_flow_start
    "Mass flow rate at port_a"
     annotation(Dialog(tab = "Initialization",group="Start Value: Mass Flow Rate"));
  parameter Medium.MassFlowRate m_flow_b_start = -m_flow_a_start
    "Mass flow rate at port_b"
     annotation(Dialog(tab = "Initialization",group="Start Value: Mass Flow Rate"));
  parameter Medium.MassFlowRate[nV+1] m_flows_start = linspace(m_flow_a_start,-m_flow_b_start,nV+1)
    "Mass flow rates {port_a,...,port_b}"
     annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Mass Flow Rate"));

  parameter ModelStructure modelStructure=ModelStructure.av_vb
    "Determines whether flow or volume models are present at the ports"
    annotation (Dialog(tab="Advanced"), Evaluate=true);

  parameter Boolean useLumpedPressure=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  parameter LumpedLocation lumpPressureAt = LumpedLocation.port_a
    "Location of pressure for flow calculations"
      annotation(Dialog(tab="Advanced",enable = if useLumpedPressure and modelStructure<>ModelStructure.av_vb then true else false), Evaluate=true);

  final parameter Integer nFM=if useLumpedPressure then nFMLumped else nFMDistributed
    "number of flow models in flowModel";

  final parameter Integer nFMDistributed=
    if modelStructure==ModelStructure.a_v_b then
      nV+1
    else if (modelStructure==ModelStructure.a_vb or modelStructure==ModelStructure.av_b) then
      nV
    else
      nV-1;

  final parameter Integer nFMLumped=if modelStructure==ModelStructure.a_v_b then 2 else 1;
  final parameter Integer iLumped=integer(nV/2)+1
    "Index of control volume with representative state if useLumpedPressure"
    annotation(Evaluate=true);

  // Advanced
  parameter Boolean useInnerPortProperties=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);

  Medium.ThermodynamicState state_a "state defined by volume outside port_a";
  Medium.ThermodynamicState state_b "state defined by volume outside port_b";
  Medium.ThermodynamicState[nFM+1] statesFM "state vector for flowModel model";
  SI.Temperature[nFM+1] Ts_wFM(start=Ts_wFM_start)
    "Mean wall temperatures of heat transfer surface";

  // Pressure loss model
  replaceable model FlowModel =
    NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Wall friction, gravity, momentum flow"
      annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);
  FlowModel flowModel(
          redeclare final package Medium = Medium,
          final nFM=nFM,
          final states=statesFM,
          final vs=vsFM,
          final momentumDynamics=momentumDynamics,
          final allowFlowReversal=allowFlowReversal,
          final m_flows_start=m_flowsFM_start,
          final nParallel=nParallel,
          final lengths=lengthsFM,
          final crossAreas=crossAreasFM,
          final dimensions=dimensionsFM,
          final roughnesses=roughnessesFM,
          final dheights=dheightsFM,
          final g=system.g,
          final Ts_w=Ts_wFM,
          final dps_fg_start=dps_fg_start) "Flow model"
     annotation (Placement(transformation(extent={{-77,-37},{75,-19}},rotation=0)));

  final parameter SI.PressureDifference dp_nominal = p_a_start - p_b_start;
  final parameter SI.PressureDifference[nFM] dps_fg_start=
    if useLumpedPressure then
      if modelStructure == ModelStructure.a_v_b then
        cat(1,{dp_nominal/2},{dp_nominal/2})
      else
        {dp_nominal}
    else
      if modelStructure == ModelStructure.a_v_b then
        if nV == 1 then
          cat(1,{dp_nominal/2},{dp_nominal/2})
        else
          cat(1,{dp_nominal/(nV+1)},{ps_start[i]-ps_start[i+1] for i in 1:nV-1},{dp_nominal/(nV+1)})
      elseif modelStructure == ModelStructure.a_vb then
        if nV == 1 then
          {dp_nominal}
        else
          cat(1,{dp_nominal/nV},{ps_start[i]-ps_start[i+1] for i in 1:nV-1})
      elseif modelStructure == ModelStructure.av_b then
        if nV == 1 then
          {dp_nominal}
        else
          cat(1,{ps_start[i]-ps_start[i+1] for i in 1:nV-1},{dp_nominal/nV})
      else
        {ps_start[i]-ps_start[i+1] for i in 1:nV-1};

  final parameter SI.MassFlowRate[nFM] m_flowsFM_start=
    if useLumpedPressure then
      if lumpPressureAt == LumpedLocation.port_a then
        if modelStructure == ModelStructure.a_v_b then
        cat(1,{m_flows_start[1]},{m_flows_start[1]})
        else
        {m_flows_start[1]}
      else
        if modelStructure == ModelStructure.a_v_b then
        cat(1,{m_flows_start[nV+1]},{m_flows_start[nV+1]})
        else
        {m_flows_start[nV+1]}
    else
      if modelStructure == ModelStructure.a_v_b then
        m_flows_start
      elseif modelStructure == ModelStructure.a_vb then
        {m_flows_start[i] for i in 1:nV}
      elseif modelStructure == ModelStructure.av_b then
        {m_flows_start[i] for i in 2:nV+1}
      else
        {m_flows_start[i] for i in 2:nV};

  final parameter SI.Temperature[nFM+1] Ts_wFM_start=
    if useLumpedPressure then
      if modelStructure == ModelStructure.a_v_b then
        cat(1,{T_a_start},{0.5*(T_a_start+T_b_start)},{T_b_start})
      else
        cat(1,{T_a_start},{T_b_start})
    else
      if modelStructure == ModelStructure.a_v_b then
        if nV == 1 then
        cat(1,{T_a_start},{0.5*(T_a_start+T_b_start)},{T_b_start})
        else
          cat(1,{T_a_start},{Ts_start[i] for i in 1:nV},{T_b_start})
      elseif modelStructure == ModelStructure.a_vb then
        if nV == 1 then
        cat(1,{T_a_start},{T_b_start})
        else
          cat(1,{T_a_start},{Ts_start[i] for i in 1:nV})
      elseif modelStructure == ModelStructure.av_b then
        if nV == 1 then
        cat(1,{T_a_start},{T_b_start})
        else
          cat(1,{Ts_start[i] for i in 1:nV},{T_b_start})
      else
        {Ts_start[i] for i in 1:nV};

  // Flow quantities
  Medium.MassFlowRate[nV+1] m_flows(
     each min=if allowFlowReversal then -Modelica.Constants.inf else 0,
     start=m_flows_start)
    "Mass flow rates of fluid across segment boundaries";
  Medium.MassFlowRate[nV+1, Medium.nXi] mXi_flows
    "Independent mass flow rates across segment boundaries";
  Medium.MassFlowRate[nV+1, Medium.nC] mC_flows
    "Trace substance mass flow rates across segment boundaries";
  Medium.EnthalpyFlowRate[nV+1] H_flows
    "Enthalpy flow rates of fluid across segment boundaries";

  SI.Velocity[nV] vs={0.5*(m_flows[i] + m_flows[i + 1])/mediums[i].d
      /crossAreas[i] for i in 1:nV}/nParallel "mean velocities in flow segments";

  // Wall heat transfer
  SI.MassFlowRate[nV] m_flowsHT = {0.5*(m_flows[i]+m_flows[i+1]) for i in 1:nV}/nParallel
    "Mean mass flow rates for heat transfer";

  parameter Boolean use_HeatTransfer = false
    "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Assumptions", group="Heat transfer"));

  replaceable model HeatTransfer =
      NHES.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
      annotation (Dialog(tab="Assumptions", group="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);

  Modelica.Fluid.Interfaces.HeatPorts_a[nV] heatPorts if use_HeatTransfer
    annotation (Placement(transformation(extent={{-10,45},{10,65}}), iconTransformation(extent={{-30,36},
            {32,52}})));

  HeatTransfer heatTransfer(
    redeclare each final package Medium = Medium,
    final nHT=nV,
    final nParallel=nParallel,
    final lengths=lengths,
    final crossAreas=crossAreas,
    final dimensions=dimensions,
    final surfaceAreas=surfaceAreas,
    final roughnesses=roughnesses,
    final states=mediums.state,
    final m_flows = m_flowsHT,
    final use_k = use_HeatTransfer) "Heat transfer model"
      annotation (Placement(transformation(extent={{-45,20},{-23,42}}, rotation=0)));

  parameter SI.Area[nV] surfaceAreas = {perimeters[i]*lengths[i] for i in 1:nV}
    "Heat transfer surface area of each volume node"
  annotation (Dialog(tab="Assumptions", group="Heat transfer"));

  final parameter Real[nV] dxs = lengths/sum(lengths);

  SI.Volume[nV] Volumes "volume size";
  SI.Volume Volume_total = sum(Volumes) "Total fluid volume";

  SI.Temperature Teff "Effective (average) fluid temperature";
  SI.Temperature[nV] Ts_wall(start=Ts_start) "use_HeatTransfer = true then wall temperature else bulk medium temperature";

protected
  Modelica.Fluid.Interfaces.HeatPorts_a[nV] heatPorts_int;

  // Model structure dependent flow geometry
  SI.Length[nFM] lengthsFM "Lengths of flow segments";
  SI.Length[nFM] dheightsFM "Differences in heights between flow segments";
  SI.Area[nFM + 1] crossAreasFM "Cross flow areas of flow segments";
  SI.Velocity[nFM + 1] vsFM "Mean velocities in flow segments";
  SI.Length[nFM + 1] dimensionsFM "Hydraulic diameters of flow segments";
  SI.Height[nFM + 1] roughnessesFM "Average heights of surface asperities";

equation

  for i in 1:nV loop
  assert(lengths[i] >= abs(dheights[i]), "Parameter lengths must be greater or equal to abs(dheights).");
  end for;

  for i in 1:nV loop
    Volumes[i] = crossAreas[i]*lengths[i];
  end for;

  Teff = sum({mediums[i].T*Volumes[i] for i in 1:nV})/Volume_total;

  connect(heatPorts_int,heatTransfer.heatPorts);
  connect(heatPorts, heatTransfer.heatPorts);
  if not use_HeatTransfer then
    Ts_wall = mediums.T;
  else
    Ts_wall = heatPorts_int.T;
  end if;

  assert(nV > 1 or modelStructure <> ModelStructure.av_vb,
     "nV needs to be at least 2 for modelStructure av_vb, as flow model disappears otherwise!");
  // staggered grid discretization of geometry for flowModel, depending on modelStructure
  if useLumpedPressure then
    if modelStructure <> ModelStructure.a_v_b then
      lengthsFM[1] = sum(lengths);
      dheightsFM[1] = sum(dheights);
      if nV == 1 then
        crossAreasFM[1:2] = {crossAreas[1], crossAreas[1]};
        dimensionsFM[1:2] = {dimensions[1], dimensions[1]};
        roughnessesFM[1:2] = {roughnesses[1], roughnesses[1]};
      else // nV > 1
        crossAreasFM[1:2] = {sum(crossAreas[1:iLumped-1])/(iLumped-1), sum(crossAreas[iLumped:nV])/(nV-iLumped+1)};
        dimensionsFM[1:2] = {sum(dimensions[1:iLumped-1])/(iLumped-1), sum(dimensions[iLumped:nV])/(nV-iLumped+1)};
        roughnessesFM[1:2] = {sum(roughnesses[1:iLumped-1])/(iLumped-1), sum(roughnesses[iLumped:nV])/(nV-iLumped+1)};
      end if;
    else
      if nV == 1 then
        lengthsFM[1:2] = {lengths[1]/2, lengths[1]/2};
        dheightsFM[1:2] = {dheights[1]/2, dheights[1]/2};
        crossAreasFM[1:3] = {crossAreas[1], crossAreas[1], crossAreas[1]};
        dimensionsFM[1:3] = {dimensions[1], dimensions[1], dimensions[1]};
        roughnessesFM[1:3] = {roughnesses[1], roughnesses[1], roughnesses[1]};
      else // nV > 1
        lengthsFM[1:2] = {sum(lengths[1:iLumped-1]), sum(lengths[iLumped:nV])};
        dheightsFM[1:2] = {sum(dheights[1:iLumped-1]), sum(dheights[iLumped:nV])};
        crossAreasFM[1:3] = {sum(crossAreas[1:iLumped-1])/(iLumped-1), sum(crossAreas)/nV, sum(crossAreas[iLumped:nV])/(nV-iLumped+1)};
        dimensionsFM[1:3] = {sum(dimensions[1:iLumped-1])/(iLumped-1), sum(dimensions)/nV, sum(dimensions[iLumped:nV])/(nV-iLumped+1)};
        roughnessesFM[1:3] = {sum(roughnesses[1:iLumped-1])/(iLumped-1), sum(roughnesses)/nV, sum(roughnesses[iLumped:nV])/(nV-iLumped+1)};
      end if;
    end if;
  else
    if modelStructure == ModelStructure.av_vb then
      //nFM = nV-1
      if nV == 2 then
        lengthsFM[1] = lengths[1] + lengths[2];
        dheightsFM[1] = dheights[1] + dheights[2];
      else
        lengthsFM[1:nV-1] = cat(1, {lengths[1] + 0.5*lengths[2]}, 0.5*(lengths[2:nV-2] + lengths[3:nV-1]), {0.5*lengths[nV-1] + lengths[nV]});
        dheightsFM[1:nV-1] = cat(1, {dheights[1] + 0.5*dheights[2]}, 0.5*(dheights[2:nV-2] + dheights[3:nV-1]), {0.5*dheights[nV-1] + dheights[nV]});
      end if;
      crossAreasFM[1:nV] = crossAreas;
      dimensionsFM[1:nV] = dimensions;
      roughnessesFM[1:nV] = roughnesses;
    elseif modelStructure == ModelStructure.av_b then
      //nFM = nV
      lengthsFM[1:nV] = lengths;
      dheightsFM[1:nV] = dheights;
      crossAreasFM[1:nV+1] = cat(1, crossAreas[1:nV], {crossAreas[nV]});
      dimensionsFM[1:nV+1] = cat(1, dimensions[1:nV], {dimensions[nV]});
      roughnessesFM[1:nV+1] = cat(1, roughnesses[1:nV], {roughnesses[nV]});
    elseif modelStructure == ModelStructure.a_vb then
      //nFM = nV
      lengthsFM[1:nV] = lengths;
      dheightsFM[1:nV] = dheights;
      crossAreasFM[1:nV+1] = cat(1, {crossAreas[1]}, crossAreas[1:nV]);
      dimensionsFM[1:nV+1] = cat(1, {dimensions[1]}, dimensions[1:nV]);
      roughnessesFM[1:nV+1] = cat(1, {roughnesses[1]}, roughnesses[1:nV]);
    elseif modelStructure == ModelStructure.a_v_b then
      //nFM = nV+1;
      lengthsFM[1:nV+1] = cat(1, {0.5*lengths[1]}, 0.5*(lengths[1:nV-1] + lengths[2:nV]), {0.5*lengths[nV]});
      dheightsFM[1:nV+1] = cat(1, {0.5*dheights[1]}, 0.5*(dheights[1:nV-1] + dheights[2:nV]), {0.5*dheights[nV]});
      crossAreasFM[1:nV+2] = cat(1, {crossAreas[1]}, crossAreas[1:nV], {crossAreas[nV]});
      dimensionsFM[1:nV+2] = cat(1, {dimensions[1]}, dimensions[1:nV], {dimensions[nV]});
      roughnessesFM[1:nV+2] = cat(1, {roughnesses[1]}, roughnesses[1:nV], {roughnesses[nV]});
    else
      assert(false, "Unknown model structure");
    end if;
  end if;

  // Source/sink terms for mass and energy balances
  for i in 1:nV loop
    mb_flows[i] = m_flows[i] - m_flows[i + 1];
    mbXi_flows[i, :] = mXi_flows[i, :] - mXi_flows[i + 1, :];
    mbC_flows[i, :]  = mC_flows[i, :]  - mC_flows[i + 1, :];
    Hb_flows[i] = H_flows[i] - H_flows[i + 1];
  end for;

  // Distributed flow quantities, upwind discretization
  for i in 2:nV loop
    H_flows[i] = semiLinear(m_flows[i], mediums[i - 1].h, mediums[i].h);
    mXi_flows[i, :] = semiLinear(m_flows[i], mediums[i - 1].Xi, mediums[i].Xi);
    mC_flows[i, :]  = semiLinear(m_flows[i], Cs[i - 1, :],         Cs[i, :]);
  end for;
  H_flows[1] = semiLinear(port_a.m_flow, inStream(port_a.h_outflow), mediums[1].h);
  H_flows[nV + 1] = -semiLinear(port_b.m_flow, inStream(port_b.h_outflow), mediums[nV].h);
  mXi_flows[1, :] = semiLinear(port_a.m_flow, inStream(port_a.Xi_outflow), mediums[1].Xi);
  mXi_flows[nV + 1, :] = -semiLinear(port_b.m_flow, inStream(port_b.Xi_outflow), mediums[nV].Xi);
  mC_flows[1, :] = semiLinear(port_a.m_flow, inStream(port_a.C_outflow), Cs[1, :]);
  mC_flows[nV + 1, :] = -semiLinear(port_b.m_flow, inStream(port_b.C_outflow), Cs[nV, :]);

  // Boundary conditions
  port_a.m_flow    = m_flows[1];
  port_b.m_flow    = -m_flows[nV + 1];
  port_a.h_outflow = mediums[1].h;
  port_b.h_outflow = mediums[nV].h;
  port_a.Xi_outflow = mediums[1].Xi;
  port_b.Xi_outflow = mediums[nV].Xi;
  port_a.C_outflow = Cs[1, :];
  port_b.C_outflow = Cs[nV, :];
  // The two equations below are not correct if C is stored in volumes.
  // C should be treated the same way as Xi.
  //port_a.C_outflow = inStream(port_b.C_outflow);
  //port_b.C_outflow = inStream(port_a.C_outflow);

  if useInnerPortProperties and nV > 0 then
    state_a = Medium.setState_phX(port_a.p, mediums[1].h, mediums[1].Xi);
    state_b = Medium.setState_phX(port_b.p, mediums[nV].h, mediums[nV].Xi);
  else
    state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
    state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
  end if;

  // staggered grid discretization for flowModel, depending on modelStructure
  if useLumpedPressure then
    if modelStructure <> ModelStructure.av_vb then
      // all pressures are equal
      if lumpPressureAt == LumpedLocation.port_a then
        fill(mediums[1].p, nV-1) = mediums[2:nV].p;
      elseif lumpPressureAt == LumpedLocation.port_b then
        fill(mediums[nV].p, nV-1) = mediums[1:nV-1].p;
      else
        assert(false, "Unknown lumped pressure location");
      end if;
    elseif nV > 2 then
      // need two pressures
      fill(mediums[1].p, iLumped-2) = mediums[2:iLumped-1].p;
      fill(mediums[nV].p, nV-iLumped) = mediums[iLumped:nV-1].p;
    end if;
    if modelStructure == ModelStructure.av_vb then
      port_a.p = mediums[1].p;
      statesFM[1] = mediums[1].state;
      m_flows[iLumped] = flowModel.m_flows[1];
      statesFM[2] = mediums[nV].state;
      port_b.p = mediums[nV].p;
      vsFM[1] = vs[1:iLumped-1]*lengths[1:iLumped-1]/sum(lengths[1:iLumped-1]);
      vsFM[2] = vs[iLumped:nV]*lengths[iLumped:nV]/sum(lengths[iLumped:nV]);
         Ts_wFM[1] = Ts_wall[1];
         Ts_wFM[2] = Ts_wall[nV];
    elseif modelStructure == ModelStructure.av_b then
      port_a.p = mediums[1].p;
      statesFM[1] = mediums[iLumped].state;
      statesFM[2] = state_b;
      m_flows[nV+1] = flowModel.m_flows[1];
      vsFM[1] = vs*lengths/sum(lengths);
      vsFM[2] = m_flows[nV+1]/Medium.density(state_b)/crossAreas[nV]/nParallel;
         Ts_wFM[1] = Ts_wall[iLumped];
         Ts_wFM[2] = Ts_wall[nV];
    elseif modelStructure == ModelStructure.a_vb then
      m_flows[1] = flowModel.m_flows[1];
      statesFM[1] = state_a;
      statesFM[2] = mediums[iLumped].state;
      port_b.p = mediums[nV].p;
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2] = vs*lengths/sum(lengths);
         Ts_wFM[1] = Ts_wall[1];
         Ts_wFM[2] = Ts_wall[iLumped];
    elseif modelStructure == ModelStructure.a_v_b then
      m_flows[1] = flowModel.m_flows[1];
      statesFM[1] = state_a;
      statesFM[2] = mediums[iLumped].state;
      statesFM[3] = state_b;
      m_flows[nV+1] = flowModel.m_flows[2];
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2] = vs*lengths/sum(lengths);
      vsFM[3] = m_flows[nV+1]/Medium.density(state_b)/crossAreas[nV]/nParallel;
         Ts_wFM[1] = Ts_wall[1];
         Ts_wFM[2] = Ts_wall[iLumped];
         Ts_wFM[3] = Ts_wall[nV];
    else
      assert(false, "Unknown model structure");
    end if;
  else
    if modelStructure == ModelStructure.av_vb then
      //nFM = nV-1
      statesFM[1:nV] = mediums[1:nV].state;
      m_flows[2:nV] = flowModel.m_flows[1:nV-1];
      vsFM[1:nV] = vs;
      port_a.p = mediums[1].p;
      port_b.p = mediums[nV].p;
         Ts_wFM[1:nV] = Ts_wall[1:nV];
    elseif modelStructure == ModelStructure.av_b then
      //nFM = nV
      statesFM[1:nV] = mediums[1:nV].state;
      statesFM[nV+1] = state_b;
      m_flows[2:nV+1] = flowModel.m_flows[1:nV];
      vsFM[1:nV] = vs;
      vsFM[nV+1] = m_flows[nV+1]/Medium.density(state_b)/crossAreas[nV]/nParallel;
      port_a.p = mediums[1].p;
         Ts_wFM[1:nV] = Ts_wall[1:nV];
         Ts_wFM[nV+1] = Ts_wall[nV];
    elseif modelStructure == ModelStructure.a_vb then
      //nFM = nV
      statesFM[1] = state_a;
      statesFM[2:nV+1] = mediums[1:nV].state;
      m_flows[1:nV] = flowModel.m_flows[1:nV];
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2:nV+1] = vs;
      port_b.p = mediums[nV].p;
         Ts_wFM[1] = Ts_wall[1];
         Ts_wFM[2:nV+1] = Ts_wall[1:nV];
    elseif modelStructure == ModelStructure.a_v_b then
      //nFM = nV+1
      statesFM[1] = state_a;
      statesFM[2:nV+1] = mediums[1:nV].state;
      statesFM[nV+2] = state_b;
      m_flows[1:nV+1] = flowModel.m_flows[1:nV+1];
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2:nV+1] = vs;
      vsFM[nV+2] = m_flows[nV+1]/Medium.density(state_b)/crossAreas[nV]/nParallel;
         Ts_wFM[1] = Ts_wall[1];
         Ts_wFM[2:nV+1] = Ts_wall[1:nV];
         Ts_wFM[nV+2] = Ts_wall[nV];
    else
      assert(false, "Unknown model structure");
    end if;
  end if;

  annotation (defaultComponentName="pipe",
Documentation(info="<html>
<p>Base model for distributed flow models. The total volume is split into nV segments along the flow path. The default value is nV=2. </p>
<p>Wall temperature is passed to the flow model as it is needed for some cases. When use_HeatTransfer = false, the wall temperature is assumed to be equal to the medium temperature.</p>
<p><span style=\"font-family: MS Shell Dlg 2;\">It provides the complete balance equations for one-dimensional fluid flow as formulated in <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.BalanceEquations\">UsersGuide.ComponentDefinition.BalanceEquations</a>. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This generic model offers a large number of combinations of possible parameter settings. In order to reduce model complexity, consider defining and/or using a tailored model for the application at hand, such as <a href=\"modelica://Modelica.Fluid.Examples.HeatExchanger.HeatExchangerSimulation\">HeatExchanger</a>.</span></p>
<p>In reality this model is not a partial model BUT it is listed as such so different applications of this model will be generated with proper applications of the parameters, icons, etc. </p>
<h4>Mass and Energy balances</h4>
<p>The mass and energy balances are inherited from <a href=\"modelica://Modelica.Fluid.Interfaces.PartialDistributedVolume\">Interfaces.PartialDistributedVolume</a>. One total mass and one energy balance is formed across each segment according to the finite volume approach. Substance mass balances are added if the medium contains more than one component. </p>
<p>An extending model needs to define the geometry and the difference in heights between the flow segments (static head).</p>
<h4>Momentum balance</h4>
<p>The momentum balance is determined by the <code><b><span style=\"font-family: Courier New,courier;\">FlowModel</span></b></code> component, which can be replaced with any model extended from <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel\">BaseClasses.FlowModels.PartialStaggeredFlowModel</a>. The default setting is <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow\">DetailedPipeFlow</a>. </p>
<p>This considers </p>
<ul>
<li>pressure drop due to friction and other dissipative losses, and</li>
<li>gravity effects for non-horizontal devices.</li>
<li>variation of flow velocity along the flow path, which occur due to changes in the cross sectional area or the fluid density, provided that <code><span style=\"font-family: Courier New,courier;\">flowModel.use_Ib_flows</span></code> is true. </li>
</ul>
<h4>Model Structure</h4>
<p>The momentum balances are formulated across the segment boundaries along the flow path according to the staggered grid approach. The configurable <code><b><span style=\"font-family: Courier New,courier;\">modelStructure</span></b></code> determines the formulation of the boundary conditions at <code><span style=\"font-family: Courier New,courier;\">port_a</span></code> and <code><span style=\"font-family: Courier New,courier;\">port_b</span></code>. The options include (default: av_vb): </p>
<ul>
<li><code><span style=\"font-family: Courier New,courier;\">av_vb</span></code>: Symmetric setting with nV-1 momentum balances between nV flow segments. The ports <code><span style=\"font-family: Courier New,courier;\">port_a</span></code> and <code><span style=\"font-family: Courier New,courier;\">port_b</span></code> expose the first and the last thermodynamic state, respectively. Connecting two or more flow devices therefore may result in high-index DAEs for the pressures of connected flow segments. </li>
<li><code><span style=\"font-family: Courier New,courier;\">a_v_b</span></code>: Alternative symmetric setting with nV+1 momentum balances across nV flow segments. Half momentum balances are placed between <code><span style=\"font-family: Courier New,courier;\">port_a</span></code> and the first flow segment as well as between the last flow segment and <code><span style=\"font-family: Courier New,courier;\">port_b</span></code>. Connecting two or more flow devices therefore results in algebraic pressures at the ports. The specification of good start values for the port pressures is essential for the solution of large nonlinear equation systems.</li>
<li><code><span style=\"font-family: Courier New,courier;\">av_b</span></code>: Asymmetric setting with nV momentum balances, one between nth volume and <code><span style=\"font-family: Courier New,courier;\">port_b</span></code>, potential pressure state at <code><span style=\"font-family: Courier New,courier;\">port_a</span></code></li>
<li><code><span style=\"font-family: Courier New,courier;\">a_vb</span></code>: Asymmetric setting with nV momentum balance, one between first volume and <code><span style=\"font-family: Courier New,courier;\">port_a</span></code>, potential pressure state at <code><span style=\"font-family: Courier New,courier;\">port_b</span></code></li>
</ul>
<p>When connecting two components, e.g., two pipes, the momentum balance across the connection point reduces to </p>
<pre><span style=\"font-family: Courier New,courier;\">pipe1.port_b.p = pipe2.port_a.p</span></pre>
<p>This is only true if the flow velocity remains the same on each side of the connection. Consider using a fitting for any significant change in diameter or fluid density, if the resulting effects, such as change in kinetic energy, cannot be neglected. This also allows for taking into account friction losses with respect to the actual geometry of the connection point. </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The model treats the partial differential equations with the finite volume method and a staggered grid scheme for momentum balances. The default value is nV=2. This results in two lumped mass and energy balances and one lumped momentum balance across the model. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Note that this generally leads to high-index DAEs for pressure states if this model are directly connected to each other, or generally to models with storage exposing a thermodynamic state through the port. This may not be valid if the model is connected to a model with non-differentiable pressure, like a Sources.Boundary_pT with prescribed jumping pressure. The <code></span><span style=\"font-family: Courier New,courier;\">modelStructure</code></span><span style=\"font-family: MS Shell Dlg 2;\"> can be configured as appropriate in such situations, in order to place a momentum balance between a pressure state of the pipe and a non-differentiable boundary condition. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The default <code></span><span style=\"font-family: Courier New,courier;\">modelStructure</code></span><span style=\"font-family: MS Shell Dlg 2;\"> is <code></span><span style=\"font-family: Courier New,courier;\">av_vb</code></span><span style=\"font-family: MS Shell Dlg 2;\"> (see Advanced tab). The simplest possible alternative symmetric configuration, avoiding potential high-index DAEs at the cost of the potential introduction of nonlinear equation systems, is obtained with the setting <code></span><span style=\"font-family: Courier New,courier;\">nV=1, modelStructure=a_v_b</code></span><span style=\"font-family: MS Shell Dlg 2;\">. Depending on the configured model structure, the first and the last segment, or the flow path length of the first and the last momentum balance, are of half size.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Heat Transfer Structure</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The <code></span><span style=\"font-family: Courier New,courier;\">HeatTransfer</code></span><span style=\"font-family: MS Shell Dlg 2;\"> component specifies the source term <code></span><span style=\"font-family: Courier New,courier;\">Qb_flows</code></span><span style=\"font-family: MS Shell Dlg 2;\"> of the energy balance. The default component uses a constant coefficient for the heat transfer between the bulk flow and the segment boundaries exposed through the <code></span><span style=\"font-family: Courier New,courier;\">heatPorts</code></span><span style=\"font-family: MS Shell Dlg 2;\">. The <code></span><span style=\"font-family: Courier New,courier;\">HeatTransfer</code></span><span style=\"font-family: MS Shell Dlg 2;\"> model is replaceable and can be exchanged with any model extended from <a href=\"TRANSFORM.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer\">TRANSFORM.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer</a>. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The intended use is for complex networks of pipes and other flow devices, like valves. See, e.g., </span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes\">Examples.BranchingDynamicPipes</a>, or </span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"modelica://Modelica.Fluid.Examples.IncompressibleFluidNetwork\">Examples.IncompressibleFluidNetwork</a>.</span></li>
</ul>
</html>",
    revisions="<html>
<ul>
<li><i>5 Dec 2008</i>
    by Michael Wetter:<br>
       Modified mass balance for trace substances. With the new formulation, the trace substances masses <code>mC</code> are stored
       in the same way as the species <code>mXi</code>.</li>
<li><i>Dec 2008</i>
    by R&uuml;diger Franke:<br>
       Derived model from original DistributedPipe models
    <ul>
    <li>moved mass and energy balances to PartialDistributedVolume</li>
    <li>introduced replaceable pressure loss models</li>
    <li>combined all model structures and lumped pressure into one model</li>
    <li>new ModelStructure av_vb, replacing former avb</li>
    </ul></li>
<li><i>04 Mar 2006</i>
    by Katrin Pr&ouml;l&szlig;:<br>
       Model added to the Fluid library</li>
</ul>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={Ellipse(
          extent={{-70,10},{-50,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{-100,-50},{-100,50},{100,60},{100,-60},{-100,-50}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-34,-53},{-34,53},{34,57},{34,-57},{-34,-53}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-100,-50},{-100,50}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-99,36},{-69,30}},
          lineColor={0,0,255},
          textString="crossAreas[1]",
          pattern=LinePattern.None),
        Line(
          points={{-100,70},{-34,70}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{0,36},{40,30}},
          lineColor={0,0,255},
          textString="crossAreas[2:nV-1]",
          pattern=LinePattern.None),
        Line(
          points={{100,-60},{100,60}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{100.5,36},{130.5,30}},
          lineColor={0,0,255},
          textString="crossAreas[nV]",
          pattern=LinePattern.None),
        Line(
          points={{-34,52},{-34,-53}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{34,57},{34,-57}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{34,70},{100,70}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{-34,70},{34,70}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-30,77},{30,71}},
          lineColor={0,0,255},
          textString="lengths[2:nV-1]",
          pattern=LinePattern.None),
        Line(
          points={{-100,-70},{0,-70}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{-80,-63},{-20,-69}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="flowModel.dps_fg[1]"),
        Line(
          points={{0,-70},{100,-70}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{20.5,-63},{80,-69}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="flowModel.dps_fg[2:nV-1]"),
        Line(
          points={{-95,0},{-5,0}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{-62,7},{-32,1}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="m_flows[2]"),
        Line(
          points={{5,0},{95,0}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{34,7},{64,1}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="m_flows[3:nV]"),
        Line(
          points={{-150,0},{-105,0}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Line(
          points={{105,0},{150,0}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{-140,7},{-110,1}},
          lineColor={0,0,255},
          textString="m_flows[1]",
          pattern=LinePattern.None),
        Text(
          extent={{111,7},{141,1}},
          lineColor={0,0,255},
          textString="m_flows[nV+1]",
          pattern=LinePattern.None),
        Text(
          extent={{35,-92},{100,-98}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="(ModelStructure av_vb, nV=3)"),
        Line(
          points={{-100,-50},{-100,-86}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{0,-55},{0,-86}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{100,-60},{100,-86}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-5,5},{5,-5}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{3,-4},{33,-10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="states[2:nV-1]"),
        Ellipse(
          extent={{95,5},{105,-5}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{104,-4},{124,-10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="states[nV]"),
        Ellipse(
          extent={{-105,5},{-95,-5}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,-4},{-76,-10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="states[1]"),
        Text(
          extent={{-99.5,30},{-69.5,24}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="dimensions[1]"),
        Text(
          extent={{-0.5,30},{40,24}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="dimensions[2:nV-1]"),
        Text(
          extent={{100.5,30},{130.5,24}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="dimensions[nV]"),
        Line(
          points={{-34,73},{-34,52}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{34,73},{34,57}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,50},{100,60}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-100,-50},{100,-60}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-100,73},{-100,50}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{100,73},{100,60}},
          smooth=Smooth.None,
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{0,-55},{0,55}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{-34,11},{34,11}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{5,18},{25,12}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="vs[2:nV-1]"),
        Text(
          extent={{-72,18},{-62,12}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="vs[1]"),
        Line(
          points={{-100,11},{-34,11}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{63,18},{73,12}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="vs[nV]"),
        Line(
          points={{34,11},{100,11}},
          arrow={Arrow.None,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{-80,-75},{-20,-81}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="flowModel.lengthsFM[1]"),
        Line(
          points={{-100,-82},{0,-82}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0}),
        Line(
          points={{0,-82},{100,-82}},
          arrow={Arrow.Filled,Arrow.Filled},
          color={0,0,0}),
        Text(
          extent={{15,-75},{85,-81}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="flowModel.lengthsFM[2:nV-1]"),
        Text(
          extent={{-100,77},{-37,71}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="lengths[1]"),
        Text(
          extent={{34,77},{100,71}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          textString="lengths[nV]")}));
end PartialTwoPortFlow;
