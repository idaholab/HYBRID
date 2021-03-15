within NHES.Systems.SwitchYard.SimpleYard.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  Boolean closed_BOP "Breaker control for BOP";
  Boolean closed_ES "Breaker control for ES";
  Boolean closed_SES "Breaker control for SES";
  Boolean closed_EG "Breaker control for EG";

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
