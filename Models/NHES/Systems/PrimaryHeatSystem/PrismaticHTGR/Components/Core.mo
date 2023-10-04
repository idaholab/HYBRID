within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Components;
model Core

  import TRANSFORM;
  import TRANSFORM.Math.linspace_1D;
  import TRANSFORM.Math.linspaceRepeat_1D;
  import Modelica.Fluid.Types.ModelStructure;
  import TRANSFORM.Fluid.Types.LumpedLocation;
  import Modelica.Fluid.Types.Dynamics;
  parameter Real Fr=1.1 "Radial Power Peaking Factor";
  Subchannel Center(
    redeclare package Medium = Medium,
    r_coolant=geometry.R_Coolant,
    pitch=geometry.pitch,
    r_graphite=geometry.r_graphite,
    r_fuel=geometry.r_fuel,
    H=geometry.H,
    nZ=geometry.nV,
    RodPowers={1/6,1/6,1/6,1/6,1/6,1/6},
    T_Fouter_start=T_Fouter_start,
    T_Finner_start=T_Finner_start,
    T_Mod_start=T_Mod_start,
    T_Cinlet_start=T_Cinlet_start,
    T_Coutlet_start=T_Coutlet_start)
    annotation (Placement(transformation(extent={{-20,-40},{20,0}})));
  Subchannel Corner(
    redeclare package Medium = Medium,
    r_coolant=geometry.R_Coolant,
    pitch=geometry.pitch,
    r_graphite=geometry.r_graphite,
    r_fuel=geometry.r_fuel,
    H=geometry.H,
    nZ=geometry.nV,
    RodPowers={1/11,1/11,3/22,3/11,3/11,3/22},
    T_Fouter_start=T_Fouter_start,
    T_Finner_start=T_Finner_start,
    T_Mod_start=T_Mod_start,
    T_Cinlet_start=T_Cinlet_start,
    T_Coutlet_start=T_Coutlet_start)
    annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
  Subchannel Edge(
    redeclare package Medium = Medium,
    r_coolant=geometry.R_Coolant,
    pitch=geometry.pitch,
    r_graphite=geometry.r_graphite,
    r_fuel=geometry.r_fuel,
    H=geometry.H,
    nZ=geometry.nV,
    RodPowers={1/9,1/9,1/9,1/6,1/3,1/6},
    T_Fouter_start=T_Fouter_start,
    T_Finner_start=T_Finner_start,
    T_Mod_start=T_Mod_start,
    T_Cinlet_start=T_Cinlet_start,
    T_Coutlet_start=T_Coutlet_start)
    annotation (Placement(transformation(extent={{-20,0},{20,40}})));
  Subchannel Hot(
    redeclare package Medium = Medium,
    r_coolant=geometry.R_Coolant,
    pitch=geometry.pitch,
    r_graphite=geometry.r_graphite,
    r_fuel=geometry.r_fuel,
    H=geometry.H,
    nZ=geometry.nV,
    RodPowers={1/11,1/11,3/22,3/11,3/11,3/22},
    T_Fouter_start=T_Fouter_start - 200,
    T_Finner_start=T_Finner_start - 200,
    T_Mod_start=T_Mod_start - 200,
    T_Cinlet_start=T_Cinlet_start - 200,
    T_Coutlet_start=T_Coutlet_start - 200)
    annotation (Placement(transformation(extent={{-20,60},{20,100}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplierTin(redeclare package
      Medium = Medium, capacityScaler=1/geometry.nAsm)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplier1(redeclare package
      Medium = Medium, capacityScaler=geometry.nAsm)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T_in(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
      Medium =
        Medium)
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p_in(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T_out(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p_out(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{70,20},{90,40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT hot_in(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT hot_out(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{80,70},{60,90}})));
  Data.Generic_PHTGR
           geometry
            annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression Total_Power(y=kinetics.Q_total)
    annotation (Placement(transformation(extent={{-226,-10},{-206,10}})));
  Modelica.Blocks.Math.Division ASMdivision
    annotation (Placement(transformation(extent={{-190,-16},{-170,4}})));
  Modelica.Blocks.Sources.RealExpression Asm_n(y=geometry.nAsm)
    annotation (Placement(transformation(extent={{-226,-22},{-206,-2}})));
  Modelica.Blocks.Math.Product EdgePowerproduct
    annotation (Placement(transformation(extent={{-150,24},{-130,44}})));
  Modelica.Blocks.Math.Product Centerpowerproduct
    annotation (Placement(transformation(extent={{-150,-16},{-130,4}})));
  Modelica.Blocks.Math.Product CornerPowerproduct
    annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
  Modelica.Blocks.Sources.RealExpression EdgePowerRatio(y=3/geometry.nPins)
    annotation (Placement(transformation(extent={{-190,30},{-170,50}})));
  Modelica.Blocks.Sources.RealExpression CenterPowerRatio(y=2/geometry.nPins)
    annotation (Placement(transformation(extent={{-190,4},{-170,24}})));
  Modelica.Blocks.Sources.RealExpression CornerPowerRatio(y=(11/3)/geometry.nPins)
    annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
  Modelica.Blocks.Math.Product HotChannel
    annotation (Placement(transformation(extent={{-120,84},{-100,104}})));
  replaceable package Medium =
      Modelica.Media.IdealGases.SingleGases.He
    annotation (choicesAllMatching=true);
     /* Kinetics */
  parameter Modelica.Units.SI.Power Q_nominal=1e6
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
      TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.PartialDecayHeat_powerBased
    annotation (choicesAllMatching=true,Dialog(tab="Kinetics",group="Decay-Heat"));
  replaceable record Data_FP =
      TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.PartialFissionProduct                                                                        annotation (
     choicesAllMatching=true,Dialog(tab="Kinetics",group="Fission Products"));
  parameter Modelica.Units.SI.Area sigmasA_add_start[Medium.nC]=fill(0, Medium.nC)
    "Microscopic absorption cross-section for reactivity feedback"
    annotation (Dialog(tab="Kinetics", group="Fluid Trace Substances"));
  input Modelica.Units.SI.Power Q_fission_input=Q_nominal
    "Fission power (if specifyPower=true)" annotation (Dialog(group="Input"));
  input Modelica.Units.SI.Power Q_external=0
    "Power from external source of neutrons" annotation (Dialog(group="Input"));
  input TRANSFORM.Units.NonDim rho_input=0 "External Reactivity"
    annotation (Dialog(group="Input"));
  parameter Modelica.Units.SI.Area dsigmasA_add[Medium.nC]=fill(1, Medium.nC)
    "Change in microscopic absorption cross-section for reactivity feedback"
    annotation (Dialog(tab="Parameter Change", group="Input: Fluid Trace Substances"));
  parameter Modelica.Units.SI.Time Lambda_start=1e-5
    "Prompt neutron generation time"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics"));
  parameter Boolean use_history=false "=true to provide power history"
                                                                      annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
  parameter Modelica.Units.SI.Power history[:,2]=fill(
      0,
      0,
      2) "Power history up to simulation time=0, [t,Q]"
    annotation (Dialog(tab="Kinetics", group="Decay-Heat"));
  parameter Boolean includeDH=false
    "=true if power history includes decay heat" annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
  parameter Modelica.Units.SI.Power Q_fission_start=Q_nominal/(1 + sum(kinetics.efs_dh_start))
    "Initial reactor fission power"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics"));
  parameter Modelica.Units.SI.Power Cs_pg_start[kinetics.nC]={kinetics.betas_start[
      j]/(kinetics.lambdas_start[j]*Lambda_start)*Q_fission_start for j in 1:
      kinetics.nC}
    "Power of the initial delayed-neutron precursor concentrations"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics"));
  parameter Modelica.Units.SI.Energy Es_start[kinetics.nDH]={Q_fission_start*
      kinetics.efs_dh_start[j]/kinetics.lambdas_dh_start[j] for j in 1:kinetics.nDH}
    "Initial decay heat group energy"
    annotation (Dialog(tab="Kinetics", group="Decay-Heat"));
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
  input Modelica.Units.SI.Time dLambda=0
    "Change in prompt neutron generation time" annotation (Dialog(tab="Parameter Change",
        group="Input: Neutron Kinetics"));
  input TRANSFORM.Units.InverseTime dlambdas_dh[kinetics.nDH]=fill(0, kinetics.nDH)
    "Change in decay constant"
    annotation (Dialog(tab="Parameter Change", group="Input: Decay-Heat"));
  input TRANSFORM.Units.NonDim defs_dh[kinetics.nDH]=fill(0, kinetics.nDH)
    "Change in effective energy fraction"
    annotation (Dialog(tab="Parameter Change", group="Input: Decay-Heat"));

  parameter TRANSFORM.Units.TempFeedbackCoeff alpha_fuel=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_mod=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter Modelica.Units.SI.Temperature Teffref_fuel=0
    "Fuel reference temperature"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
  parameter Modelica.Units.SI.Temperature Teffref_mod=0
    "Coolant reference temperature"
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
  parameter Modelica.Units.SI.Energy w_f_start=200e6*1.6022e-19
    "Energy released per fission"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
  parameter Modelica.Units.SI.MacroscopicCrossSection SigmaF_start=1
    "Macroscopic fission cross-section of fissile material"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));
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
  input Modelica.Units.SI.Energy dw_f=0 "Change in energy released per fission"
    annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
  input Modelica.Units.SI.MacroscopicCrossSection dSigmaF=0
    "Change in macroscopic fission cross-section of fissile material"
    annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
  input Modelica.Units.SI.Area dsigmasA[kinetics.nFP]=fill(0, kinetics.nFP)
    "Change in microscopic absorption cross-section for reactivity feedback"
    annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
  input Real dfissionYields[kinetics.nFP,kinetics.nFS,kinetics.nT]=fill(
      0,
      kinetics.nFP,
      kinetics.nFS,
      kinetics.nT)
    "Change in # fission product atoms yielded per fission per fissile source [#/fission]" annotation(Dialog(tab="Parameter Change",group="Input: Fission Products"));
  input TRANSFORM.Units.InverseTime dlambdas_FP[kinetics.nFP]=fill(0, kinetics.nFP)
    "Change in decay constants for each fission product" annotation (Dialog(tab=
         "Parameter Change", group="Input: Fission Products"));

  Fluid.Utilities.FlowMultiplier       flowMultiplierEin(redeclare package
      Medium = Medium, capacityScaler=1/geometry.nChannels[2])
    annotation (Placement(transformation(extent={{-44,10},{-24,30}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplierCein(redeclare package
      Medium = Medium, capacityScaler=1/geometry.nChannels[1])
    annotation (Placement(transformation(extent={{-44,-30},{-24,-10}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplierCoin(redeclare package
      Medium = Medium, capacityScaler=1/geometry.nChannels[3])
    annotation (Placement(transformation(extent={{-44,-70},{-24,-50}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplierCoout(redeclare package
              Medium = Medium, capacityScaler=geometry.nChannels[3])
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplierCeout(redeclare package
              Medium = Medium, capacityScaler=geometry.nChannels[1])
    annotation (Placement(transformation(extent={{26,-30},{46,-10}})));
  Fluid.Utilities.FlowMultiplier       flowMultiplierEout(redeclare package
      Medium = Medium, capacityScaler=geometry.nChannels[3])
    annotation (Placement(transformation(extent={{26,10},{46,30}})));
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
    nFeedback=2,
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
    alphas_feedback={alpha_fuel_ft.y,alpha_mod_ft.y},
    vals_feedback={fuelModel.T_avg,AverageModT.y},
    vals_feedback_reference={Teffref_fuel,Teffref_mod},
    Q_fission_start=Q_fission_start,
    Cs_start=Cs_pg_start,
    Es_start=Es_start,
    V=(geometry.H*Modelica.Constants.pi*geometry.r_fuel^2)*geometry.nAsm*
        geometry.nPins,
    mCs_start=mCs_fp_start,
    mCs_add={sum(Center.channel.mCs[:, j])*geometry.nAsm*geometry.nChannels[1]
        for j in 1:Medium.nC} + {sum(Edge.channel.mCs[:, j])*geometry.nAsm*
        geometry.nChannels[2] for j in 1:Medium.nC} + {sum(Corner.channel.mCs[:,
        j])*geometry.nAsm*geometry.nChannels[3] for j in 1:Medium.nC},
    Vs_add=((geometry.H)*Modelica.Constants.pi*geometry.r_fuel^2)*geometry.nAsm*
        geometry.nPins,
    toggle_ReactivityFP=toggle_ReactivityFP)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
   Modelica.Blocks.Sources.RealExpression alpha_fuel_ft(y=(0.0000246)*log(
        fuelModel.T_avg - 273.15) - 0.00021465)
                    "Fuel reactivity feedback as a fuciton of temperature"
    annotation (Placement(transformation(extent={{120,-34},{140,-14}})));
   Modelica.Blocks.Sources.RealExpression alpha_mod_ft(y=((-5.263E-14)*((
        AverageModT.y - 273.15)^3) + (2.023E-10)*((AverageModT.y - 273.15)^
        2) - (2.48E-7)*((AverageModT.y - 273.15)) + 8.728E-5))
                    "Fuel reactivity feedback as a fuciton of temperature"
    annotation (Placement(transformation(extent={{120,-48},{140,-28}})));
  Modelica.Blocks.Sources.RealExpression AverageSiCT(y=((Center.SiC_avg*
        geometry.nChannels[1] + Edge.SiC_avg*geometry.nChannels[2] + Corner.SiC_avg
        *geometry.nChannels[3])/19) + 273.15) "in K"
    annotation (Placement(transformation(extent={{120,-92},{140,-72}})));
  Modelica.Blocks.Sources.RealExpression AverageModT(y=(Center.Mod_avg*geometry.nChannels[
        1] + Edge.Mod_avg*geometry.nChannels[2] + Corner.Mod_avg*geometry.nChannels[
        3])/19) "in K"
    annotation (Placement(transformation(extent={{120,-78},{140,-58}})));
  Modelica.Blocks.Sources.RealExpression MaxSiCT(y=Hot.SiC_max + 273.15)
    "in K"
    annotation (Placement(transformation(extent={{120,-62},{140,-42}})));
  TRISO_Pellet fuelModel(
    packing_factor=0.3822,
    nPins=geometry.nPins,
    nAsm=geometry.nAsm,
    r_pellet=geometry.r_fuel,
    H=geometry.H,
    Fp=Fp,
    redeclare package Fuel_Kernel_Material = Fuel_Kernel_Material,
    redeclare package pellet_Material = pellet_Material)
    annotation (Placement(transformation(extent={{-10,-122},{10,-102}})));
  parameter Real Fp=1.2 "Core Power Peaking Factor, F_radial*F_axial*F_";
  replaceable package Fuel_Kernel_Material =
      TRANSFORM.Media.Solids.UO2 annotation (
      choicesAllMatching=true);
  replaceable package pellet_Material =
      NHES.Media.Solids.SiliconCarbide annotation (
      choicesAllMatching=true);
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
parameter Boolean toggle_ReactivityFP=true
    "=true to include fission product reacitivity feedback"
    annotation (Dialog(tab="Kinetics", group="Fission Products"));

  parameter Modelica.Units.SI.Temperature T_Fouter_start=900 + 273.15
    "Outer Fuel Temperature Start";
  parameter Modelica.Units.SI.Temperature T_Finner_start=950 + 273.15
    "Inner Fuel Temperature Start";
  parameter Modelica.Units.SI.Temperature T_Mod_start=700 + 273.15
    "Moderator Temperature Start";
  parameter Modelica.Units.SI.Temperature T_Cinlet_start=600 + 273.15
    "Coolant Inner Temperature Start";
  parameter Modelica.Units.SI.Temperature T_Coutlet_start=600 + 273.15
    "Coolant Oulet Temperature Start";
  Modelica.Blocks.Sources.RealExpression
                               realExpression(y=Fr)
    annotation (Placement(transformation(extent={{-180,90},{-160,110}})));
equation
  connect(flowMultiplier1.port_b, port_b)
    annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
  connect(port_a, sensor_m_flow.port_a)
    annotation (Line(points={{-100,0},{-92,0}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, flowMultiplierTin.port_a)
    annotation (Line(points={{-72,0},{-72,0}}, color={0,127,255}));
  connect(flowMultiplierTin.port_a, sensor_T_in.port)
    annotation (Line(points={{-72,0},{-72,20},{-60,20}}, color={0,127,255}));
  connect(sensor_T_in.port, sensor_p_in.port)
    annotation (Line(points={{-60,20},{-80,20}}, color={0,127,255}));
  connect(sensor_p_out.port, flowMultiplier1.port_b)
    annotation (Line(points={{80,20},{90,20},{90,0}}, color={0,127,255}));
  connect(sensor_T_out.port, sensor_p_out.port)
    annotation (Line(points={{60,20},{80,20}}, color={0,127,255}));
  connect(sensor_p_in.p, hot_in.p_in) annotation (Line(points={{-74,30},{-74,44},
          {-90,44},{-90,88},{-82,88}}, color={0,0,127}));
  connect(sensor_T_in.T, hot_in.T_in) annotation (Line(points={{-54,30},{-48,30},
          {-48,46},{-88,46},{-88,84},{-82,84}}, color={0,0,127}));
  connect(sensor_p_out.p, hot_out.p_in) annotation (Line(points={{86,30},{100,30},
          {100,88},{82,88}}, color={0,0,127}));
  connect(hot_in.ports[1], Hot.port_a)
    annotation (Line(points={{-60,80},{-20,80}}, color={0,127,255}));
  connect(Hot.port_b, hot_out.ports[1])
    annotation (Line(points={{20,80},{60,80}}, color={0,127,255}));
  connect(sensor_T_out.T, hot_out.T_in) annotation (Line(points={{66,30},{66,34},
          {98,34},{98,84},{82,84}}, color={0,0,127}));
  connect(Total_Power.y, ASMdivision.u1)
    annotation (Line(points={{-205,0},{-192,0}},   color={0,0,127}));
  connect(Asm_n.y, ASMdivision.u2)
    annotation (Line(points={{-205,-12},{-192,-12}}, color={0,0,127}));
  connect(EdgePowerRatio.y, EdgePowerproduct.u1)
    annotation (Line(points={{-169,40},{-152,40}}, color={0,0,127}));
  connect(CenterPowerRatio.y, Centerpowerproduct.u1) annotation (Line(points={{-169,14},
          {-166,14},{-166,0},{-152,0}},       color={0,0,127}));
  connect(CornerPowerRatio.y, CornerPowerproduct.u1)
    annotation (Line(points={{-169,-40},{-152,-40}}, color={0,0,127}));
  connect(ASMdivision.y, EdgePowerproduct.u2) annotation (Line(points={{-169,-6},
          {-158,-6},{-158,28},{-152,28}},  color={0,0,127}));
  connect(ASMdivision.y, Centerpowerproduct.u2) annotation (Line(points={{-169,-6},
          {-158,-6},{-158,-12},{-152,-12}},  color={0,0,127}));
  connect(ASMdivision.y, CornerPowerproduct.u2) annotation (Line(points={{-169,-6},
          {-158,-6},{-158,-52},{-152,-52}},  color={0,0,127}));
  connect(HotChannel.y, Hot.PowerIn)
    annotation (Line(points={{-99,94},{-14,94}}, color={0,0,127}));
  connect(flowMultiplierTin.port_b, flowMultiplierEin.port_a) annotation (Line(
        points={{-52,0},{-48,0},{-48,20},{-44,20}}, color={0,127,255}));
  connect(flowMultiplierTin.port_b, flowMultiplierCein.port_a) annotation (Line(
        points={{-52,0},{-48,0},{-48,-20},{-44,-20}}, color={0,127,255}));
  connect(flowMultiplierTin.port_b, flowMultiplierCoin.port_a) annotation (Line(
        points={{-52,0},{-48,0},{-48,-60},{-44,-60}}, color={0,127,255}));
  connect(flowMultiplierEin.port_b, Edge.port_a)
    annotation (Line(points={{-24,20},{-20,20}}, color={0,127,255}));
  connect(Center.port_a, flowMultiplierCein.port_b)
    annotation (Line(points={{-20,-20},{-24,-20}}, color={0,127,255}));
  connect(flowMultiplierCoin.port_b, Corner.port_a)
    annotation (Line(points={{-24,-60},{-20,-60}}, color={0,127,255}));
  connect(Corner.port_b, flowMultiplierCoout.port_a)
    annotation (Line(points={{20,-60},{26,-60}}, color={0,127,255}));
  connect(Center.port_b, flowMultiplierCeout.port_a)
    annotation (Line(points={{20,-20},{26,-20}}, color={0,127,255}));
  connect(Edge.port_b, flowMultiplierEout.port_a)
    annotation (Line(points={{20,20},{26,20}}, color={0,127,255}));
  connect(flowMultiplierEout.port_b, flowMultiplier1.port_a) annotation (Line(
        points={{46,20},{52,20},{52,0},{70,0}}, color={0,127,255}));
  connect(flowMultiplierCeout.port_b, flowMultiplier1.port_a) annotation (Line(
        points={{46,-20},{52,-20},{52,0},{70,0}}, color={0,127,255}));
  connect(flowMultiplierCoout.port_b, flowMultiplier1.port_a) annotation (Line(
        points={{46,-60},{52,-60},{52,0},{70,0}}, color={0,127,255}));
  connect(MaxSiCT.y, fuelModel.Tin_max) annotation (Line(points={{141,-52},
          {148,-52},{148,-118},{9,-118}},
                                     color={0,0,127}));
  connect(AverageSiCT.y, fuelModel.Tin_avg) annotation (Line(points={{141,-82},
          {146,-82},{146,-106},{9,-106}},color={0,0,127}));
  connect(Total_Power.y, fuelModel.Power_in) annotation (Line(points={{-205,0},
          {-198,0},{-198,-112},{-11,-112}},color={0,0,127}));
  connect(realExpression.y, HotChannel.u1)
    annotation (Line(points={{-159,100},{-122,100}}, color={0,0,127}));
  connect(EdgePowerproduct.y, Edge.PowerIn)
    annotation (Line(points={{-129,34},{-14,34}}, color={0,0,127}));
  connect(Center.PowerIn, Centerpowerproduct.y)
    annotation (Line(points={{-14,-6},{-129,-6}}, color={0,0,127}));
  connect(CornerPowerproduct.y, Corner.PowerIn)
    annotation (Line(points={{-129,-46},{-14,-46}}, color={0,0,127}));
  connect(CornerPowerproduct.y, HotChannel.u2) annotation (Line(points={{
          -129,-46},{-126,-46},{-126,88},{-122,88}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                             Ellipse(
          extent={{-92,30},{-108,-30}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_a),    Rectangle(
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
          visible=DynamicSelect(true,showDesignFlowDirection))}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Prismatic HTGR core model</p>
<p>Four subchannel types, center, edge, corner, and hot, with flow rates scaled down and back up by the number of channels.</p>
<p>Hot channel is not connected to the main flow path and is used for max temperature values</p>
<p><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p>
</html>"));
end Core;
