within NHES.Systems.EnergyManifold.SteamManifold.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";

  SI.SpecificEnthalpy h_toIP "Specific enthalpy to IP";
  SI.Pressure p_toIP "Pressure to IP";
  SI.MassFlowRate m_flow_toIP "Mass flow rate to IP";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
