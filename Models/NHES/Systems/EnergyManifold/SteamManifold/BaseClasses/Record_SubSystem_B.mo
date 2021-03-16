within NHES.Systems.EnergyManifold.SteamManifold.BaseClasses;
partial record Record_SubSystem_B

  extends Record_SubSystem;

  replaceable package Medium_1 = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium at fluid ports 1" annotation (choicesAllMatching=true);

  replaceable package Medium_2 = Medium_1 constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports 2"
    annotation (choicesAllMatching=true);
  replaceable package Medium_3 = Medium_1 constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports 3"
    annotation (choicesAllMatching=true);

  parameter Integer nPorts_a3=0 "Number of port_a3 connections"
    annotation (Dialog(connectorSizing=true));
  parameter Integer nPorts_b3=0 "Number of port_b3 connections"
    annotation (Dialog(connectorSizing=true));

  /* Assumptions */
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  /* Nominal Conditions */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a1_nominal(
    redeclare package Medium = Medium_1,
    h=Medium_1.specificEnthalpy(Medium_1.setState_pT(port_a1_nominal.p, port_a1_nominal.T))) "port_a1"
    annotation (Dialog(tab="Nominal Conditions",group="Ports"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b1_nominal(
    redeclare package Medium = Medium_1,
    h=Medium_1.specificEnthalpy(Medium_1.setState_pT(port_b1_nominal.p,port_b1_nominal.T)),
    m_flow=-(port_a2_nominal.m_flow+sum({port_a3_nominal_m_flow[i] for i in 1:nPorts_a3}))) "port_b1"
    annotation (Dialog(tab="Nominal Conditions",group="Ports"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a2_nominal(
    redeclare package Medium = Medium_2,
    p=port_b1_nominal.p,
    T=Medium_2.temperature(Medium_2.setState_ph(port_a2_nominal.p,port_a2_nominal.h)),
    h=port_b1_nominal.h,
    m_flow=-port_b2_nominal.m_flow) "port_a2"
    annotation (Dialog(tab="Nominal Conditions",group="Ports"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_nominal(
    redeclare package Medium = Medium_2,
    p=port_a1_nominal.p,
    T=Medium_2.temperature(Medium_2.setState_ph(port_b2_nominal.p,port_b2_nominal.h)),
    h=port_a1_nominal.h,
    m_flow=-(port_a1_nominal.m_flow+sum({port_b3_nominal_m_flow[i] for i in 1:nPorts_b3}))) "port_b2"
    annotation (Dialog(tab="Nominal Conditions",group="Ports"));

  parameter SI.Pressure port_a3_nominal_p[nPorts_a3] = fill(port_b1_nominal.p, nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.Temperature port_a3_nominal_T[nPorts_a3] = fill(port_b1_nominal.T, nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.SpecificEnthalpy port_a3_nominal_h[nPorts_a3] = Medium_3.specificEnthalpy(Medium_3.setState_pT(port_a3_nominal_p,port_a3_nominal_T)) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.MassFlowRate port_a3_nominal_m_flow[nPorts_a3] = zeros(nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));

  parameter SI.Pressure port_b3_nominal_p[nPorts_b3] = fill(port_a1_nominal.p, nPorts_b3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.Temperature port_b3_nominal_T[nPorts_b3] = fill(port_a1_nominal.T, nPorts_b3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.SpecificEnthalpy port_b3_nominal_h[nPorts_b3] = Medium_3.specificEnthalpy(Medium_3.setState_pT(port_b3_nominal_p,port_b3_nominal_T)) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.MassFlowRate port_b3_nominal_m_flow[nPorts_b3] = zeros(nPorts_b3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));

  /* Initialization */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a1_start(
    redeclare package Medium = Medium_1,
    p=port_a1_nominal.p,
    T=port_a1_nominal.T,
    h=Medium_1.specificEnthalpy(Medium_1.setState_pT(port_a1_start.p,port_a1_start.T)),
    m_flow=port_a1_nominal.m_flow) "port_a1"
    annotation (Dialog(tab="Initialization",group="Ports"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b1_start(
    redeclare package Medium = Medium_1,
    p=port_b1_nominal.p,
    T=Medium_1.temperature(Medium_1.setState_ph(port_b1_start.p, port_b1_start.h)),
    h=port_b1_nominal.h,
    m_flow=port_b1_nominal.m_flow) "port_b1"
    annotation (Dialog(tab="Initialization",group="Ports"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a2_start(
    redeclare package Medium = Medium_2,
    p=port_a2_nominal.p,
    T=Medium_2.temperature(Medium_2.setState_ph(port_a2_start.p, port_a2_start.h)),
    h=port_a2_nominal.h,
    m_flow=port_a2_nominal.m_flow) "port_a2"
    annotation (Dialog(tab="Initialization",group="Ports"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_start(
    redeclare package Medium = Medium_2,
    p=port_b2_nominal.p,
    T=Medium_2.temperature(Medium_2.setState_ph(port_b2_start.p, port_b2_start.h)),
    h=port_b2_nominal.h,
    m_flow=port_b2_nominal.m_flow) "port_b2"
    annotation (Dialog(tab="Initialization",group="Ports"));

  parameter SI.Pressure port_a3_start_p[nPorts_a3] = port_a3_nominal_p annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.Temperature port_a3_start_T[nPorts_a3] = Medium_3.temperature(Medium_3.setState_ph(port_a3_start_p, port_a3_start_h)) annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.SpecificEnthalpy port_a3_start_h[nPorts_a3] = port_a3_nominal_h annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.MassFlowRate port_a3_start_m_flow[nPorts_a3] = port_a3_nominal_m_flow annotation (Dialog(tab="Initialization",group="Conditional Ports"));

  parameter SI.Pressure port_b3_start_p[nPorts_b3] = port_b3_nominal_p annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.Temperature port_b3_start_T[nPorts_b3] = Medium_3.temperature(Medium_3.setState_ph(port_b3_start_p, port_b3_start_h)) annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.SpecificEnthalpy port_b3_start_h[nPorts_b3] = port_b3_nominal_h annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.MassFlowRate port_b3_start_m_flow[nPorts_b3] = port_b3_nominal_m_flow annotation (Dialog(tab="Initialization",group="Conditional Ports"));

// Using records with conditional ports gave unsupported zero errors.
// Arrays of parameters were used instead.
// The code below is kept as reference for what was tried.
  // Nominal
//   parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a3_nominal[nPorts_a3](
//     redeclare each package Medium = Medium_3,
//     p=fill(port_b1_nominal.p, nPorts_a3),
//     T=fill(port_b1_nominal.T, nPorts_a3),
//     h=Medium_3.specificEnthalpy(Medium_3.setState_pT(port_a3_nominal.p,port_a3_nominal.T)),
//     m_flow=zeros(nPorts_a3)) "port_a3"
//     annotation (Dialog(tab="Nominal Conditions"));
//   parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b3_nominal[nPorts_b3](
//     redeclare each package Medium = Medium_3,
//     p=fill(port_a1_nominal.p, nPorts_b3),
//     T=fill(port_a1_nominal.T, nPorts_b3),
//     h=Medium_3.specificEnthalpy(Medium_3.setState_pT(port_b3_nominal.p,port_b3_nominal.T)),
//     m_flow=-port_a3_nominal.m_flow) "port_b3"
//     annotation (Dialog(tab="Nominal Conditions"));
//
//   // Initialization
//   parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a3_start[nPorts_a3](
//     redeclare each package Medium = Medium_3,
//     p=port_a3_nominal.p,
//     T=Medium_3.temperature(Medium_3.setState_ph(port_a3_start.p, port_a3_start.h)),
//     h=port_a3_nominal.h,
//     m_flow=port_a3_nominal.m_flow) "port_a3"
//     annotation (Dialog(tab="Initialization"));
//
//   parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b3_start[nPorts_b3](
//     redeclare each package Medium = Medium_3,
//     p=port_b3_nominal.p,
//     T=Medium_3.temperature(Medium_3.setState_ph(port_b3_start.p, port_b3_start.h)),
//     h=port_b3_nominal.h,
//     m_flow=port_b3_nominal.m_flow) "port_b3"
//     annotation (Dialog(tab="Initialization"));
  annotation (
    defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end Record_SubSystem_B;
