within NHES.Systems.Templates.SubSystem_Category.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  NHES.Systems.Templates.SubSystem_Category.SubSystem_Specific.BaseClasses.SignalSubBus_ActuatorInput
    subSystem_Specific;

  annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
