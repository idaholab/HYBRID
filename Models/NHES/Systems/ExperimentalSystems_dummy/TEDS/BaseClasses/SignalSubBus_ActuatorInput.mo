within NHES.Systems.ExperimentalSystems_dummy.TEDS.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

Real Demand;
  annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
