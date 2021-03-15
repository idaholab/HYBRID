within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  SI.Voltage Voltage_IP( displayUnit="V") "Controller output: Voltage signal to regulate the power consumption in the IP module";

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
