within NHES.Systems.BalanceOfPlant.Turbine.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
  SI.Power W_total "Total electrical power generated";
  SI.Power W_totalSetpoint "Total electrical power setpoint";
  SI.Pressure p_inlet_steamTurbine "Inlet pressure to steam turbine";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
