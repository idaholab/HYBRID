within NHES.Desalination.MEE.BaseClasses;
partial record Record_SubSystem_A

  extends Record_SubSystem;

  replaceable package Water = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
    annotation (choicesAllMatching=true);
  replaceable package Brine = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX) constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
    annotation (choicesAllMatching=true);

  /* Nominal Conditions */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_nominal(
      redeclare package Medium = Water, h=Water.specificEnthalpy(
        Water.setState_pT(port_a_nominal.p, port_a_nominal.T))) "port_a"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_nominal(
      redeclare package Medium = Water, h=Water.specificEnthalpy(
        Water.setState_pT(port_b_nominal.p, port_b_nominal.T)),
    m_flow=-port_a_nominal.m_flow) "port_b"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_nominal(
      redeclare package Medium = Water, h=Water.specificEnthalpy(
        Water.setState_pT(port_b2_nominal.p, port_b2_nominal.T)),
    m_flow=-port_a_nominal.m_flow) "port_b"
    annotation (Dialog(tab="Nominal Conditions"));

  parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_a1_nominal(
      redeclare package Medium = Brine, h=Brine.specificEnthalpy(
        Brine.setState_pTX(port_a1_nominal.p, port_a1_nominal.T,
        port_a1_nominal.X))) "port_a"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_b1_nominal(
    redeclare package Medium = Brine,
    h=Brine.specificEnthalpy(Brine.setState_pTX(port_b1_nominal.p,
        port_b1_nominal.T,port_b1_nominal.X)),
    m_flow=-port_a_nominal.m_flow) "port_b"
    annotation (Dialog(tab="Nominal Conditions"));

  /* Initialization */
  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_start(
    redeclare package Medium = Water,
    p=port_a_nominal.p,
    T=port_a_nominal.T,
    h=Water.specificEnthalpy(Water.setState_pT(port_a_start.p, port_a_start.T)),
    m_flow=port_a_nominal.m_flow) "port_a"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_start(
    redeclare package Medium = Water,
    p=port_b_nominal.p,
    T=port_b_nominal.T,
    h=Water.specificEnthalpy(Water.setState_pT(port_b_start.p, port_b_start.T)),
    m_flow=-port_a_start.m_flow) "port_b"
    annotation (Dialog(tab="Initialization"));

     parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_start(
    redeclare package Medium = Water,
    p=port_b2_nominal.p,
    T=port_b2_nominal.T,
    h=Water.specificEnthalpy(Water.setState_pT(port_b2_start.p, port_b2_start.T)),
    m_flow=-port_a_start.m_flow) "port_b"
    annotation (Dialog(tab="Initialization"));

      parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_a1_start(
    redeclare package Medium = Brine,
    p=port_a1_nominal.p,
    T=port_a1_nominal.T,
    X=port_a1_nominal.X,
    h=Brine.specificEnthalpy(Brine.setState_pTX(port_a1_start.p, port_a1_start.T,port_a1_start.X)),
    m_flow=port_a_nominal.m_flow) "port_a"
    annotation (Dialog(tab="Initialization"));

  parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_b1_start(
    redeclare package Medium = Brine,
    p=port_b1_nominal.p,
    T=port_b1_nominal.T,
    X=port_b1_nominal.X,
    h=Brine.specificEnthalpy(Brine.setState_pTX(port_b1_start.p, port_b1_start.T,port_b1_start.X)),
    m_flow=-port_a_start.m_flow) "port_b"
    annotation (Dialog(tab="Initialization"));

  /* Assumptions */
  parameter Boolean allowFlowReversal= true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  annotation (defaultComponentName="subsystem",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Record_SubSystem_A;
