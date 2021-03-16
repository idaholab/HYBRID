within NHES.Systems.EnergyManifold.SteamManifold.BaseClasses;
partial model Partial_SubSystem_A

  import Modelica.Constants;

  extends Partial_SubSystem;
  extends Record_SubSystem_A;

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium_1, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a_1 to port_b_1)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
        iconTransformation(extent={{-110,30},{-90,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium_1, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a_1 to port_b_1)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium_2, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a_2 to port_b_2)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-50},{110,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium_2, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a_2 to port_b_2)"
    annotation (Placement(transformation(extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,30},{110,50}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        Medium_3, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a_3 to port_b_3)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}}),
        iconTransformation(extent={{-50,-110},{-30,-90}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        Medium_3, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a_3 to port_b_3)"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));

  annotation (
    defaultComponentName="EM",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
