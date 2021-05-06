within NHES.Systems.IndustrialProcess.HeaderTurbineCombo.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;

  extends Record_SubSystem_A;

   import Modelica.Constants;

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
         Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
     "Fluid connector a (positive design flow direction is from port_a to port_b)"
     annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
         iconTransformation(extent={{-110,30},{-90,50}})));

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b(redeclare package Medium =
         Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
     "Fluid connector b (positive design flow direction is from port_a to port_b)"
     annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
         iconTransformation(extent={{-110,-52},{-90,-32}})));

  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_State portElec
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  annotation (
    defaultComponentName="IP",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
