within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  Real TNOut_anodeGas(unit="1") "Controller output to regulate the TNOut_anodeGas";
  Real TNOut_cathodeGas(unit="1") "Controller output to regulate the TNOut_cathodeGas";
  SI.Power W_IP( displayUnit="MW") "Controller output to regulate the power consumption in the IP module";

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
