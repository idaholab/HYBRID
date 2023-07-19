within NHES.Nuclear.CoreSubchannels;
model SFR_Individual_Geometries
  "0-D point kinetics fuel channel model with three solid media regions including a hot channel calculation routine."
  import TRANSFORM;

  import TRANSFORM.Math.linspace_1D;
  import TRANSFORM.Math.linspaceRepeat_1D;
  import Modelica.Fluid.Types.ModelStructure;
  import TRANSFORM.Fluid.Types.LumpedLocation;
  import Modelica.Fluid.Types.Dynamics;
  parameter Boolean kinetics_volume = false annotation(dialog(group="Total Core"));
  parameter Real Power_Prod_Frac[4] = {0.24, 0.48, 0.1, 0.18} "Power production in the inner fuel, outer fuel, inner blanket, and outer blanket respectively." annotation(dialog(group="Total Core"));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow    port_a(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow    port_b(redeclare package Medium = Medium) annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
            {110,10}})));

  parameter Integer nAssembliesReg1=1 "Number of identical parallel assemblies in the inner fuel region, min = 1" annotation(Dialog(group = "Region 1"));
  parameter Integer nAssembliesReg2=1 "Number of identical parallel assemblies in the inner fuel region, min = 1" annotation(Dialog(group = "Region 2"));
  parameter Integer nAssembliesReg3=1 "Number of identical parallel assemblies in the inner reflector region, min = 1" annotation(Dialog(group = "Region 3"));
  parameter Integer nAssembliesReg4=1 "Number of identical parallel assemblies in the outer reflector region, min = 1" annotation(Dialog(group = "Region 4"));
protected
            parameter Integer nTotalAssemblies = nAssembliesReg1+nAssembliesReg2+nAssembliesReg3+nAssembliesReg4 annotation(Dialog(enable = false));
public
  parameter Modelica.Units.SI.Length r_outer_fuel_R1 = 0.0039 annotation(Dialog( group = "Region 1"));
  parameter Modelica.Units.SI.Length r_outer_gap_R1 =  0.0041 annotation(Dialog( group = "Region 1"));
  parameter Modelica.Units.SI.Length r_outer_clad_R1 = 0.0055 annotation(Dialog( group = "Region 1"));
  parameter Modelica.Units.SI.Length r_outer_fuel_R2 = 0.0039 annotation(Dialog( group = "Region 2"));
  parameter Modelica.Units.SI.Length r_outer_gap_R2 =  0.0041 annotation(Dialog( group = "Region 2"));
  parameter Modelica.Units.SI.Length r_outer_clad_R2 = 0.0055 annotation(Dialog( group = "Region 2"));
  parameter Modelica.Units.SI.Length r_outer_fuel_R3 = 0.0039 annotation(Dialog( group = "Region 3"));
  parameter Modelica.Units.SI.Length r_outer_gap_R3 =  0.0041 annotation(Dialog( group = "Region 3"));
  parameter Modelica.Units.SI.Length r_outer_clad_R3 = 0.0055 annotation(Dialog( group = "Region 3"));
  parameter Modelica.Units.SI.Length r_outer_fuel_R4 = 0.0039 annotation(Dialog( group = "Region 4"));
  parameter Modelica.Units.SI.Length r_outer_gap_R4 =  0.0041 annotation(Dialog( group = "Region 4"));
  parameter Modelica.Units.SI.Length r_outer_clad_R4 = 0.0055 annotation(Dialog( group = "Region 4"));

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Coolant medium" annotation (choicesAllMatching=true, Dialog(group = "Total Core"));
  replaceable package Rods_R1 =
      NHES.Media.Interfaces.PartialAlloy "Power producing material in region 1"
      annotation (choicesAllMatching=true, Dialog(group="Region 1"));
  replaceable package Rods_R2 =    NHES.Media.Interfaces.PartialAlloy "Power producing material in region 2"
      annotation (choicesAllMatching=true, Dialog(group="Region 2"));
  replaceable package Rods_R3 =
      NHES.Media.Interfaces.PartialAlloy "Incidental power producing material in region 3"
    annotation (choicesAllMatching=true, Dialog(group="Region 3"));

  replaceable package Rods_R4 =
     NHES.Media.Interfaces.PartialAlloy "Incidental power producing material in ergion 4"
      annotation (choicesAllMatching=true, Dialog(group="Region 4"));
  replaceable package Fuel_gap_R1 =
      NHES.Media.Interfaces.PartialAlloy "Gap material within rods, default to be the same throughout the core"
      annotation (choicesAllMatching=true, Dialog(group="Region 1"));
      replaceable package Fuel_gap_R2 =
      Fuel_gap_R1 constrainedby NHES.Media.Interfaces.PartialAlloy "Gap material within rods, default to be the same throughout the core"
      annotation (choicesAllMatching=true, Dialog(group="Region 2"));
      replaceable package Fuel_gap_R3 =
      Fuel_gap_R1 constrainedby NHES.Media.Interfaces.PartialAlloy  "Gap material within rods, default to be the same throughout the core"
      annotation (choicesAllMatching=true, Dialog(group="Region 3"));
      replaceable package Fuel_gap_R4 =
      Fuel_gap_R1 constrainedby NHES.Media.Interfaces.PartialAlloy  "Gap material within rods, default to be the same throughout the core"
      annotation (choicesAllMatching=true, Dialog(group="Region 4"));
  replaceable package Fuel_Cladding_R1 =
      NHES.Media.Interfaces.PartialAlloy "Cladding material on rods, default to be the same throughout the core"
    annotation (choicesAllMatching=true, Dialog(group="Region 1"));
      replaceable package Fuel_Cladding_R2 =
      Fuel_Cladding_R1 "Cladding material on rods, default to be the same throughout the core"
    annotation (choicesAllMatching=true, Dialog(group="Region 2"));
      replaceable package Fuel_Cladding_R3 =
      Fuel_Cladding_R1 "Cladding material on rods, default to be the same throughout the core"
    annotation (choicesAllMatching=true, Dialog(group="Region 3"));
      replaceable package Fuel_Cladding_R4 =
      Fuel_Cladding_R1 "Cladding material on rods, default to be the same throughout the core"
    annotation (choicesAllMatching=true, Dialog(group="Region 4"));

  replaceable model Geometry_R1 =
      NHES.Nuclear.New_Geometries.Generic_SFR
    constrainedby
    TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    "Geometry" annotation (Dialog(group="Region 1"),choicesAllMatching=true);

  replaceable model Geometry_R2 =
      NHES.Nuclear.New_Geometries.Generic_SFR
    constrainedby
    TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    "Geometry" annotation (Dialog(group="Region 2"),choicesAllMatching=true);

  replaceable model Geometry_R3 =
      NHES.Nuclear.New_Geometries.Generic_SFR
    constrainedby
    TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    "Geometry" annotation (Dialog(group="Region 3"),choicesAllMatching=true);
  replaceable model Geometry_R4 =
      NHES.Nuclear.New_Geometries.Generic_SFR
    constrainedby
    TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Generic
    "Geometry" annotation (Dialog(group="Region 4"),choicesAllMatching=true);

  Geometry_R1 Geometry_1(final nRegions=3)
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));

  Geometry_R2 Geometry_2(final nRegions=3)
    annotation (Placement(transformation(extent={{-100,56},{-80,76}})));


  Geometry_R3 Geometry_3(final nRegions=3)
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));


  Geometry_R4 Geometry_4(final nRegions=3)
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));


  replaceable model FlowModel =
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
    constrainedby
    TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
    "Coolant flow models (i.e., momentum, pressure loss, wall friction)"
    annotation (choicesAllMatching=true, Dialog(group="Total Core"));

  replaceable model HeatTransfer =
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
    constrainedby
    TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
    "Coolant coefficient of heat transfer" annotation (choicesAllMatching=true,
      Dialog(group="Total Core"));

  /* Kinetics */
  parameter SI.Power Q_nominal=1e6
    "Total nominal reactor power (fission + decay)" annotation(Dialog(group="Total Core"));
  parameter Boolean specifyPower=false
    "=true to specify power (i.e., no der(P) equation)" annotation(Dialog(group="Total Core"));
  parameter TRANSFORM.Units.NonDim SF_start_power1[Geometry_1.nV]=fill(1/
      Geometry_1.nV, Geometry_1.nV)
    "Shape factor for the power profile, sum(SF) = 1" annotation(Dialog(group = "Region 1"));
  parameter TRANSFORM.Units.NonDim SF_start_power2[Geometry_2.nV]=fill(1/
      Geometry_2.nV, Geometry_2.nV)
    "Shape factor for the power profile, sum(SF) = 1" annotation(Dialog(group = "Region 2"));
  parameter TRANSFORM.Units.NonDim SF_start_power3[Geometry_3.nV]=fill(1/
      Geometry_3.nV, Geometry_3.nV)
    "Shape factor for the power profile, sum(SF) = 1" annotation(Dialog(group = "Region 3"));
  parameter TRANSFORM.Units.NonDim SF_start_power4[Geometry_4.nV]=fill(1/
      Geometry_4.nV, Geometry_4.nV)
    "Shape factor for the power profile, sum(SF) = 1" annotation(Dialog(group = "Region 4"));
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

  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_Reg1=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_Reg2=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_Reg3=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_Reg4=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_coolant=-20e-5
    "Moderator feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter SI.Temperature Teffref_fuel_Reg1 = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
                                   parameter SI.Temperature Teffref_fuel_Reg2 = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
                                   parameter SI.Temperature Teffref_fuel_Reg3 = 923.15 "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
                                   parameter SI.Temperature Teffref_fuel_Reg4 = 923.15 "Fuel reference temperature"
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
  parameter SI.Temperature T_Fuel_Init_R1 = 1073.15 "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 1"));
  parameter SI.Temperature T_Gap_Init_R1 = 973.15 "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 1"));
  parameter SI.Temperature T_Clad_Init_R1 = 923.15
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 1"));
  parameter SI.Temperature Ts_start_1R1[Geometry_1.nRs[1],Geometry_1.nV]=fill(
      T_Fuel_Init_R1,
      Geometry_1.nRs[1],
      Geometry_1.nV) "Fuel temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 1"));
  parameter SI.Temperature Ts_start_2R1[Geometry_1.nRs[2],Geometry_1.nV]=[{
      Ts_start_1R1[end, :]}; fill(
      T_Gap_Init_R1,
      Geometry_1.nRs[2] - 1,
      Geometry_1.nV)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 1"));
  parameter SI.Temperature Ts_start_3R1[Geometry_1.nRs[3],Geometry_1.nV]=[{
      Ts_start_2R1[end, :]}; fill(
      T_Clad_Init_R1,
      Geometry_1.nRs[3] - 1,
      Geometry_1.nV)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 1"));

  // Fuel Initialization
  parameter SI.Temperature T_Fuel_Init_R2 = 1073.15 "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 2"));
  parameter SI.Temperature T_Gap_Init_R2 = 973.15 "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 2"));
  parameter SI.Temperature T_Clad_Init_R2 = 923.15
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 2"));
  parameter SI.Temperature Ts_start_1R2[Geometry_2.nRs[1],Geometry_2.nV]=fill(
      T_Fuel_Init_R2,
      Geometry_2.nRs[1],
      Geometry_2.nV) "Fuel temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 2"));
  parameter SI.Temperature Ts_start_2R2[Geometry_2.nRs[2],Geometry_2.nV]=[{
      Ts_start_1R2[end, :]}; fill(
      T_Gap_Init_R2,
      Geometry_2.nRs[2] - 1,
      Geometry_2.nV)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 2"));
  parameter SI.Temperature Ts_start_3R2[Geometry_2.nRs[3],Geometry_2.nV]=[{
      Ts_start_2R2[end, :]}; fill(
      T_Clad_Init_R2,
      Geometry_2.nRs[3] - 1,
      Geometry_2.nV)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 2"));

  // Fuel Initialization
  parameter SI.Temperature T_Fuel_Init_R3 = 1073.15 "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 3"));
  parameter SI.Temperature T_Gap_Init_R3 = 973.15 "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 3"));
  parameter SI.Temperature T_Clad_Init_R3 = 923.15
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 3"));


  parameter SI.Temperature Ts_start_1R3[Geometry_3.nRs[1],Geometry_3.nV]=fill(
      T_Fuel_Init_R3,
      Geometry_3.nRs[1],
      Geometry_3.nV) "Fuel temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 3"));
  parameter SI.Temperature Ts_start_2R3[Geometry_3.nRs[2],Geometry_3.nV]=[{
      Ts_start_1R3[end, :]}; fill(
      T_Gap_Init_R3,
      Geometry_3.nRs[2] - 1,
      Geometry_3.nV)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 3"));
  parameter SI.Temperature Ts_start_3R3[Geometry_3.nRs[3],Geometry_3.nV]=[{
      Ts_start_2R3[end, :]}; fill(
      T_Clad_Init_R3,
      Geometry_3.nRs[3] - 1,
      Geometry_3.nV)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 3"));
  // Fuel Initialization
  parameter SI.Temperature T_Fuel_Init_R4 = 1073.15 "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 4"));
  parameter SI.Temperature T_Gap_Init_R4 = 973.15 "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 4"));
  parameter SI.Temperature T_Clad_Init_R4 = 923.15
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values Region 4"));


  parameter SI.Temperature Ts_start_1R4[Geometry_4.nRs[1],Geometry_4.nV]=fill(
      T_Fuel_Init_R4,
      Geometry_4.nRs[1],
      Geometry_4.nV) "Fuel temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 4"));
  parameter SI.Temperature Ts_start_2R4[Geometry_4.nRs[2],Geometry_4.nV]=[{
      Ts_start_1R4[end, :]}; fill(
      T_Gap_Init_R4,
      Geometry_4.nRs[2] - 1,
      Geometry_4.nV)] "Gap temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 4"));
  parameter SI.Temperature Ts_start_3R4[Geometry_4.nRs[3],Geometry_4.nV]=[{
      Ts_start_2R4[end, :]}; fill(
      T_Clad_Init_R4,
      Geometry_4.nRs[3] - 1,
      Geometry_4.nV)] "Cladding temperatures" annotation (Dialog(tab="Fuel Element Initialization",
        group="Start Value: Temperature Region 4"));
      // Coolant Initialization
   parameter SI.AbsolutePressure p_a_start=Medium.p_default
    "Pressure at port a" annotation (Dialog(tab="Coolant Initialization", group="Full Core"));
  parameter SI.AbsolutePressure p_b_start=p_a_start + (if m_flow_a_start1 > 0 then -1e3 elseif m_flow_a_start1 < 0 then -1e3 else 0)
    "Pressure at port b" annotation (Dialog(tab="Coolant Initialization", group="Full Core"));
     parameter SI.AbsolutePressure[Geometry_1.nV] ps_start1=linspace_1D(
      p_a_start,
      p_b_start,
      Geometry_1.nV) "Pressure" annotation (Dialog(tab="Coolant Initialization",
        group="Region 1"));
  parameter SI.AbsolutePressure[Geometry_2.nV] ps_start2=linspace_1D(
      p_a_start,
      p_b_start,
      Geometry_2.nV) "Pressure" annotation (Dialog(tab="Coolant Initialization",
        group="Region 2"));
  parameter SI.AbsolutePressure[Geometry_3.nV] ps_start3=linspace_1D(
      p_a_start,
      p_b_start,
      Geometry_3.nV) "Pressure" annotation (Dialog(tab="Coolant Initialization",
        group="Region 3"));
  parameter SI.AbsolutePressure[Geometry_4.nV] ps_start4=linspace_1D(
      p_a_start,
      p_b_start,
      Geometry_4.nV) "Pressure" annotation (Dialog(tab="Coolant Initialization",
        group="Region 4"));


  parameter Boolean use_Ts_start=true
    "Use T_start if true, otherwise h_start" annotation (Evaluate=true, Dialog(
        tab="Coolant Initialization", group="Full Core"));

  parameter SI.Temperature T_a_start=Medium.T_default
    "Temperature at port a" annotation (Dialog(
      tab="Coolant Initialization",
      group="Full Core",
      enable=use_Ts_start));
  parameter SI.Temperature T_b_start=T_a_start
    "Temperature at port b" annotation (Dialog(
      tab="Coolant Initialization",
      group="Full Core",
      enable=use_Ts_start));

  parameter SI.Temperature Ts_start1[Geometry_1.nV]=linspace_1D(
      T_a_start,
      T_b_start,
      Geometry_1.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Coolant Initialization",
      group="Region 1",
      enable=use_Ts_start));
  parameter SI.Temperature Ts_start2[Geometry_2.nV]=linspace_1D(
      T_a_start,
      T_b_start,
      Geometry_2.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Coolant Initialization",
      group="Region 2",
      enable=use_Ts_start));
  parameter SI.Temperature Ts_start3[Geometry_3.nV]=linspace_1D(
      T_a_start,
      T_b_start,
      Geometry_3.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Coolant Initialization",
      group="Region 3",
      enable=use_Ts_start));
  parameter SI.Temperature Ts_start4[Geometry_4.nV]=linspace_1D(
      T_a_start,
      T_b_start,
      Geometry_4.nV) "Temperature" annotation (Evaluate=true, Dialog(
      tab="Coolant Initialization",
      group="Region 4",
      enable=use_Ts_start));


  parameter SI.SpecificEnthalpy[Geometry_1.nV] hs_start1=if not use_Ts_start
       then linspace_1D(
      h_a_start,
      h_b_start,
      Geometry_1.nV) else {Medium.specificEnthalpy_pTX(
      ps_start1[i],
      Ts_start1[i],
      Xs_start1[i, 1:Medium.nX]) for i in 1:Geometry_1.nV} "Specific enthalpy"
    annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 1",
      enable=not use_Ts_start));

  parameter SI.SpecificEnthalpy[Geometry_2.nV] hs_start2=if not use_Ts_start
       then linspace_1D(
      h_a_start,
      h_b_start,
      Geometry_2.nV) else {Medium.specificEnthalpy_pTX(
      ps_start2[i],
      Ts_start2[i],
      Xs_start2[i, 1:Medium.nX]) for i in 1:Geometry_2.nV} "Specific enthalpy"
    annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 2",
      enable=not use_Ts_start));
        parameter SI.SpecificEnthalpy[Geometry_3.nV] hs_start3=if not use_Ts_start
       then linspace_1D(
      h_a_start,
      h_b_start,
      Geometry_3.nV) else {Medium.specificEnthalpy_pTX(
      ps_start3[i],
      Ts_start3[i],
      Xs_start3[i, 1:Medium.nX]) for i in 1:Geometry_3.nV} "Specific enthalpy"
    annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 3",
      enable=not use_Ts_start));
        parameter SI.SpecificEnthalpy[Geometry_4.nV] hs_start4=if not use_Ts_start
       then linspace_1D(
      h_a_start,
      h_b_start,
      Geometry_4.nV) else {Medium.specificEnthalpy_pTX(
      ps_start4[i],
      Ts_start4[i],
      Xs_start4[i, 1:Medium.nX]) for i in 1:Geometry_4.nV} "Specific enthalpy"
    annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 4",
      enable=not use_Ts_start));




  parameter SI.SpecificEnthalpy h_a_start=Medium.specificEnthalpy_pTX(
      p_a_start,
      T_a_start,
      X_a_start) "Specific enthalpy at port a" annotation (Dialog(
      tab="Coolant Initialization",
      group="Full Core",
      enable=not use_Ts_start));
  parameter SI.SpecificEnthalpy h_b_start=Medium.specificEnthalpy_pTX(
      p_b_start,
      T_b_start,
      X_b_start) "Specific enthalpy at port b" annotation (Dialog(
      tab="Coolant Initialization",
      group="Full Core",
      enable=not use_Ts_start));

  parameter SI.MassFraction Xs_start1[Geometry_1.nV,Medium.nX]=linspaceRepeat_1D(
      X_a_start,
      X_b_start,
      Geometry_1.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 1",
      enable=Medium.nXi > 0));
  parameter SI.MassFraction Xs_start2[Geometry_2.nV,Medium.nX]=linspaceRepeat_1D(
      X_a_start,
      X_b_start,
      Geometry_2.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 2",
      enable=Medium.nXi > 0));
  parameter SI.MassFraction Xs_start3[Geometry_3.nV,Medium.nX]=linspaceRepeat_1D(
      X_a_start,
      X_b_start,
      Geometry_3.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 3",
      enable=Medium.nXi > 0));
  parameter SI.MassFraction Xs_start4[Geometry_4.nV,Medium.nX]=linspaceRepeat_1D(
      X_a_start,
      X_b_start,
      Geometry_4.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 4",
      enable=Medium.nXi > 0));
  parameter SI.MassFraction X_a_start[Medium.nX]=Medium.X_default
    "Mass fraction at port a" annotation (Dialog(tab="Coolant Initialization",
        group="Full Core"));
  parameter SI.MassFraction X_b_start[Medium.nX]=X_a_start
    "Mass fraction at port b" annotation (Dialog(tab="Coolant Initialization",
        group="Full Core"));

  parameter SI.MassFraction Cs_start1[Geometry_1.nV,Medium.nC]=linspaceRepeat_1D(
      C_a_start,
      C_b_start,
      Geometry_1.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 1",
      enable=Medium.nC > 0));
        parameter SI.MassFraction Cs_start2[Geometry_2.nV,Medium.nC]=linspaceRepeat_1D(
      C_a_start,
      C_b_start,
      Geometry_2.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 2",
      enable=Medium.nC > 0));
        parameter SI.MassFraction Cs_start3[Geometry_3.nV,Medium.nC]=linspaceRepeat_1D(
      C_a_start,
      C_b_start,
      Geometry_3.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 3",
      enable=Medium.nC > 0));
        parameter SI.MassFraction Cs_start4[Geometry_4.nV,Medium.nC]=linspaceRepeat_1D(
      C_a_start,
      C_b_start,
      Geometry_4.nV) "Mass fraction" annotation (Dialog(
      tab="Coolant Initialization",
      group="Region 4",
      enable=Medium.nC > 0));
  parameter SI.MassFraction C_a_start[Medium.nC]=fill(0, Medium.nC)
    "Mass fraction at port a" annotation (Dialog(tab="Coolant Initialization",
        group="Full Core"));
  parameter SI.MassFraction C_b_start[Medium.nC]=C_a_start
    "Mass fraction at port b" annotation (Dialog(tab="Coolant Initialization",
        group="Full Core"));

  parameter SI.MassFlowRate[Geometry_1.nV + 1] m_flows_start1=linspace(
      m_flow_a_start1,
      -m_flow_b_start1,
      Geometry_1.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(
        tab="Coolant Initialization", group="Region 1"));
  parameter SI.MassFlowRate m_flow_a_start1=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Coolant Initialization", group="Region 1"));
  parameter SI.MassFlowRate m_flow_b_start1=-m_flow_a_start1
    "Mass flow rate at port_b" annotation (Dialog(tab="Coolant Initialization",
        group="Region 1"));

          parameter SI.MassFlowRate[Geometry_2.nV + 1] m_flows_start2=linspace(
      m_flow_a_start2,
      -m_flow_b_start2,
      Geometry_2.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(
        tab="Coolant Initialization", group="Region 2"));
  parameter SI.MassFlowRate m_flow_a_start2=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Coolant Initialization", group="Region 2"));
  parameter SI.MassFlowRate m_flow_b_start2=-m_flow_a_start2
    "Mass flow rate at port_b" annotation (Dialog(tab="Coolant Initialization",
        group="Region 2"));


  parameter SI.MassFlowRate[Geometry_3.nV + 1] m_flows_start3=linspace(
      m_flow_a_start3,
      -m_flow_b_start3,
      Geometry_3.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(
        tab="Coolant Initialization", group="Region 3"));
  parameter SI.MassFlowRate m_flow_a_start3=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Coolant Initialization", group="Region 3"));
  parameter SI.MassFlowRate m_flow_b_start3=-m_flow_a_start3
    "Mass flow rate at port_b" annotation (Dialog(tab="Coolant Initialization",
        group="Region 3"));


  parameter SI.MassFlowRate[Geometry_4.nV + 1] m_flows_start4=linspace(
      m_flow_a_start4,
      -m_flow_b_start4,
      Geometry_4.nV + 1) "Mass flow rates" annotation (Evaluate=true, Dialog(
        tab="Coolant Initialization", group="Region 4"));
  parameter SI.MassFlowRate m_flow_a_start4=0 "Mass flow rate at port_a"
    annotation (Dialog(tab="Coolant Initialization", group="Region 4"));
  parameter SI.MassFlowRate m_flow_b_start4=-m_flow_a_start4
    "Mass flow rate at port_b" annotation (Dialog(tab="Coolant Initialization",
        group="Region 4"));



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

  Real SF_mC_add[Geometry_1.nV,Medium.nC]={{Region_3.mCs[i, j]/sum(Region_3.mCs[
      :, j]) for j in 1:Medium.nC} for i in 1:Geometry_1.nV};

// Region 3

  parameter TRANSFORM.Units.HydraulicResistance R_R3 = 1e8 annotation(Dialog(group = "Region 3"));
  Modelica.Blocks.Sources.RealExpression Q_IRB(y=kinetics.Q_total*
        Power_Prod_Frac[3]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,138},{22,148}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Region_3(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=Geometry_3.nPins*nAssembliesReg3,
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
    Ts_start=Ts_start3,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start3,
    ps_start=ps_start3,
    Ts_wall(start={{fuelModel_Reg3.T_start_clad[end, i] for j in 1:Region_3.heatTransfer.nSurfaces}
          for i in 1:Region_3.nV}),
    Xs_start=Xs_start3,
    Cs_start=Cs_start3,
    X_a_start=X_a_start,
    X_b_start=X_b_start,
    C_a_start=C_a_start,
    C_b_start=C_b_start,
    m_flow_a_start=m_flow_a_start3,
    m_flow_b_start=m_flow_b_start3,
    m_flows_start=m_flows_start3,
    exposeState_a=exposeState_a,
    exposeState_b=exposeState_b,
    energyDynamics=energyDynamics,
    traceDynamics=traceDynamics,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        nV=Geometry_3.nV,
        dimension=Geometry_3.dimension,
        crossArea=Geometry_3.crossArea,
        perimeter=Geometry_3.perimeter,
        length=Geometry_3.length,
        roughness=Geometry_3.roughness,
        surfaceArea=Geometry_3.surfaceArea,
        dheight=Geometry_3.dheight,
        nSurfaces=Geometry_3.nSurfaces,
        height_a=Geometry_3.height_a,
        angle=Geometry_3.angle),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens={{SF_mC_add[i, j]*kinetics.fissionProducts.mC_gens_add[j] for
            j in 1:Medium.nC} for i in 1:Region_3.nV})) annotation (Placement(
        transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={0,100})));

  FuelModels.FuelGapClad_FD2DCyl fuelModel_Reg3(
    r_outer_fuel=r_outer_fuel_R3,
    r_outer_gap=r_outer_gap_R3,
    r_outer_clad=r_outer_clad_R3,
    nFuelPins=Geometry_3.nPins*nAssembliesReg3,
    redeclare package fuelType = Rods_R3,
    redeclare package gapType = Fuel_gap_R3,
    redeclare package cladType = Fuel_Cladding_R3,
    energyDynamics=energyDynamics_fuel,
    length=Geometry_3.length,
    Tref_fuel=T_Fuel_Init_R3,
    Tref_gap=T_Gap_Init_R3,
    Tref_clad=T_Clad_Init_R3)
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,124})));

  TRANSFORM.Blocks.ShapeFactor shapeFactor(n=Geometry_3.nV, SF_start=
        SF_start_power3)
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
    alphas_feedback=if kinetics_volume then {nAssembliesReg1/nTotalAssemblies*
        alpha_Reg1,nAssembliesReg2/nTotalAssemblies*alpha_Reg2,nAssembliesReg3/
        nTotalAssemblies*alpha_Reg3,alpha_Reg4*nAssembliesReg4/nTotalAssemblies,
        alpha_coolant} else {alpha_Reg1,alpha_Reg2,alpha_Reg3,alpha_Reg4,
        alpha_coolant},
    vals_feedback={fuelModel_Reg1.Fuel.solutionMethod.Teff,fuelModel_Reg2.Fuel.solutionMethod.Teff,
        fuelModel_Reg3.Fuel.solutionMethod.Teff,fuelModel_Reg4.Fuel.solutionMethod.Teff,
        0.5*Core_Outlet_T.T + 0.5*Core_Inlet_T.T},
    vals_feedback_reference={Teffref_fuel_Reg1,Teffref_fuel_Reg2,
        Teffref_fuel_Reg3,Teffref_fuel_Reg4,Teffref_coolant},
    Q_fission_start=Q_fission_start,
    Cs_start=Cs_pg_start,
    Es_start=Es_start,
    V=fuelModel_Reg1.Fuel.solutionMethod.volTotal*nAssembliesReg1*Geometry_1.nPins
         + fuelModel_Reg2.Fuel.solutionMethod.volTotal*nAssembliesReg2*
        Geometry_2.nPins + fuelModel_Reg3.Fuel.solutionMethod.volTotal*
        nAssembliesReg3*Geometry_3.nPins + fuelModel_Reg4.Fuel.solutionMethod.volTotal
        *nAssembliesReg4*Geometry_4.nPins,
    mCs_start=mCs_fp_start,
    mCs_add={sum(Region_3.mCs[:, j])*Region_3.nParallel for j in 1:Medium.nC},
    Vs_add=Region_3.geometry.V_total*Region_3.nParallel,
    toggle_ReactivityFP=toggle_ReactivityFP)
    annotation (Placement(transformation(extent={{60,80},{80,100}})));

  TRANSFORM.Fluid.FittingsAndResistances.MultiPort multiPort(redeclare package
      Medium = Medium,                        nPorts_b=4)
    annotation (Placement(transformation(extent={{-76,-10},{-68,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.MultiPort multiPort1(redeclare package
      Medium = Medium,                         nPorts_b=4)
    annotation (Placement(transformation(extent={{68,-10},{60,10}})));

    //Inner Fuel Ring components
   parameter TRANSFORM.Units.HydraulicResistance R_R1 = 100 annotation(Dialog(group = "Region 1"));
   Modelica.Blocks.Sources.RealExpression Q_Reg1(y=kinetics.Q_total*
        Power_Prod_Frac[1]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,-66},{22,-76}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Region_1(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesReg1*Geometry_1.nPins,
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
    Ts_start=Ts_start1,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start1,
    ps_start=ps_start1,
    Ts_wall(start={{fuelModel_Reg1.T_start_clad[end, i] for j in 1:Region_1.heatTransfer.nSurfaces}
          for i in 1:Region_1.nV}),
    Xs_start=Xs_start1,
    Cs_start=Cs_start1,
    X_a_start=X_a_start,
    X_b_start=X_b_start,
    C_a_start=C_a_start,
    C_b_start=C_b_start,
    m_flow_a_start=m_flow_a_start1,
    m_flow_b_start=m_flow_b_start1,
    m_flows_start=m_flows_start1,
    exposeState_a=exposeState_a,
    exposeState_b=exposeState_b,
    energyDynamics=energyDynamics,
    traceDynamics=traceDynamics,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        nV=Geometry_1.nV,
        dimension=Geometry_1.dimension,
        crossArea=Geometry_1.crossArea,
        perimeter=Geometry_1.perimeter,
        length=Geometry_1.length,
        roughness=Geometry_1.roughness,
        surfaceArea=Geometry_1.surfaceArea,
        dheight=Geometry_1.dheight,
        nSurfaces=Geometry_1.nSurfaces,
        height_a=Geometry_1.height_a,
        angle=Geometry_1.angle),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens={{SF_mC_add[i, j]*kinetics.fissionProducts.mC_gens_add[j] for
            j in 1:Medium.nC} for i in 1:Region_3.nV}))
    annotation (Placement(transformation(
        extent={{-15,13},{15,-13}},
        rotation=0,
        origin={0,-30})));
  FuelModels.FuelGapClad_FD2DCyl fuelModel_Reg1(
    r_outer_fuel=r_outer_fuel_R1,
    r_outer_gap=r_outer_gap_R1,
    r_outer_clad=r_outer_clad_R1,
    nFuelPins=Geometry_1.nPins*nAssembliesReg1,
    redeclare package fuelType = Rods_R1,
    redeclare package gapType = Fuel_gap_R1,
    redeclare package cladType = Fuel_Cladding_R1,
    energyDynamics=energyDynamics_fuel,
    length=Geometry_1.length,
    Tref_fuel=T_Fuel_Init_R1,
    Tref_gap=T_Gap_Init_R1,
    Tref_clad=T_Clad_Init_R1)
                           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-54})));
  TRANSFORM.Blocks.ShapeFactor shapeFactor1(n=Geometry_1.nV, SF_start=
        SF_start_power1)
    annotation (Placement(transformation(extent={{14,-66},{4,-76}})));

    //OuterFuel section
      parameter TRANSFORM.Units.HydraulicResistance R_R2 = 100 annotation(Dialog(group = "Region 2"));
  Modelica.Blocks.Sources.RealExpression Q_Reg2(y=kinetics.Q_total*
        Power_Prod_Frac[2]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,66},{22,76}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Region_2(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesReg2*Geometry_2.nPins,
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
    Ts_start=Ts_start2,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start2,
    ps_start=ps_start2,
    Ts_wall(start={{fuelModel_Reg2.T_start_clad[end, i] for j in 1:Region_2.heatTransfer.nSurfaces}
          for i in 1:Region_2.nV}),
    Xs_start=Xs_start2,
    Cs_start=Cs_start2,
    X_a_start=X_a_start,
    X_b_start=X_b_start,
    C_a_start=C_a_start,
    C_b_start=C_b_start,
    m_flow_a_start=m_flow_a_start2,
    m_flow_b_start=m_flow_b_start2,
    m_flows_start=m_flows_start2,
    exposeState_a=exposeState_a,
    exposeState_b=exposeState_b,
    energyDynamics=energyDynamics,
    traceDynamics=traceDynamics,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        nV=Geometry_2.nV,
        dimension=Geometry_2.dimension,
        crossArea=Geometry_2.crossArea,
        perimeter=Geometry_2.perimeter,
        length=Geometry_2.length,
        roughness=Geometry_2.roughness,
        surfaceArea=Geometry_2.surfaceArea,
        dheight=Geometry_2.dheight,
        nSurfaces=Geometry_2.nSurfaces,
        height_a=Geometry_2.height_a,
        angle=Geometry_2.angle),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens={{SF_mC_add[i, j]*kinetics.fissionProducts.mC_gens_add[j] for
            j in 1:Medium.nC} for i in 1:Region_3.nV})) annotation (Placement(
        transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={0,28})));
  FuelModels.FuelGapClad_FD2DCyl fuelModel_Reg2(
    r_outer_fuel=r_outer_fuel_R2,
    r_outer_gap=r_outer_gap_R2,
    r_outer_clad=r_outer_clad_R2,
    nFuelPins=Geometry_2.nPins*nAssembliesReg2,
    redeclare package fuelType = Rods_R2,
    redeclare package gapType = Fuel_gap_R2,
    redeclare package cladType = Fuel_Cladding_R2,
    energyDynamics=energyDynamics_fuel,
    length=Geometry_2.length,
    Tref_fuel=T_Fuel_Init_R2,
    Tref_gap=T_Gap_Init_R2,
    Tref_clad=T_Clad_Init_R2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,54})));
  TRANSFORM.Blocks.ShapeFactor shapeFactor2(n=Geometry_2.nV, SF_start=
        SF_start_power2)
    annotation (Placement(transformation(extent={{14,66},{4,76}})));

      parameter TRANSFORM.Units.HydraulicResistance R_R4 = 100 annotation(Dialog(group = "Region 4"));

      //Radial blanket section
  Modelica.Blocks.Sources.RealExpression Q_Reg4(y=kinetics.Q_total*
        Power_Prod_Frac[4]) "Total power (fission+decay heat)"
    annotation (Placement(transformation(extent={{38,-138},{22,-148}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Region_4(
    use_HeatTransfer=true,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    nParallel=nAssembliesReg4*Geometry_4.nPins,
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
    Ts_start=Ts_start4,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start4,
    ps_start=ps_start4,
    Ts_wall(start={{fuelModel_Reg4.T_start_clad[end, i] for j in 1:Region_4.heatTransfer.nSurfaces}
          for i in 1:Region_4.nV}),
    Xs_start=Xs_start4,
    Cs_start=Cs_start4,
    X_a_start=X_a_start,
    X_b_start=X_b_start,
    C_a_start=C_a_start,
    C_b_start=C_b_start,
    m_flow_a_start=m_flow_a_start4,
    m_flow_b_start=m_flow_b_start4,
    m_flows_start=m_flows_start4,
    exposeState_a=exposeState_a,
    exposeState_b=exposeState_b,
    energyDynamics=energyDynamics,
    traceDynamics=traceDynamics,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        nV=Geometry_4.nV,
        dimension=Geometry_4.dimension,
        crossArea=Geometry_4.crossArea,
        perimeter=Geometry_4.perimeter,
        length=Geometry_4.length,
        roughness=Geometry_4.roughness,
        surfaceArea=Geometry_4.surfaceArea,
        dheight=Geometry_4.dheight,
        nSurfaces=Geometry_4.nSurfaces,
        height_a=Geometry_4.height_a,
        angle=Geometry_4.angle),
    redeclare model InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens={{SF_mC_add[i, j]*kinetics.fissionProducts.mC_gens_add[j] for
            j in 1:Medium.nC} for i in 1:Region_4.nV})) annotation (Placement(
        transformation(
        extent={{-15,13},{15,-13}},
        rotation=0,
        origin={0,-100})));
  FuelModels.FuelGapClad_FD2DCyl fuelModel_Reg4(
    r_outer_fuel=r_outer_fuel_R4,
    r_outer_gap=r_outer_gap_R4,
    r_outer_clad=r_outer_clad_R4,
    nFuelPins=Geometry_4.nPins*nAssembliesReg4,
    redeclare package fuelType = Rods_R4,
    redeclare package gapType = Fuel_gap_R4,
    redeclare package cladType = Fuel_Cladding_R4,
    energyDynamics=energyDynamics_fuel,
    length=Geometry_4.length,
    Tref_fuel=T_Fuel_Init_R4,
    Tref_gap=T_Gap_Init_R4,
    Tref_clad=T_Clad_Init_R4)
                           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-124})));
  TRANSFORM.Blocks.ShapeFactor shapeFactor3(n=Geometry_4.nV, SF_start=
        SF_start_power4)
    annotation (Placement(transformation(extent={{14,-138},{4,-148}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    IntRefBlanket_Resistance(redeclare package Medium = Medium,
                             R=R_R3)
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    RadialBlanket_Resistance(redeclare package Medium = Medium,
                             R=R_R4)
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Internal_Fuel_Resistance(redeclare package Medium = Medium,
                             R=R_R1)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Outer_Fuel_Resistance(redeclare package Medium = Medium,
                          R=R_R2)
    annotation (Placement(transformation(extent={{-50,18},{-30,38}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-92,-6},{-80,6}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Outlet_T(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{78,-6},{88,6}})));

equation

  connect(fuelModel_Reg3.heatPorts_b, Region_3.heatPorts[:, 1]) annotation (
      Line(points={{0.1,113.8},{0.1,110},{0,110},{0,106.5}}, color={127,0,0}));
  connect(shapeFactor.u, Q_IRB.y)
    annotation (Line(points={{15,143},{21.2,143}}, color={0,0,127}));
  connect(shapeFactor.y, fuelModel_Reg3.Power_in)
    annotation (Line(points={{3.5,143},{0,143},{0,135}}, color={0,0,127}));

  connect(fuelModel_Reg1.heatPorts_b, Region_1.heatPorts[:, 1]) annotation (
      Line(points={{0.1,-43.8},{0.1,-38},{0,-38},{0,-36.5}}, color={127,0,0}));
  connect(shapeFactor1.u, Q_Reg1.y)
    annotation (Line(points={{15,-71},{21.2,-71}}, color={0,0,127}));
  connect(shapeFactor1.y, fuelModel_Reg1.Power_in) annotation (Line(points={{3.5,
          -71},{-1.9984e-15,-71},{-1.9984e-15,-65}}, color={0,0,127}));
  connect(fuelModel_Reg2.heatPorts_b, Region_2.heatPorts[:, 1]) annotation (
      Line(points={{0.1,43.8},{0.1,34},{0,34},{0,34.5}}, color={127,0,0}));
  connect(shapeFactor2.u, Q_Reg2.y)
    annotation (Line(points={{15,71},{21.2,71}}, color={0,0,127}));
  connect(shapeFactor2.y, fuelModel_Reg2.Power_in) annotation (Line(points={{3.5,71},
          {3.5,70},{0,70},{0,65}},     color={0,0,127}));
  connect(shapeFactor3.u, Q_Reg4.y)
    annotation (Line(points={{15,-143},{21.2,-143}}, color={0,0,127}));
  connect(shapeFactor3.y, fuelModel_Reg4.Power_in)
    annotation (Line(points={{3.5,-143},{0,-143},{0,-135}}, color={0,0,127}));
  connect(fuelModel_Reg4.heatPorts_b, Region_4.heatPorts[:, 1]) annotation (
      Line(points={{0.1,-113.8},{0.1,-114},{0,-114},{0,-106.5}}, color={127,0,0}));
  connect(Region_4.port_b, multiPort1.ports_b[1]) annotation (Line(points={{15,-100},
          {46,-100},{46,0},{60,0},{60,3}}, color={0,127,255}));
  connect(Region_1.port_b, multiPort1.ports_b[2]) annotation (Line(points={{15,-30},
          {46,-30},{46,0},{60,0},{60,1}}, color={0,127,255}));
  connect(Region_2.port_b, multiPort1.ports_b[3]) annotation (Line(points={{15,28},
          {46,28},{46,0},{60,0},{60,-1}}, color={0,127,255}));
  connect(Region_3.port_b, multiPort1.ports_b[4]) annotation (Line(points={{15,100},
          {46,100},{46,0},{60,0},{60,-3}}, color={0,127,255}));
  connect(Region_3.port_a, IntRefBlanket_Resistance.port_b)
    annotation (Line(points={{-15,100},{-33,100}}, color={0,127,255}));
  connect(IntRefBlanket_Resistance.port_a, multiPort.ports_b[1]) annotation (
      Line(points={{-47,100},{-62,100},{-62,0},{-68,0},{-68,3}},
                                                       color={0,127,255}));
  connect(Region_4.port_a, RadialBlanket_Resistance.port_b)
    annotation (Line(points={{-15,-100},{-33,-100}}, color={0,127,255}));
  connect(RadialBlanket_Resistance.port_a, multiPort.ports_b[2]) annotation (
      Line(points={{-47,-100},{-62,-100},{-62,0},{-68,0},{-68,1}},
                                                         color={0,127,255}));
  connect(Region_2.port_a, Outer_Fuel_Resistance.port_b)
    annotation (Line(points={{-15,28},{-33,28}}, color={0,127,255}));
  connect(Outer_Fuel_Resistance.port_a, multiPort.ports_b[3]) annotation (Line(
        points={{-47,28},{-62,28},{-62,0},{-68,0},{-68,-1}},
                                                  color={0,127,255}));
  connect(Region_1.port_a, Internal_Fuel_Resistance.port_b)
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
          visible=DynamicSelect(true,showDesignFlowDirection))}),
    Documentation(info="<html>
<p>This model is a multi-region core, allowing for differentiated materials definitions, geometries, and initial conditions across the core. </p>
<p>The original motivation for this model was a sodium fast reactor model. That being said, any multi-region core with significantly differentiated core regions could use this core model. Flow split and join will enforce perfect coolant mixing at the inlet and outlet of the core, but otherwise specific region conditions can vary.</p>
<p>A single coolant is defined and distributed across each region, and for consistency the flow model, heat transfer model (from the coolant), and some advanced settings (such as expose_state) are imposed as identical. The primary goal with this choice is to make sure that the equation set is consistent across the flow split and rejoin. Future adjustment could change that. </p>
<p>Each region is allowed to have different geometries, number of assemblies, and materials defining the assemblies in each section. A single region could be effectively removed to reduce the model to a 2 or 3 region core by increasing the flow resistance value R_R# to a significantly high number (flow should be equal to around (total_R-region_R)/total_R). At least 1 assembly must be defined. For a precise fewer region core, it is recommended to make a new version of this model and then remove one region. </p>
<p>The core kinetics model contains two modes: volume-based and non-volume-based. If kinetics_volume = true, then the kinetics feedback coefficients should be defined as though each region exists through the entire core. Otherwise, each coefficient will have a full value impact based on reference and feedback values. </p>
<p>The core power production fraction distributes the fraction of total power to each of the regions {1,2,3,4}. This value is static through a single simulation, so a user should be selecting a single time in a cycle in which to simulate (not that most simulations are on the order of months, but care should be taken that the fraction may well change throughout a simulation). As noted earlier, this model is based on SFR design, and the kinetics module reflects that in that changes in core power are assumed to be non-local due to the long path length of neutrons in the fast core. </p>
</html>"));
end SFR_Individual_Geometries;
