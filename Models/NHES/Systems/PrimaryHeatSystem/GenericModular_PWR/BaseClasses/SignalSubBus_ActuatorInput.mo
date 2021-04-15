within NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  Real reactivity_CR;
  SI.MassFlowRate m_flow_steam;

  annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
