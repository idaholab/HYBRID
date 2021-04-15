within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

  SI.Power W_Aux( displayUnit="MW")
      "Power consumption in the feedpump and multistage compression system" annotation ();
  SI.Power W_SOEC( displayUnit="MW")
    "Total power consumption in the SOEC stacks"
                                                annotation ();
  SI.Power W_Vessel( displayUnit="MW")
      "Power consumption in the HTSE vessels";
  SI.Power W_HTSE( displayUnit="MW")
    "Total power consumption in the HTSE plant"
                                               annotation ();
  SI.Power W_GT( displayUnit="MW")
      "Power consumption from the gas turbine" annotation ();

  SI.MassFlowRate m_flow_H2_prod "H2 produced during electrolysis" annotation ();
  SI.MassFlowRate m_flow_O2_prod "O2 produced during electrolysis" annotation ();

  SI.MassFlowRate m_flow_in
    "Mass flow rate of entering fluid (from the EM to the IP )"
      annotation ();
  SI.Temperature T_in( displayUnit="degC")
    "Temperature of entering fluid (from the EM to the IP)"   annotation ();
  SI.Pressure p_in "Pressure of entering fluid (from the EM to the IP)"
      annotation ();

  SI.MassFlowRate m_flow_out
    "Mass flow rate of fluid going out (from the IP to the EM)"
      annotation ();
  SI.Temperature T_out( displayUnit="degC")
    "Temperature of fluid going out (from the IP to the EM)"   annotation ();
  SI.Pressure p_out "Pressure of fluid going out (from the IP to the EM)"
      annotation ();

  SI.Temperature TNOut_anodeGas( displayUnit="degC") "Measured anode stream temperature at the anode HX outlet";
  SI.Temperature TNOut_cathodeGas( displayUnit="degC") "Measured cathode stream temperature at the cathode HX outlet";

  SI.Power Q_balance
    "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
  SI.Power W_balance
    "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
  SI.Power W_totalSetpoint( displayUnit="MW") "Total electrical power setpoint";

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
