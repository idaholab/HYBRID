within NHES.Nuclear.CoreSubchannels;
model SFR
  "0-D point kinetics fuel channel model with three solid media regions including a hot channel calculation routine."
  import TRANSFORM;

  import TRANSFORM.Math.linspace_1D;
  import TRANSFORM.Math.linspaceRepeat_1D;
  import Modelica.Fluid.Types.ModelStructure;
  import TRANSFORM.Fluid.Types.LumpedLocation;
  import Modelica.Fluid.Types.Dynamics;
  parameter Boolean kinetics_volume = false;
  parameter Real Power_Prod_Frac[4] = {0.24, 0.48, 0.1, 0.18} "Power production in the inner fuel, outer fuel, inner blanket, and outer blanket respectively.";



  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow    port_b(redeclare package Medium = Medium) annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
            {110,10}})));

  parameter Integer nAssembliesIF=1 "Number of identical parallel assemblies in the inner fuel region, min = 1";
  parameter Integer nAssembliesOF=1 "Number of identical parallel assemblies in the inner fuel region, min = 1";
  parameter Integer nAssembliesIRB=1 "Number of identical parallel assemblies in the inner reflector region, min = 1";
  parameter Integer nAssembliesRB=1 "Number of identical parallel assemblies in the outer reflector region, min = 1";
  parameter Integer nTotalAssemblies = nAssembliesIF+nAssembliesIRB+nAssembliesOF+nAssembliesRB annotation(Dialog(enable = false));
  parameter Modelica.Units.SI.Length r_outer_fuel = 0.0039;
  parameter Modelica.Units.SI.Length r_outer_gap =  0.0041;
  parameter Modelica.Units.SI.Length r_outer_clad = 0.0055;


  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Coolant medium" annotation (choicesAllMatching=true);
  replaceable package Rods_IF =
      NHES.Media.Interfaces.PartialAlloy "Power producing material in inner fuel region"
      annotation (choicesAllMatching=true);
  replaceable package Rods_OF =
      NHES.Media.Interfaces.PartialAlloy "Power producing material in outer fuel region"
      annotation (choicesAllMatching=true);
  replaceable package Rods_IRB =
      NHES.Media.Interfaces.PartialAlloy "Incidental power producing material in internal reflectors region"
    annotation (choicesAllMatching=true);

  replaceable package Rods_RB =
     NHES.Media.Interfaces.PartialAlloy "Incidental power producing material in external reflectors region"
      annotation (choicesAllMatching=true);
  replaceable package Fuel_gap_material =
      NHES.Media.Interfaces.PartialAlloy "Gap material within rods, assumed to be the same throughout the core"
      annotation (choicesAllMatching=true);
  replaceable package Fuel_Cladding =
      NHES.Media.Interfaces.PartialAlloy "Cladding material on rods, assumed to be the same throughout the core"
    annotation (choicesAllMatching=true);



  replaceable model Geometry =
      NHES.Nuclear.New_Geometries.Generic_SFR
    constrainedby
    TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    "Geometry" annotation (Dialog(group="Geometry"),choicesAllMatching=true);

  Geometry geometry(final nRegions=3)
            annotation (Placement(transformation(extent={{-100,78},{-80,98}})));

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
  parameter TRANSFORM.Units.NonDim SF_start_power[Geometry_1.nV]=
                                                               fill(1/geometry.nV,
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
    TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.PartialFissionProduct
                                                                                                                                                        annotation (
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

  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_IF=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_OF=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_IRB=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_RB=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_coolant=-20e-5
    "Moderator feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter SI.Temperature Teffref_fuel_IF = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
                                   parameter SI.Temperature Teffref_fuel_OF = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
                                   parameter SI.Temperature Teffref_fuel_IRB = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
                                   parameter SI.Temperature Teffref_fuel_RB = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter SI.Temperature Teffref_coolant = 823.15 "Coolant reference temperature"
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
  parameter SI.Temperature T_Fuel_Init = 1073.15 "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature T_Gap_Init = 973.15 "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature T_Clad_Init = 923.15
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));

  parameter SI.Temperature Ts_start_1[Geometry_1.nRs[1],Geometry_1.nV]=
                                                                   fill(
      T_Fuel_Init,
      geometry.nRs[1],
      geometry.nV) "Fuel temperatures"     annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_2[Geometry_1.nRs[2],Geometry_1.nV]=
                                                                   [{Ts_start_1
      [end, :]}; fill(
      T_Gap_Init,
      geometry.nRs[2] - 1,
      geometry.nV)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));
  parameter SI.Temperature Ts_start_3[Geometry_1.nRs[3],Geometry_1.nV]=
                                                                   [{
      Ts_start_2[end, :]}; fill(
      T_Clad_Init,
      geometry.nRs[3] - 1,
      geometry.nV)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature"));


      // Coolant Initialization
  parameter SI.AbsolutePressure[Geometry_1.nV]
                                             ps_start=linspace_1D(
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
  parameter SI.Temperature Ts_start[Geometry_1.nV]=
                                                 linspace_1D(
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

  parameter SI.SpecificEnthalpy[Geometry_1.nV]
                                             hs_start=if not
      use_Ts_start then linspace_1D(
      h_a_start,
      h_b_start,
      geometry.nV) else {Medium.specificEnthalpy_pTX(
      ps_start[i],
      Ts_start[i],
      Xs_start[i, 1:Medium.nX]) for i in 1:geometry.nV} "Specific enthalpy"
                        annotation (Dialog(
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

  parameter SI.MassFraction Xs_start[Geometry_1.nV,Medium.nX]=
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

  parameter SI.MassFraction Cs_start[Geometry_1.nV,Medium.nC]=
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

  parameter SI.MassFlowRate[Geometry_1.nV + 1]
                                             m_flows_start=linspace(
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

  Real SF_mC_add[Geometry_1.nV,Medium.nC]=
                                        {{InternalReflectorBlanket.mCs[i, j]/
      sum(InternalReflectorBlanket.mCs[:, j]) for j in 1:Medium.nC} for i in 1:
      geometry.nV};

// Internal blanket design
  parameter Boolean internal_blanket_in_design = true annotation(Dialog(group = "Internal Reflective Blanket"));

  parameter TRANSFORM.Units.HydraulicResistance R_IRB = 1e8 annotation(Dialog(group = "Internal Reflective Blanket", enable = internal_blanket_in_design));
  Modelica.Blocks.Sources.RealExpression Q_IRB(y=kinetics.Q_total*
        Power_Prod_Frac[3]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,138},{22,148}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface
    InternalReflectorBlanket(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesIRB*geometry.nPins,
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
    Ts_wall(start={{fuelModel_IRB.T_start_clad[end, i] for j in 1:
          InternalReflectorBlanket.heatTransfer.nSurfaces} for i in 1:
          InternalReflectorBlanket.nV}),
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
            j in 1:Medium.nC} for i in 1:InternalReflectorBlanket.nV}))
    annotation (Placement(transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={0,100})));

  FuelModels.FuelGapClad_FD2DCyl                 fuelModel_IRB(
    r_outer_fuel=r_outer_fuel,
    r_outer_gap=r_outer_gap,
    r_outer_clad=r_outer_clad,
    nFuelPins=geometry.nPins*nAssembliesIRB,
    redeclare package fuelType = Rods_IRB,
    redeclare package gapType = Fuel_gap_material,
    redeclare package cladType = Fuel_Cladding,
    energyDynamics=energyDynamics_fuel,
    length=geometry.length,
    Tref_fuel=T_Fuel_Init,
    Tref_gap=T_Gap_Init,
    Tref_clad=T_Clad_Init)          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,124})));

  TRANSFORM.Blocks.ShapeFactor shapeFactor(n=geometry.nV, SF_start=
        SF_start_power)
    annotation (Placement(transformation(extent={{14,138},{4,148}})));

  parameter Boolean toggle_ReactivityFP=true
    "=true to include fission product reacitivity feedback"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));

   parameter Integer n_hot = 10 annotation (Dialog(tab="Hot Channel", group="parameters"));
//   SI.SpecificEnthalpy h_hot[n_hot];
//
   parameter Real Q_shape[n_hot] = fill(1/n_hot,n_hot) "Flux profile over n_hot variables"
    annotation (Dialog(tab="Hot Channel", group="parameters"));

   input SI.Temperature T_inlet=300 annotation (Dialog(tab="General", group="Input"));
   input SI.Temperature T_outlet=300 annotation (Dialog(tab="General", group="Input"));


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
    nFeedback=5,
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
    alphas_feedback=if kinetics_volume then {nAssembliesIF/nTotalAssemblies*
        alpha_IF,nAssembliesOF/nTotalAssemblies*alpha_OF,nAssembliesIRB/
        nTotalAssemblies*alpha_IRB,alpha_RB*nAssembliesRB/nTotalAssemblies,
        alpha_coolant} else {alpha_IF,alpha_OF,alpha_IRB,alpha_RB,alpha_coolant},
    vals_feedback={fuelModel_IF.Fuel.solutionMethod.Teff,fuelModel_OF.Fuel.solutionMethod.Teff,
        fuelModel_IRB.Fuel.solutionMethod.Teff,fuelModel_RB.Fuel.solutionMethod.Teff,
        0.5*Core_Outlet_T.T + 0.5*Core_Inlet_T.T},
    vals_feedback_reference={Teffref_fuel_IF,Teffref_fuel_OF,Teffref_fuel_IRB,
        Teffref_fuel_RB,Teffref_coolant},
    Q_fission_start=Q_fission_start,
    Cs_start=Cs_pg_start,
    Es_start=Es_start,
    V=(fuelModel_IF.Fuel.solutionMethod.volTotal*nAssembliesIF + fuelModel_OF.Fuel.solutionMethod.volTotal
        *nAssembliesOF + fuelModel_IRB.Fuel.solutionMethod.volTotal*
        nAssembliesIRB + fuelModel_RB.Fuel.solutionMethod.volTotal*
        nAssembliesRB)*geometry.nPins,
    mCs_start=mCs_fp_start,
    mCs_add={sum(InternalReflectorBlanket.mCs[:, j])*InternalReflectorBlanket.nParallel
        for j in 1:Medium.nC},
    Vs_add=InternalReflectorBlanket.geometry.V_total*InternalReflectorBlanket.nParallel,
    toggle_ReactivityFP=toggle_ReactivityFP)
    annotation (Placement(transformation(extent={{60,80},{80,100}})));

  TRANSFORM.Fluid.FittingsAndResistances.MultiPort multiPort(redeclare package
      Medium = Medium,                        nPorts_b=4)
    annotation (Placement(transformation(extent={{-76,-10},{-68,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.MultiPort multiPort1(redeclare package
      Medium = Medium,                         nPorts_b=4)
    annotation (Placement(transformation(extent={{68,-10},{60,10}})));

    //Inner Fuel Ring components
   parameter TRANSFORM.Units.HydraulicResistance R_IF = 100;
   Modelica.Blocks.Sources.RealExpression Q_IF(y=kinetics.Q_total*
        Power_Prod_Frac[1]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,-66},{22,-76}})));


  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface InnerFuelRing(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesIF*geometry.nPins,
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
    Ts_wall(start={{fuelModel_IF.T_start_clad[end, i] for j in 1:InnerFuelRing.heatTransfer.nSurfaces}
          for i in 1:InnerFuelRing.nV}),
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
            j in 1:Medium.nC} for i in 1:InternalReflectorBlanket.nV}))
    annotation (Placement(transformation(
        extent={{-15,13},{15,-13}},
        rotation=0,
        origin={0,-30})));
  FuelModels.FuelGapClad_FD2DCyl                 fuelModel_IF(
    r_outer_fuel=r_outer_fuel,
    r_outer_gap=r_outer_gap,
    r_outer_clad=r_outer_clad,
    nFuelPins=geometry.nPins*nAssembliesIF,
    redeclare package fuelType =Rods_IF,
    redeclare package gapType = Fuel_gap_material,
    redeclare package cladType = Fuel_Cladding,
    energyDynamics=energyDynamics_fuel,
    length=geometry.length,
    Tref_fuel=T_Fuel_Init,
    Tref_gap=T_Gap_Init,
    Tref_clad=T_Clad_Init)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-54})));
  TRANSFORM.Blocks.ShapeFactor shapeFactor1(n=geometry.nV, SF_start=
        SF_start_power)
    annotation (Placement(transformation(extent={{14,-66},{4,-76}})));

    //OuterFuel section
      parameter TRANSFORM.Units.HydraulicResistance R_OF = 100;
  Modelica.Blocks.Sources.RealExpression Q_OF(y=kinetics.Q_total*
        Power_Prod_Frac[2]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,66},{22,76}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface OuterFuelRing(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesOF*geometry.nPins,
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
    Ts_wall(start={{fuelModel_OF.T_start_clad[end, i] for j in 1:OuterFuelRing.heatTransfer.nSurfaces}
          for i in 1:OuterFuelRing.nV}),
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
            j in 1:Medium.nC} for i in 1:InternalReflectorBlanket.nV}))
    annotation (Placement(transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={0,28})));
  FuelModels.FuelGapClad_FD2DCyl                 fuelModel_OF(
    r_outer_fuel=r_outer_fuel,
    r_outer_gap=r_outer_gap,
    r_outer_clad=r_outer_clad,
    nFuelPins=geometry.nPins*nAssembliesOF,
    redeclare package fuelType = Rods_OF,
    redeclare package gapType = Fuel_gap_material,
    redeclare package cladType = Fuel_Cladding,
    energyDynamics=energyDynamics_fuel,
    length=geometry.length,
    Tref_fuel=T_Fuel_Init,
    Tref_gap=T_Gap_Init,
    Tref_clad=T_Clad_Init)          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,52})));
  TRANSFORM.Blocks.ShapeFactor shapeFactor2(n=geometry.nV, SF_start=
        SF_start_power)
    annotation (Placement(transformation(extent={{14,66},{4,76}})));

      parameter TRANSFORM.Units.HydraulicResistance R_RB = 100;

      //Radial blanket section
  Modelica.Blocks.Sources.RealExpression Q_RB(y=kinetics.Q_total*
        Power_Prod_Frac[4]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,-138},{22,-148}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface RadialBlanket(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesRB*geometry.nPins,
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
    Ts_wall(start={{fuelModel_RB.T_start_clad[end, i] for j in 1:RadialBlanket.heatTransfer.nSurfaces}
          for i in 1:RadialBlanket.nV}),
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
            j in 1:Medium.nC} for i in 1:InternalReflectorBlanket.nV}))
    annotation (Placement(transformation(
        extent={{-15,13},{15,-13}},
        rotation=0,
        origin={0,-100})));
  FuelModels.FuelGapClad_FD2DCyl                 fuelModel_RB(
    r_outer_fuel=r_outer_fuel,
    r_outer_gap=r_outer_gap,
    r_outer_clad=r_outer_clad,
    nFuelPins=geometry.nPins*nAssembliesRB,
    redeclare package fuelType = Rods_RB,
    redeclare package gapType = Fuel_gap_material,
    redeclare package cladType = Fuel_Cladding,
    energyDynamics=energyDynamics_fuel,
    length=geometry.length,
    Tref_fuel=T_Fuel_Init,
    Tref_gap=T_Gap_Init,
    Tref_clad=T_Clad_Init)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-124})));
  TRANSFORM.Blocks.ShapeFactor shapeFactor3(n=geometry.nV, SF_start=
        SF_start_power)
    annotation (Placement(transformation(extent={{14,-138},{4,-148}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    IntRefBlanket_Resistance(redeclare package Medium = Medium,
                             R=R_IRB)
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    RadialBlanket_Resistance(redeclare package Medium = Medium,
                             R=R_RB)
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Internal_Fuel_Resistance(redeclare package Medium = Medium,
                             R=R_IF)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Outer_Fuel_Resistance(redeclare package Medium = Medium,
                          R=R_OF)
    annotation (Placement(transformation(extent={{-50,18},{-30,38}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Outlet_T(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{78,-6},{88,6}})));
equation

  connect(fuelModel_IRB.heatPorts_b, InternalReflectorBlanket.heatPorts[:, 1])
    annotation (Line(points={{0.1,113.8},{0.1,110},{0,110},{0,106.5}}, color={127,
          0,0}));
  connect(shapeFactor.u, Q_IRB.y)
    annotation (Line(points={{15,143},{21.2,143}}, color={0,0,127}));
  connect(shapeFactor.y, fuelModel_IRB.Power_in)
    annotation (Line(points={{3.5,143},{0,143},{0,135}},   color={0,0,127}));


  connect(fuelModel_IF.heatPorts_b, InnerFuelRing.heatPorts[:, 1]) annotation (
      Line(points={{0.1,-43.8},{0.1,-38},{0,-38},{0,-36.5}},         color={127,
          0,0}));
  connect(shapeFactor1.u, Q_IF.y)
    annotation (Line(points={{15,-71},{21.2,-71}}, color={0,0,127}));
  connect(shapeFactor1.y, fuelModel_IF.Power_in) annotation (Line(points={{3.5,-71},
          {-1.9984e-15,-71},{-1.9984e-15,-65}},
                                     color={0,0,127}));
  connect(fuelModel_OF.heatPorts_b, OuterFuelRing.heatPorts[:, 1]) annotation (
      Line(points={{0.1,41.8},{0.1,34},{0,34},{0,34.5}},         color={127,0,0}));
  connect(shapeFactor2.u, Q_OF.y)
    annotation (Line(points={{15,71},{21.2,71}},color={0,0,127}));
  connect(shapeFactor2.y, fuelModel_OF.Power_in) annotation (Line(points={{3.5,71},
          {3.5,70},{0,70},{0,63}},  color={0,0,127}));
  connect(shapeFactor3.u, Q_RB.y)
    annotation (Line(points={{15,-143},{21.2,-143}},color={0,0,127}));
  connect(shapeFactor3.y, fuelModel_RB.Power_in) annotation (Line(points={{3.5,-143},
          {0,-143},{0,-135}},           color={0,0,127}));
  connect(fuelModel_RB.heatPorts_b, RadialBlanket.heatPorts[:, 1]) annotation (
      Line(points={{0.1,-113.8},{0.1,-114},{0,-114},{0,-106.5}},     color={127,
          0,0}));
  connect(RadialBlanket.port_b, multiPort1.ports_b[1]) annotation (Line(points={{15,-100},
          {46,-100},{46,0},{60,0},{60,3}},        color={0,127,255}));
  connect(InnerFuelRing.port_b, multiPort1.ports_b[2]) annotation (Line(points={{15,-30},
          {46,-30},{46,0},{60,0},{60,1}},   color={0,127,255}));
  connect(OuterFuelRing.port_b, multiPort1.ports_b[3])
    annotation (Line(points={{15,28},{46,28},{46,0},{60,0},{60,-1}},
                                                          color={0,127,255}));
  connect(InternalReflectorBlanket.port_b, multiPort1.ports_b[4]) annotation (
      Line(points={{15,100},{46,100},{46,0},{60,0},{60,-3}},
                                                  color={0,127,255}));
  connect(InternalReflectorBlanket.port_a, IntRefBlanket_Resistance.port_b)
    annotation (Line(points={{-15,100},{-33,100}},
                                                 color={0,127,255}));
  connect(IntRefBlanket_Resistance.port_a, multiPort.ports_b[1]) annotation (
      Line(points={{-47,100},{-62,100},{-62,0},{-68,0},{-68,3}},
                                                       color={0,127,255}));
  connect(RadialBlanket.port_a, RadialBlanket_Resistance.port_b)
    annotation (Line(points={{-15,-100},{-33,-100}},
                                                   color={0,127,255}));
  connect(RadialBlanket_Resistance.port_a, multiPort.ports_b[2]) annotation (
      Line(points={{-47,-100},{-62,-100},{-62,0},{-68,0},{-68,1}},
                                                         color={0,127,255}));
  connect(OuterFuelRing.port_a, Outer_Fuel_Resistance.port_b)
    annotation (Line(points={{-15,28},{-33,28}},
                                               color={0,127,255}));
  connect(Outer_Fuel_Resistance.port_a, multiPort.ports_b[3]) annotation (Line(
        points={{-47,28},{-62,28},{-62,0},{-68,0},{-68,-1}},
                                                  color={0,127,255}));
  connect(InnerFuelRing.port_a, Internal_Fuel_Resistance.port_b)
    annotation (Line(points={{-15,-30},{-33,-30}}, color={0,127,255}));
  connect(Internal_Fuel_Resistance.port_a, multiPort.ports_b[4]) annotation (
      Line(points={{-47,-30},{-62,-30},{-62,0},{-68,0},{-68,-3}},
                                                         color={0,127,255}));
  connect(multiPort1.port_a, Core_Outlet_T.port_a)
    annotation (Line(points={{68,0},{78,0}}, color={0,127,255}));
  connect(Core_Outlet_T.port_b, port_b)
    annotation (Line(points={{88,0},{100,0}}, color={0,127,255}));
  connect(multiPort.port_a, Core_Inlet_T.port_b)
    annotation (Line(points={{-76,0},{-80,0}}, color={0,127,255}));
  connect(Core_Inlet_T.port_a, port_a)
    annotation (Line(points={{-92,0},{-100,0}}, color={0,127,255}));
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
end SFR;
