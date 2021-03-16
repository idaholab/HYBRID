within NHES.Systems.BalanceOfPlant.Turbine.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  Real opening_TCV "TCV fraction open";
  Real opening_TDV "TDV fraction open";
  Real opening_BV "BV fraction open";
  Real opening_BV_TCV "BV for TCV fraction open";

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
