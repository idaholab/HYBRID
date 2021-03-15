within NHES.Systems.EnergyManifold.SteamManifold.BaseClasses;
partial record Record_SubSystem_A

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

  /* Nominal Conditions */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a1_nominal(
      redeclare package Medium = Medium_1, h=Medium_1.specificEnthalpy(
        Medium_1.setState_pT(port_a1_nominal.p, port_a1_nominal.T))) "port_a1"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b1_nominal(
    redeclare package Medium = Medium_1,
    h=Medium_1.specificEnthalpy(Medium_1.setState_pT(port_b1_nominal.p,
        port_b1_nominal.T)),
    m_flow=-port_a1_nominal.m_flow) "port_b1"
    annotation (Dialog(tab="Nominal Conditions"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a2_nominal(
    redeclare package Medium = Medium_2,
    p=port_b1_nominal.p,
    T=port_b1_nominal.T,
    h=Medium_2.specificEnthalpy(Medium_2.setState_pT(port_a2_nominal.p,
        port_a2_nominal.T))) "port_a2"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_nominal(
    redeclare package Medium = Medium_2,
    p=port_a1_nominal.p,
    T=port_a1_nominal.T,
    h=Medium_2.specificEnthalpy(Medium_2.setState_pT(port_b2_nominal.p,
        port_b2_nominal.T)),
    m_flow=-port_a2_nominal.m_flow) "port_b2"
    annotation (Dialog(tab="Nominal Conditions"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a3_nominal(
    redeclare package Medium = Medium_3,
    p=port_b1_nominal.p,
    T=port_b1_nominal.T,
    h=Medium_3.specificEnthalpy(Medium_3.setState_pT(port_a3_nominal.p,
        port_a3_nominal.T))) "port_a3"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b3_nominal(
    redeclare package Medium = Medium_3,
    p=port_a1_nominal.p,
    T=port_a1_nominal.T,
    h=Medium_3.specificEnthalpy(Medium_3.setState_pT(port_b3_nominal.p,
        port_b3_nominal.T)),
    m_flow=-port_a3_nominal.m_flow) "port_b3"
    annotation (Dialog(tab="Nominal Conditions"));

  /* Initialization */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a1_start(
    redeclare package Medium = Medium_1,
    p=port_a1_nominal.p,
    T=port_a1_nominal.T,
    h=Medium_1.specificEnthalpy(Medium_1.setState_pT(port_a1_start.p,
        port_a1_start.T)),
    m_flow=port_a1_nominal.m_flow) "port_a1"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b1_start(
    redeclare package Medium = Medium_1,
    p=port_b1_nominal.p,
    T=port_b1_nominal.T,
    h=Medium_1.specificEnthalpy(Medium_1.setState_pT(port_b1_start.p,
        port_b1_start.T)),
    m_flow=-port_a1_start.m_flow) "port_b1"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a2_start(
    redeclare package Medium = Medium_2,
    p=port_a2_nominal.p,
    T=port_a2_nominal.T,
    h=Medium_2.specificEnthalpy(Medium_2.setState_pT(port_a2_start.p,
        port_a2_start.T)),
    m_flow=port_a2_nominal.m_flow) "port_a2"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_start(
    redeclare package Medium = Medium_2,
    p=port_b2_nominal.p,
    T=port_b2_nominal.T,
    h=Medium_2.specificEnthalpy(Medium_2.setState_pT(port_b2_start.p,
        port_b2_start.T)),
    m_flow=-port_a2_start.m_flow) "port_b2"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a3_start(
    redeclare package Medium = Medium_3,
    p=port_a3_nominal.p,
    T=port_a3_nominal.T,
    h=Medium_3.specificEnthalpy(Medium_3.setState_pT(port_a3_start.p,
        port_a3_start.T)),
    m_flow=port_a3_nominal.m_flow) "port_a3"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b3_start(
    redeclare package Medium = Medium_3,
    p=port_b3_nominal.p,
    T=port_b3_nominal.T,
    h=Medium_3.specificEnthalpy(Medium_3.setState_pT(port_b3_start.p,
        port_b3_start.T)),
    m_flow=-port_a3_start.m_flow) "port_b3"
    annotation (Dialog(tab="Initialization"));

  /* Assumptions */
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  annotation (defaultComponentName="subsystem",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Record_SubSystem_A;
