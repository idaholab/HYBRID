within NHES.Systems.IndustrialProcess.HeaderTurbineCombo.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  SI.MassFlowRate m_flow_HP_toProcess "Mass flow rate to process";
  SI.MassFlowRate m_flow_IP_toProcess "Mass flow rate to process";
  SI.MassFlowRate m_flow_LP_toProcess "Mass flow rate to process";

  annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
