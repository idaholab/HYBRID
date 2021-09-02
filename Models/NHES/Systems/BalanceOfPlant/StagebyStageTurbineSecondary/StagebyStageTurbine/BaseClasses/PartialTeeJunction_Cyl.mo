within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
partial model PartialTeeJunction_Cyl
  "Base class for a splitting/joining component with three ports"
  import Modelica.Fluid.Types;
  import Modelica.Fluid.Types.PortFlowDirection;

  replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
    annotation (choicesAllMatching=true);

  FluidFlow port_1(redeclare package Medium = Medium, m_flow(min=if (
          portFlowDirection_1 == PortFlowDirection.Entering) then 0.0 else -
          Modelica.Constants.inf, max=if (portFlowDirection_1 ==
          PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluidFlow port_2(redeclare package Medium = Medium, m_flow(min=if (
          portFlowDirection_2 == PortFlowDirection.Entering) then 0.0 else -
          Modelica.Constants.inf, max=if (portFlowDirection_2 ==
          PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  FluidFlow port_3(redeclare package Medium = Medium, m_flow(min=if (
          portFlowDirection_3 == PortFlowDirection.Entering) then 0.0 else -
          Modelica.Constants.inf, max=if (portFlowDirection_3 ==
          PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

protected
  parameter PortFlowDirection portFlowDirection_1=PortFlowDirection.Bidirectional
    "Flow direction for port_1"
   annotation(Dialog(tab="Advanced"));
  parameter PortFlowDirection portFlowDirection_2=PortFlowDirection.Bidirectional
    "Flow direction for port_2"
   annotation(Dialog(tab="Advanced"));
  parameter PortFlowDirection portFlowDirection_3=PortFlowDirection.Bidirectional
    "Flow direction for port_3"
   annotation(Dialog(tab="Advanced"));

  annotation(Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,44},{100,-44}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Text(
          extent={{-150,-89},{150,-129}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-44,100},{44,44}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-22,82},{21,-4}},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255},
          pattern=LinePattern.None)}));
end PartialTeeJunction_Cyl;
