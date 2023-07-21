within NHES.Desalination.MEE.BaseClasses;
partial model Partial_SubSystem_A3

  import Modelica.Constants;

  extends Partial_SubSystem3;
  //extends Record_SubSystem_A;
    replaceable package Water = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
    annotation (choicesAllMatching=true);
  replaceable package Brine = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX) constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
    annotation (choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a Steam_Input(redeclare package
      Medium =
        Water, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Input Steam for the first effect" annotation (Placement(transformation(
          extent={{-568,30},{-548,50}}), iconTransformation(extent={{-90,50},
            {-110,30}})));

  Modelica.Fluid.Interfaces.FluidPort_b Water_Outlet(redeclare package
      Medium =
        Water, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Output of condensed steam used in the first effect" annotation (Placement(
        transformation(extent={{-568,-50},{-548,-30}}), iconTransformation(
          extent={{-90,-30},{-110,-50}})));

  Modelica.Fluid.Interfaces.FluidPort_b Condensate_Oulet(redeclare package
      Medium = Water, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Outlet of desalinated water" annotation (Placement(transformation(extent={{
            -568,-150},{-548,-130}}), iconTransformation(extent={{-10,-108},{10,
            -88}})));

  Modelica.Fluid.Interfaces.FluidPort_a Saltwater_Input(redeclare package
      Medium = Brine, m_flow(min=if allowFlowReversal then -
          Constants.inf else 0)) "Source of saltwater" annotation (Placement(
        transformation(extent={{550,30},{570,50}}), iconTransformation(extent={{90,30},
            {110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Saltwater_Reject_Oulet(redeclare
      package Medium = Brine, m_flow(max=if
          allowFlowReversal then +Constants.inf else 0))
    "Oulet for rejected Saltwater" annotation (Placement(transformation(extent={
            {550,-50},{570,-30}}), iconTransformation(extent={{90,-50},{110,
            -30}})));

  parameter Boolean allowFlowReversal= true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  annotation (
    defaultComponentName="MEE",
    Icon(coordinateSystem(                           extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-560,-140},{560,
            180}})));

end Partial_SubSystem_A3;
