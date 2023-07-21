within NHES.Desalination.MEE.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

   Real CV1_opening;
   Real CV2_opening;
   Real CV3_opening;
   Real CV4_opening;
   Real CV5_opening;
   Real CV6_opening;
   Real CV7_opening;
   Real CV8_opening;
   Real ECV_opening;
   Real MCV_opening;
   Real TCVCV_opening;

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
