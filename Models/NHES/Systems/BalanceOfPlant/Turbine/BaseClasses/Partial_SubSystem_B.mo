within NHES.Systems.BalanceOfPlant.Turbine.BaseClasses;
partial model Partial_SubSystem_B

  import Modelica.Constants;

  extends Partial_SubSystem;
  extends Record_SubSystem_B;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,30},{-150,50}}),
        iconTransformation(extent={{-110,30},{-90,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,-50},{-150,-30}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a3[nPorts_a3](redeclare package Medium =
        Medium, m_flow(each min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a_3 to port_b_3)"
    annotation (Placement(transformation(extent={{-90,-170},{-70,-150}}),
        iconTransformation(extent={{-50,-110},{-30,-90}})));

  NHES.Electrical.Interfaces.ElectricalPowerPort_b portElec_b
    annotation (Placement(transformation(extent={{150,-10},{170,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));

  annotation (
    defaultComponentName="BOP",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            140}})));

end Partial_SubSystem_B;
