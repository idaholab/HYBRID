within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.BaseClasses;
expandable connector SignalSubBus_ActuatorInput

  extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

  Real m_flow_fuel_pu(unit="1") "Controller output: Fuel flow signal to regulate the power generation from the GTPP";

   annotation (defaultComponentName="actuatorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_ActuatorInput;
