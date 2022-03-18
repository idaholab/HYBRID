within NHES.Nuclear.CoreSubchannels;
model Pebble_Bed_2_DNE
  "0-D point kinetics fuel channel model with three solid media regions including a hot channel calculation routine."
  import TRANSFORM;

  import TRANSFORM.Math.linspace_1D;
  import TRANSFORM.Math.linspaceRepeat_1D;
  import Modelica.Fluid.Types.ModelStructure;
  import TRANSFORM.Fluid.Types.LumpedLocation;
  import Modelica.Fluid.Types.Dynamics;

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium = Medium,m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow    port_b(redeclare package Medium = Medium,m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
            {110,10}})));

  parameter Real nParallel=1 "Number of identical parallel coolant channels";

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Coolant medium" annotation (choicesAllMatching=true);
  replaceable package Material_1 =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
      annotation (choicesAllMatching=true);
  replaceable package Material_2 =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
      annotation (choicesAllMatching=true);
  replaceable package Material_3 =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
    annotation (choicesAllMatching=true);

  replaceable model Geometry =
      TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    constrainedby
    TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    "Geometry" annotation (Dialog(group="Geometry"),choicesAllMatching=true);

  Geometry geometry(final nRegions=3)
    annotation (Placement(transformation(extent={{-96,82},{-80,98}})));

  replaceable model FlowModel =
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
    constrainedby
    TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
    "Coolant flow models (i.e., momentum, pressure loss, wall friction)"
    annotation (choicesAllMatching=true, Dialog(group="Pressure Loss"));

  replaceable model HeatTransfer =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
    constrainedby
    TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
    "Coolant coefficient of heat transfer" annotation (choicesAllMatching=true,
      Dialog(group="Heat Transfer"));

  /* Kinetics */
  parameter SI.Power Q_nominal=1e6
    "Total nominal reactor power (fission + decay)";
  parameter Boolean specifyPower=false
    "=true to specify power (i.e., no der(P) equation)";
  parameter TRANSFORM.Units.NonDim SF_start_power[geometry.nV]=fill(1/geometry.nV,
      geometry.nV) "Shape factor for the power profile, sum(SF) = 1";
  replaceable record Data_PG =
      TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_TRACEdefault
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.PartialPrecursorGroup
    annotation (choicesAllMatching=true,Dialog(tab="Kinetics",group="Neutron Kinetics"));
  replaceable record Data_DH =
      TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_0
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.PartialDecayHeat_powerBased
    annotation (choicesAllMatching=true,Dialog(tab="Kinetics",group="Decay-Heat"));
  replaceable record Data_FP =
      TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_0
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.PartialFissionProduct                                                                        annotation (
     choicesAllMatching=true,Dialog(tab="Kinetics",group="Fission Products"));
  parameter SI.Area sigmasA_add_start[Medium.nC]=fill(0, Medium.nC)
    "Microscopic absorption cross-section for reactivity feedback" annotation(Dialog(tab="Kinetics",group="Fluid Trace Substances"));
  input SI.Power Q_fission_input=Q_nominal
    "Fission power (if specifyPower=true)" annotation (Dialog(group="Input"));
  input SI.Power Q_external=0
    "Power from external source of neutrons" annotation (Dialog(group="Input"));
  input TRANSFORM.Units.NonDim rho_input=0 "External Reactivity"
    annotation (Dialog(group="Input"));
  parameter SI.Area dsigmasA_add[Medium.nC]=fill(0, Medium.nC)
    "Change in microscopic absorption cross-section for reactivity feedback"
    annotation (Dialog(tab="Parameter Change",group="Input: Fluid Trace Substances"));
  parameter SI.Time Lambda_start=1e-5 "Prompt neutron generation time"
    annotation (Dialog(tab="Kinetics",group="Neutron Kinetics"));
  parameter Boolean use_history=false "=true to provide power history"
                                                                      annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
  parameter SI.Power history[:,2]=fill(
      0,
      0,
      2) "Power history up to simulation time=0, [t,Q]" annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
  parameter Boolean includeDH=false
    "=true if power history includes decay heat" annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
  parameter SI.Power Q_fission_start=Q_nominal/(1 + sum(kinetics.efs_dh_start))
    "Initial reactor fission power" annotation (Dialog(tab="Kinetics",group="Neutron Kinetics"));
  parameter SI.Power Cs_pg_start[kinetics.nC]={kinetics.betas_start[j]/(kinetics.lambdas_start[
      j]*Lambda_start)*Q_fission_start for j in 1:kinetics.nC}
    "Power of the initial delayed-neutron precursor concentrations" annotation (Dialog(tab="Kinetics",group="Neutron Kinetics"));
  parameter SI.Energy Es_start[kinetics.nDH]={Q_fission_start*kinetics.efs_dh_start[
      j]/kinetics.lambdas_dh_start[j] for j in 1:kinetics.nDH}
    "Initial decay heat group energy" annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
  parameter TRANSFORM.Units.ExtraPropertyExtrinsic mCs_fp_start[kinetics.nFP]=
      TRANSFORM.Nuclear.ReactorKinetics.Functions.Initial_FissionProducts(
      kinetics.fissionProducts.nC,
      kinetics.fissionProducts.nFS,
      kinetics.fissionProducts.nT,
      kinetics.fissionProducts.parents,
      kinetics.fissionSources_start,
      kinetics.fissionProducts.fissionTypes_start,
      kinetics.fissionProducts.w_f_start,
      kinetics.fissionProducts.SigmaF_start,
      kinetics.fissionProducts.sigmasA_start,
      kinetics.fissionProducts.fissionYields_start,
      kinetics.fissionProducts.lambdas_start,
      fill(1e10, kinetics.fissionProducts.nC),
      kinetics.fissionProducts.Q_fission_start,
      kinetics.fissionProducts.V_start)
    "Number of fission product atoms per group"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
  input TRANSFORM.Units.InverseTime dlambdas[kinetics.nC]=fill(0, kinetics.nC)
    "Change in decay constants for each precursor group" annotation (Dialog(tab=
         "Parameter Change", group="Input: Neutron Kinetics"));
  input TRANSFORM.Units.NonDim dalphas[kinetics.nC]=fill(0, kinetics.nC)
    "Change in normalized precursor fractions [betas = alphas*Beta]"
    annotation (Dialog(tab="Parameter Change", group="Input: Neutron Kinetics"));
  input TRANSFORM.Units.NonDim dBeta=0
    "Change in effective delayed neutron fraction [e.g., Beta = sum(beta_i)]"
    annotation (Dialog(tab="Parameter Change", group="Input: Neutron Kinetics"));
  input SI.Time dLambda=0 "Change in prompt neutron generation time" annotation(Dialog(tab="Parameter Change",group="Input: Neutron Kinetics"));
  input TRANSFORM.Units.InverseTime dlambdas_dh[kinetics.nDH]=fill(0, kinetics.nDH)
    "Change in decay constant"
    annotation (Dialog(tab="Parameter Change", group="Input: Decay-Heat"));
  input TRANSFORM.Units.NonDim defs_dh[kinetics.nDH]=fill(0, kinetics.nDH)
    "Change in effective energy fraction"
    annotation (Dialog(tab="Parameter Change", group="Input: Decay-Heat"));

  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_fuel=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_coolant=-20e-5
    "Moderator feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter SI.Temperature Teffref_fuel "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter SI.Temperature Teffref_coolant "Coolant reference temperature"
                                    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));

  parameter TRANSFORM.Units.NonDim fissionSources_start[kinetics.nFS]=fill(1/
      kinetics.nFS, kinetics.nFS)
    "Source of fissile material fractional composition (sum=1)"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
  parameter TRANSFORM.Units.NonDim fissionTypes_start[kinetics.nFS,kinetics.nT]=
     fill(
      1/kinetics.nT,
      kinetics.nFS,
      kinetics.nT)
    "Fraction of fission from each fission type per fission source, sum(row) = 1"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
  parameter TRANSFORM.Units.NonDim nu_bar_start=2.4 "Neutrons per fission"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
  parameter SI.Energy w_f_start=200e6*1.6022e-19 "Energy released per fission" annotation(Dialog(tab="Kinetics",group="Fission Products"));
  parameter SI.MacroscopicCrossSection SigmaF_start=1
    "Macroscopic fission cross-section of fissile material" annotation(Dialog(tab="Kinetics",group="Fission Products"));
  input TRANSFORM.Units.NonDim dfissionSources[kinetics.nFS]=fill(0, kinetics.nFS)
    "Change in source of fissile material fractional composition (sum=1)"
    annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
  input TRANSFORM.Units.NonDim dfissionTypes[kinetics.nFS,kinetics.nT]=fill(
      0,
      kinetics.nFS,
      kinetics.nT)
    "Change in fraction of fission from each fission type per fission source, sum(row) = 1"
    annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
  input TRANSFORM.Units.NonDim dnu_bar=0 "Change in neutrons per fission"
    annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
  input SI.Energy dw_f=0 "Change in energy released per fission" annotation(Dialog(tab="Parameter Change",group="Input: Fission Products"));
  input SI.MacroscopicCrossSection dSigmaF=0
    "Change in macroscopic fission cross-section of fissile material" annotation(Dialog(tab="Parameter Change",group="Input: Fission Products"));
  input SI.Area dsigmasA[kinetics.nFP]=fill(0, kinetics.nFP)
    "Change in microscopic absorption cross-section for reactivity feedback" annotation(Dialog(tab="Parameter Change",group="Input: Fission Products"));
  input Real dfissionYields[kinetics.nFP,kinetics.nFS,kinetics.nT]=fill(
      0,
      kinetics.nFP,
      kinetics.nFS,
      kinetics.nT)
    "Change in # fission product atoms yielded per fission per fissile source [#/fission]" annotation(Dialog(tab="Parameter Change",group="Input: Fission Products"));
  input TRANSFORM.Units.InverseTime dlambdas_FP[kinetics.nFP]=fill(0, kinetics.nFP)
    "Change in decay constants for each fission product" annotation (Dialog(tab=
         "Parameter Change", group="Input: Fission Products"));

  // Fuel Initialization
  parameter SI.Temperature T_start_1=Material_1.T_default "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature T_start_2=Material_1.T_default "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature T_start_3=Material_1.T_default
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));

  parameter SI.Temperature Ts_start_1[geometry.nRs[1],geometry.nV]=fill(
      T_start_1,
      geometry.nRs[1],
      geometry.nV) "Fuel temperatures"     annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_2[geometry.nRs[2],geometry.nV]=[{Ts_start_1
      [end, :]}; fill(
      T_start_2,
      geometry.nRs[2] - 1,
      geometry.nV)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_3[geometry.nRs[3],geometry.nV]=[{
      Ts_start_2[end, :]}; fill(
      T_start_3,
      geometry.nRs[3] - 1,
      geometry.nV)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));

  //Hot Channel initialization

  // Fuel Initialization
  parameter SI.Temperature T_start_1_Hotchannel=Material_1.T_default "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature T_start_2_Hotchannel=Material_1.T_default "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature T_start_3_Hotchannel=Material_1.T_default
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));

  parameter SI.Temperature Ts_start_1_Hotchannel[geometry.nRs[1],n_hot]=fill(
      T_start_1_Hotchannel,
      geometry.nRs[1],
      n_hot) "Fuel temperatures"     annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_2_Hotchannel[geometry.nRs[2],n_hot]=[{Ts_start_1_Hotchannel
      [end, :]}; fill(
      T_start_2_Hotchannel,
      geometry.nRs[2] - 1,
      n_hot)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_3_Hotchannel[geometry.nRs[3],n_hot]=[{
      Ts_start_2_Hotchannel[end, :]}; fill(
      T_start_3_Hotchannel,
      geometry.nRs[3] - 1,
      n_hot)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));

      // Coolant Initialization
  parameter SI.AbsolutePressure[geometry.nV] ps_start=linspace_1D(
      p_a_start,
      p_b_start,
      geometry.nV) "Pressure" annotation (Dialog(tab="Coolant Initialization",
        group="Start Value: Absolute Pressure"));
  parameter SI.AbsolutePressure p_a_start=Medium.p_default
    "Pressure at port a" annotation (Dialog(tab="Coolant Initialization", group="Start Value: Absolute Pressure"));
  parameter SI.AbsolutePressure p_b_start=p_a_start + (if m_flow_a_start > 0 then -1e3 elseif m_flow_a_start < 0 then -1e3 else 0)
    "Pressure at port b" annotation (Dialog(tab="Coolant Initialization", group="Start Value: Absolute Pressure"));

  parameter Boolean use_Ts_start=true
    "Use T_start if true, otherwise h_start" annotation (Evaluate=true, Dialog(
        tab="Coolant Initialization", group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start[geometry.nV]=linspace_1D(
      T_a_start,
      T_b_start,
      geometry.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Coolant Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start));
  parameter SI.Temperature T_a_start=Medium.T_default
    "Temperature at port a" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start));
  parameter SI.Temperature T_b_start=T_a_start
    "Temperature at port b" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Temperature",
      enable=use_Ts_start));

  parameter SI.SpecificEnthalpy[geometry.nV] hs_start=if not
      use_Ts_start then linspace_1D(
      h_a_start,
      h_b_start,
      geometry.nV) else {Medium.specificEnthalpy_pTX(
      ps_start[i],
      Ts_start[i],
      Xs_start[i, 1:Medium.nX]) for i in 1:geometry.nV}
    "Specific enthalpy" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start));
  parameter SI.SpecificEnthalpy h_a_start=Medium.specificEnthalpy_pTX(
      p_a_start,
      T_a_start,
      X_a_start) "Specific enthalpy at port a" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start));
  parameter SI.SpecificEnthalpy h_b_start=Medium.specificEnthalpy_pTX(
      p_b_start,
      T_b_start,
      X_b_start) "Specific enthalpy at port b" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Specific Enthalpy",
      enable=not use_Ts_start));

  parameter SI.MassFraction Xs_start[geometry.nV,Medium.nX]=
      linspaceRepeat_1D(
      X_a_start,
      X_b_start,
      geometry.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Species Mass Fraction",
      enable=Medium.nXi > 0));
  parameter SI.MassFraction X_a_start[Medium.nX]=Medium.X_default
    "Mass fraction at port a" annotation (Dialog(tab="Coolant Initialization",
        group="Start Value: Species Mass Fraction"));
  parameter SI.MassFraction X_b_start[Medium.nX]=X_a_start
    "Mass fraction at port b" annotation (Dialog(tab="Coolant Initialization",
        group="Start Value: Species Mass Fraction"));

  parameter SI.MassFraction Cs_start[geometry.nV,Medium.nC]=
      linspaceRepeat_1D(
      C_a_start,
      C_b_start,
      geometry.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Start Value: Trace Substances Mass Fraction",
      enable=Medium.nC > 0));
  parameter SI.MassFraction C_a_start[Medium.nC]=fill(0, Medium.nC)
    "Mass fraction at port a" annotation (Dialog(tab="Coolant Initialization",
        group="Start Value: Trace Substances Mass Fraction"));
  parameter SI.MassFraction C_b_start[Medium.nC]=C_a_start
    "Mass fraction at port b" annotation (Dialog(tab="Coolant Initialization",
        group="Start Value: Trace Substances Mass Fraction"));

  parameter SI.MassFlowRate[geometry.nV + 1] m_flows_start=linspace(
      m_flow_a_start,
      -m_flow_b_start,
      geometry.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(tab="Coolant Initialization",
        group="Start Value: Mass Flow Rate"));
  parameter SI.MassFlowRate m_flow_a_start=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Coolant Initialization", group="Start Value: Mass Flow Rate"));
  parameter SI.MassFlowRate m_flow_b_start=-m_flow_a_start
    "Mass flow rate at port_b" annotation (Dialog(tab="Coolant Initialization",
        group="Start Value: Mass Flow Rate"));

  // Advanced
  parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial
    "Formulation of energy balances {coolant}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics energyDynamics_fuel=Dynamics.DynamicFreeInitial
    "Formulation of energy balances {fuel}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics massDynamics=energyDynamics
    "Formulation of mass balances {coolant}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics traceDynamics=massDynamics
    "Formulation of trace substance balances {coolant}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics momentumDynamics=Dynamics.SteadyState "Formulation of momentum balances {coolant}"
    annotation (Dialog(tab="Advanced", group="Dynamics"));

  parameter Dynamics kineticDynamics=energyDynamics_fuel
    "Formulation of nuclear kinetics balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
  parameter Dynamics precursorDynamics=kineticDynamics
    "Formulation of neutron precursor balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
  parameter Dynamics decayheatDynamics=kineticDynamics
    "Formulation of decay-heat balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
  parameter Dynamics fissionProductDynamics=kineticDynamics
    "Formulation of fission product balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Advanced", group="Coolant"));
  parameter Boolean exposeState_a=true
    "=true, p is calculated at port_a else m_flow"
    annotation (Dialog(tab="Advanced", group="Coolant"));
  parameter Boolean exposeState_b=false
    "=true, p is calculated at port_b else m_flow"
    annotation (Dialog(tab="Advanced", group="Coolant"));
  parameter Boolean useLumpedPressure=false
    "=true to lump pressure states together"
    annotation (Dialog(tab="Advanced", group="Coolant"), Evaluate=true);
  parameter LumpedLocation lumpPressureAt=LumpedLocation.port_a
    "Location of pressure for flow calculations" annotation (Dialog(
      tab="Advanced",
      group="Coolant",
      enable=if useLumpedPressure and modelStructure <>
          ModelStructure.av_vb then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties=false
    "=true to take port properties for flow models from internal control volumes"
    annotation (Dialog(tab="Advanced", group="Coolant"), Evaluate=true);

  // Visualization
  parameter Boolean showName = true annotation(Dialog(tab="Visualization"));
  parameter Boolean showDesignFlowDirection = true annotation(Dialog(tab="Visualization"));

  Real SF_mC_add[geometry.nV,Medium.nC] = {{coolantSubchannel.mCs[i, j]/sum(coolantSubchannel.mCs[:, j]) for j in 1:Medium.nC} for i in 1:geometry.nV};

  Modelica.Blocks.Sources.RealExpression Q_total(y=kinetics.Q_total)
    "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{50,40},{34,50}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface coolantSubchannel(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nParallel,
    massDynamics=massDynamics,
    momentumDynamics=momentumDynamics,
    allowFlowReversal=allowFlowReversal,
    redeclare model FlowModel = FlowModel,
    redeclare model HeatTransfer = HeatTransfer,
    useLumpedPressure=useLumpedPressure,
    lumpPressureAt=lumpPressureAt,
    useInnerPortProperties=useInnerPortProperties,
    use_Ts_start=use_Ts_start,
    T_a_start=T_a_start,
    T_b_start=T_b_start,
    Ts_start=Ts_start,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start,
    ps_start=ps_start,
    Ts_wall(start={{fuelModel[i].Pebble_Surface_Init for j in 1:
          coolantSubchannel.heatTransfer.nSurfaces} for i in 1:
          coolantSubchannel.nV}),
    Xs_start=Xs_start,
    Cs_start=Cs_start,
    X_a_start=X_a_start,
    X_b_start=X_b_start,
    C_a_start=C_a_start,
    C_b_start=C_b_start,
    m_flow_a_start=m_flow_a_start,
    m_flow_b_start=m_flow_b_start,
    m_flows_start=m_flows_start,
    exposeState_a=exposeState_a,
    exposeState_b=exposeState_b,
    energyDynamics=energyDynamics,
    traceDynamics=traceDynamics,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        nV=geometry.nV,
        dimension=geometry.dimension,
        crossArea=geometry.crossArea,
        perimeter=geometry.perimeter,
        length=geometry.length,
        roughness=geometry.roughness,
        surfaceArea=geometry.surfaceArea,
        dheight=geometry.dheight,
        nSurfaces=geometry.nSurfaces,
        height_a=geometry.height_a,
        angle=geometry.angle),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens={{SF_mC_add[i, j]*kinetics.fissionProducts.mC_gens_add[j] for
            j in 1:Medium.nC} for i in 1:coolantSubchannel.nV})) annotation (
      Placement(transformation(
        extent={{-15,-13},{15,13}},
        rotation=0)));

  FuelModels.TRISO_Pebble fuelModel[geometry.nV](
    redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Material = Media.Solids.Graphite_5,
    energyDynamics=energyDynamics_fuel) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,26})));

  TRANSFORM.Blocks.ShapeFactor shapeFactor(n=geometry.nV, SF_start=
        SF_start_power)
    annotation (Placement(transformation(extent={{24,40},{14,50}})));
  parameter Boolean toggle_ReactivityFP=true
    "=true to include fission product reacitivity feedback"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
//   Medium.SaturationProperties sat "Saturation properties";
//
   parameter Real Fh=1.0 "Hot Channel Peaking Factor in the radial direction (NuScale nomenclature of Fh and not Fr)"
    annotation (Dialog(tab="Hot Channel", group="parameters"));
//    SI.MassFlowRate hot_channel_flow = Mass_Sensor.m_flow;
//    SI.Temperature T_hotchannel[n_hot] = fill(sat.Tsat,n_hot);

   //SI.Temperature T_hotchannel[n_hot]; //= Hot_Channel_Calculations.T_hot[n_hot];

//); //{T_inlet + Q_total.y*sum(Q_shape[j] for j in 1:i)/(nParallel*cp*hot_channel_flow) for i in 1:n_hot};

     //Addition of Thom Correlation.
//    parameter Real m=4 "Thom Correlation Exponent";
//    Real tilda = (Modelica.Constants.e^(4.0*TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(port_a.p)/900.0))/(60.0^4.0);
//    Real T_co_F[n_hot]= { TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degF(T_hotchannel[i]) + (tilda^(-1.0/m))*((Q_shape[i]*Q_total.y*Fh/(geometry.surfaceArea[1]*nParallel)/10e6)^(1.0/m)) for i in 1:n_hot};
//    SI.Temperature T_co[n_hot] = {TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degF(T_co_F[i]) for i in 1:n_hot};

//
//   SI.HeatFlux qflux[geometry.nV]={(coolantSubchannel.heatPorts[i,1].Q_flow/(nParallel*geometry.surfaceArea[1]/geometry.nV)/1000.0)*(3.17e-04) for i in 1:geometry.nV}  "MBtu/hr*ft^2";  //[kW/m^2]Pick up here.
//   SI.HeatFlux q_avg=(Q_total.y/(geometry.surfaceArea[1]*nParallel)/1000.0)*(3.17e-04) "MBtu/hr*ft^2";  //W/m^2
//
//   Real x[geometry.nV] = {((coolantSubchannel.H_flows[i]/coolantSubchannel.m_flows[i])-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat))
//             /(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat)-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat)) for i in 1:geometry.nV};
//
//  // Real hf = Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat);
//  // Real hg = Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat);
//
//   //Need a new routine for enthalpy in the hot channel......
//   //Can add in shape factor for this piece.
   parameter Integer n_hot = 10 annotation (Dialog(tab="Hot Channel", group="parameters"));
//   SI.SpecificEnthalpy h_hot[n_hot];
//
   parameter Real Q_shape[n_hot] = fill(1/n_hot,n_hot) "Flux profile over n_hot variables"
    annotation (Dialog(tab="Hot Channel", group="parameters"));

   input SI.Temperature T_inlet=300 annotation (Dialog(tab="General", group="Input"));
   input SI.Temperature T_outlet=300 annotation (Dialog(tab="General", group="Input"));
//   Real cp = 1;
//   //parameter Integer n=1 "Output array size";
//
//   //parameter Real SF_start[n] = fill(1/n,n) "Initial shape function, sum(SF) = 1";
//
//   Real x_inlet = ((coolantSubchannel.H_flows[1]/coolantSubchannel.m_flows[1])-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat))
//             /(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat)-Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat));
//   SI.Pressure Pcrit = 22064000;
//   Real Mass_Flux = (coolantSubchannel.m_flows[1]/geometry.crossArea);//*737.338; //kg/sec/m^2 to lbm/hr*ft^2
//   Real P_red = port_a.p/(Pcrit);
//
//   Real x_hot[n_hot];
//   SI.HeatFlux qflux_hot[n_hot];
//   SI.HeatFlux CHF_hot[n_hot];
//   Real DNBR_hot[n_hot];
//
//   Real debug1, debug2;
//
//   SI.HeatFlux CHF[geometry.nV]={TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.CHF.EPRI_flux(qflux[i], q_avg, x[i],Mass_Flux,x_inlet, P_red) for i in 1:geometry.nV};
//   //Real DNBR[geometry.nV] = {qflux[i,1]/(CHF[i]*3.169983306e-7) for i in 1:geometry.nV};
//   Real DNBR[geometry.nV] = {(CHF[i]*3.169983306e-7/qflux[i]) for i in 1:geometry.nV};

// equation
//   sat.psat = port_a.p;
//   sat.Tsat = Modelica.Media.Water.WaterIF97_base.saturationTemperature(port_a.p);
//

//Hot Channel enthalpy rise.
//    h_hot[1]:=coolantSubchannel.port_a.h_outflow; //Should be going in the right direction.;
//   for i in 2:n_hot loop
//     h_hot[i]:=h_hot[i - 1] + Fh*Q_shape[i]*Q_total.y/(coolantSubchannel.m_flows[1]*nParallel);
//
//     x_hot[i]:=(h_hot[i] - Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(
//       sat))/(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat) -
//       Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat));
//
//     debug1 :=Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat);
//
//     debug2 :=(Modelica.Media.Water.WaterIF97_base.dewEnthalpy(sat) -
//       Modelica.Media.Water.WaterIF97_base.bubbleEnthalpy(sat));
//
//     qflux_hot[i]:=Fh*(Q_shape[i]/(1/n_hot))*q_avg;
//     CHF_hot[i] :=
//       TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.CHF.EPRI_flux(
//       qflux_hot[i],
//       q_avg,
//       x_hot[i],
//       Mass_Flux,
//       x_inlet,
//       P_red);
//
//   DNBR_hot[i]:=(CHF_hot[i]*3.169983306e-7/qflux_hot[i]);
//   end for;

  Modelica.Fluid.Sensors.MassFlowRate Mass_Sensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  TRANSFORM.Nuclear.ReactorKinetics.PointKinetics_L1_powerBased kinetics(
    Q_nominal=Q_nominal,
    specifyPower=specifyPower,
    redeclare record Data_DH = Data_DH,
    redeclare record Data_FP = Data_FP,
    nC_add=Medium.nC,
    sigmasA_add_start=sigmasA_add_start,
    redeclare record Data = Data_PG,
    dsigmasA_add=dsigmasA_add,
    Lambda_start=Lambda_start,
    use_history=use_history,
    history=history,
    includeDH=includeDH,
    nFeedback=1,
    dlambdas=dlambdas,
    dalphas=dalphas,
    dBeta=dBeta,
    dLambda=dLambda,
    dlambdas_dh=dlambdas_dh,
    defs_dh=defs_dh,
    fissionSources_start=fissionSources_start,
    fissionTypes_start=fissionTypes_start,
    nu_bar_start=nu_bar_start,
    w_f_start=w_f_start,
    SigmaF_start=SigmaF_start,
    dfissionSources=dfissionSources,
    dfissionTypes=dfissionTypes,
    dnu_bar=dnu_bar,
    dw_f=dw_f,
    dSigmaF=dSigmaF,
    dsigmasA=dsigmasA,
    dfissionYields=dfissionYields,
    dlambdas_FP=dlambdas_FP,
    energyDynamics=kineticDynamics,
    traceDynamics=precursorDynamics,
    decayheatDynamics=decayheatDynamics,
    fissionProductDynamics=fissionProductDynamics,
    Q_fission_input=Q_fission_input,
    Q_external=Q_external,
    rho_input=rho_input,
    alphas_feedback={alpha_fuel},
    vals_feedback={sum(fuelModel.T_Kernel_outer)/geometry.nV},
    vals_feedback_reference={Teffref_fuel},
    Q_fission_start=Q_fission_start,
    Cs_start=Cs_pg_start,
    Es_start=Es_start,
    V=fuelModel.nKernel_per_Pebble*sum(fuelModel.nPebble_per_region)*4/3*
        Modelica.Constants.pi*fuelModel.r_Fuel,
    mCs_start=mCs_fp_start,
    mCs_add={sum(coolantSubchannel.mCs[:, j])*coolantSubchannel.nParallel for j in
            1:Medium.nC},
    Vs_add=fuelModel.nKernel_per_Pebble*sum(fuelModel.nPebble_per_region)*4/3*
        Modelica.Constants.pi*fuelModel.r_Fuel,
    toggle_ReactivityFP=toggle_ReactivityFP)
    annotation (Placement(transformation(extent={{-78,80},{-58,100}})));
equation
 //  sat.psat = port_a.p;
  // sat.Tsat = Modelica.Media.Water.WaterIF97_base.saturationTemperature(port_a.p);
  connect(port_a, coolantSubchannel.port_a) annotation (Line(points={{-100,0},{
          -15,0}},                         color={0,127,255}));
  connect(shapeFactor.u, Q_total.y)
    annotation (Line(points={{25,45},{33.2,45}}, color={0,0,127}));
  connect(coolantSubchannel.port_b, Mass_Sensor.port_a) annotation (Line(points={{15,0},{
          52,0}},                           color={0,127,255}));
  connect(Mass_Sensor.port_b, port_b)
    annotation (Line(points={{72,0},{100,0}}, color={0,127,255}));

//algorithm
//
//
//       for i in 1:n_hot loop
//         T_hotchannel[i] :=Hot_Channel_Calculations.T_hot[i];
//       end for;

//     h_hot[1]:=coolantSubchannel.port_a.h_outflow; //Should be going in the right direction.;
//    for i in 2:n_hot loop
//      h_hot[i]:=h_hot[i - 1] + Fh*Q_shape[i]*Q_total.y/(coolantSubchannel.m_flows[1]*nParallel);
 //  end for;

//      T_hotchannel[1] :=T_inlet;
//
//      // T_hotchannel[1] :=Medium.temperature_phX(coolantSubchannel.port_a.p,coolantSubchannel.port_a.h_outflow,1.0);
//       for i in 2:n_hot loop
//
//        T_hotchannel[i]:=T_hotchannel[i - 1] + (h_hot[i] - h_hot[i - 1])/1.0;
//       end for;

  connect(fuelModel.Power_in, shapeFactor.y)
    annotation (Line(points={{0,37},{0,45},{13.5,45}}, color={0,0,127}));
  connect(fuelModel.heatPorts_b, coolantSubchannel.heatPorts[:, 1]) annotation (
     Line(points={{0.1,15.8},{0.1,10.9},{0,10.9},{0,6.5}}, color={127,0,0}));
  annotation (defaultComponentName="coreSubchannel",
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),        Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={        Ellipse(
          extent={{-92,30},{-108,-30}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_a),
        Ellipse(
          extent={{108,30},{92,-30}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_b),    Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,24},{100,-24}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-65,5},{-55,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{55,5},{65,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,40},{30,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-30,40},{-30,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-149,-68},{151,-108}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true,showName)),
        Polygon(
          points={{20,-45},{60,-60},{20,-75},{20,-45}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true,showDesignFlowDirection)),
        Polygon(
          points={{20,-50},{50,-60},{20,-70},{20,-50}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true,showDesignFlowDirection)),
        Line(
          points={{55,-60},{-60,-60}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=DynamicSelect(true,showDesignFlowDirection))}));
end Pebble_Bed_2_DNE;
