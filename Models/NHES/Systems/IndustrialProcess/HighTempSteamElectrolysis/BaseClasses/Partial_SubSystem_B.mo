within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses;
partial model Partial_SubSystem_B

  import Modelica.Constants;

  extends Partial_SubSystem;
  extends Record_SubSystem_B;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a_1 to port_b_1)"
    annotation (Placement(transformation(extent={{-210,10},{-190,30}}),
        iconTransformation(extent={{-110,30},{-90,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a_1 to port_b_1)"
    annotation (Placement(transformation(extent={{-210,-150},{-190,-130}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));

  Electrical.Interfaces.ElectricalPowerPort_a portElec_a annotation (Placement(
        transformation(extent={{190,-70},{210,-50}}),iconTransformation(extent={
            {90,-10},{110,10}})));

  annotation (defaultComponentName="IP",
  Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false)),
    Diagram(coordinateSystem(extent={{-160,-100},{160,140}},
          preserveAspectRatio=false)));
end Partial_SubSystem_B;
