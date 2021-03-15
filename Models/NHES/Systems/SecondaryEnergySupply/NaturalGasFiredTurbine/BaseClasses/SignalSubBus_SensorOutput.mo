within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power W_load(displayUnit="MW") "Electrical load to the GT plant" annotation ();
  SI.Power W_gen(displayUnit="MW") "Generated electricity from the GT plant" annotation ();
  SI.MassFlowRate m_flow_fuel "Fuel (natural gas) consumption in the GT plant" annotation ();
  SI.MassFlowRate m_flow_CO2 "CO2 emission rate from the GT plant" annotation ();

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
  SI.Power W_totalSetpoint(displayUnit="MW") "Total electrical power setpoint";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
