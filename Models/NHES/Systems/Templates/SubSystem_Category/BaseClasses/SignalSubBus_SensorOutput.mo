within NHES.Systems.Templates.SubSystem_Category.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  NHES.Systems.Templates.SubSystem_Category.SubSystem_Specific.BaseClasses.SignalSubBus_SensorOutput
    subSystem_Specific;

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
