within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power W_RO_per_pump( displayUnit="MW")
    "Power consumption for the RO per pump"
                                           annotation ();
  SI.Power W_Desal( displayUnit="MW")
    "Total power consumption in the RO desalination plant"
                                                          annotation ();
  SI.MassFlowRate m_flow_permeate "Water produced via the RO desalination" annotation ();
  NHES.Desalination.Types.Salinity Sp_avg "Salinity of the permeate";

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
  SI.Power W_totalSetpoint( displayUnit="MW") "Total electrical power setpoint";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
