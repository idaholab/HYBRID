within NHES.Systems.EnergyManifold.SteamManifold.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  Real opening_TDV "TDV fraction open";
  Real opening_IPDV "IPDV fraction open";
  Real opening_BPDV "BPDV fraction open";
  Real opening_valve_toBOP "valve_toBOP fraction open";
  Real opening_valve_toOther[:] "valve_toOther fraction open";

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
