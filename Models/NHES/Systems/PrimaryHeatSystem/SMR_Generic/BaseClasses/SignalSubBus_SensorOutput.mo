within NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
  SI.MassFlowRate m_flow_fuelConsumption
    "Approximate nuclear fuel consumption rate";

  SI.Power Q_total "Total thermal Output of Reactor";
  SI.Temperature T_Core_Inlet "Core inlet temperature";
  SI.Temperature T_Core_Outlet "Core outlet temperature";
  SI.Pressure p_pressurizer "Pressurizer pressure";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
