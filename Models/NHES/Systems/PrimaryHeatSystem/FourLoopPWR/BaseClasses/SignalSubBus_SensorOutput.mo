within NHES.Systems.PrimaryHeatSystem.FourLoopPWR.BaseClasses;
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
  SI.MassFlowRate m_flow_boilerDrum "Steam flow rate from boiler drum";
  SI.MassFlowRate m_flow_feedWater "Feedwater mass flow rate";
  SI.Length level_drum "Boiler drum liquid level";

  annotation (defaultComponentName="sensorBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
