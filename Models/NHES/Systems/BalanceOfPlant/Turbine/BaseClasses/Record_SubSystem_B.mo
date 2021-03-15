within NHES.Systems.BalanceOfPlant.Turbine.BaseClasses;
partial record Record_SubSystem_B

  extends Record_SubSystem;

  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
    annotation (choicesAllMatching=true);

  parameter Integer nPorts_a3=0 "Number of port_a3 connections"
    annotation (Dialog(connectorSizing=true));

  /* Assumptions */
  parameter Boolean allowFlowReversal= true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  /* Nominal Conditions */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_nominal(
      redeclare package Medium = Medium, final T=Medium.temperature(
        Medium.setState_ph(port_a_nominal.p, port_a_nominal.h))) "port_a"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_nominal(
    redeclare package Medium = Medium,
    final T=Medium.temperature(Medium.setState_ph(port_b_nominal.p,
        port_b_nominal.h)),
    m_flow=-(port_a_nominal.m_flow+sum({port_a3_nominal_m_flow[i] for i in 1:nPorts_a3}))) "port_b"
    annotation (Dialog(tab="Nominal Conditions"));

  parameter SI.Pressure port_a3_nominal_p[nPorts_a3] = fill(port_b_nominal.p, nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  final parameter SI.Temperature port_a3_nominal_T[nPorts_a3] = Medium.temperature(Medium.setState_ph(port_a3_nominal_p,port_a3_nominal_h)) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.SpecificEnthalpy port_a3_nominal_h[nPorts_a3] = fill(port_b_nominal.h, nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
  parameter SI.MassFlowRate port_a3_nominal_m_flow[nPorts_a3] = zeros(nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));

  /* Initialization */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_start(
    redeclare package Medium = Medium,
    p=port_a_nominal.p,
    final T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
    h=port_a_nominal.h,
    m_flow=port_a_nominal.m_flow) "port_a"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_start(
    redeclare package Medium = Medium,
    p=port_b_nominal.p,
    final T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
    h=port_b_nominal.h,
    m_flow=port_b_nominal.m_flow) "port_b"
    annotation (Dialog(tab="Initialization"));

  parameter SI.Pressure port_a3_start_p[nPorts_a3] = port_a3_nominal_p annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  final parameter SI.Temperature port_a3_start_T[nPorts_a3] = Medium.temperature(Medium.setState_ph(port_a3_start_p, port_a3_start_h)) annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.SpecificEnthalpy port_a3_start_h[nPorts_a3] = port_a3_nominal_h annotation (Dialog(tab="Initialization",group="Conditional Ports"));
  parameter SI.MassFlowRate port_a3_start_m_flow[nPorts_a3] = port_a3_nominal_m_flow annotation (Dialog(tab="Initialization",group="Conditional Ports"));

  annotation (defaultComponentName="subsystem",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Record_SubSystem_B;
