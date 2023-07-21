within NHES.Desalination.MEE.BaseClasses;
expandable connector SignalSubBus_ActuatorInput3

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

   Real CV1_opening;
   Real CV2_opening;
   Real CV3_opening;

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput3;
