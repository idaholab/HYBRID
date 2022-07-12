within NHES.Systems.BalanceOfPlant.Turbine.Data;
model IntermediateTurbineInitialisation

  extends BaseClasses.Record_Data;

  //Controlled Setpoints
  parameter Modelica.Units.SI.Pressure p_steam_vent = 150e5 "Overpressurization relief valve setpoint"
  annotation (Dialog(tab="System Setpoints"));
  parameter Modelica.Units.SI.Temperature T_Steam_Ref = 306.6+273.15 "Reference steam temperature"
  annotation (Dialog(tab="System Setpoints"));
  parameter Modelica.Units.SI.Power Q_Nom = 60e6 "Reference electrical power"
  annotation (Dialog(tab="System Setpoints"));
  parameter Modelica.Units.SI.Temperature T_Feedwater = 148+273.15 "Reference feedwater temperature"
  annotation (Dialog(tab="System Setpoints"));
  parameter Modelica.Units.SI.Pressure p_steam = 35e5 "Reference steam pressure"
  annotation (Dialog(tab="System Setpoints"));

  //BOP General Parameters
      //Systems
  parameter Modelica.Units.SI.Pressure p_in_nominal = 3447380 "Nominal input pressure"
  annotation (Dialog(tab="General Parameters", group="System"));
      //Component Pressures
  parameter Modelica.Units.SI.Pressure tee_p_start = 700000 "Tee initial pressure"
  annotation (Dialog(tab="General Parameters",group = "Pressures"));
  parameter Modelica.Units.SI.Pressure moisturesep_p_start = 20000 "Moisture Seperator inital pressure"
  annotation (Dialog(tab="General Parameters",group = "Pressures"));
      //Component Volumes
  parameter Modelica.Units.SI.Volume  condensor_V_liquid_start = 1.2 "Condensor initial liquid volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
      //Temperatures
  parameter Modelica.Units.SI.Temperature moisturesep_T_start = 338.15 "Moisture Seperator inital temperature"
  annotation (Dialog(tab="General Parameters",group = "Temperatures"));



  //Valve Parameters
  parameter Modelica.Units.SI.MassFlowRate valve_BV_mflow = 10 "Bypass valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Bypass Valve"));
  parameter Modelica.Units.SI.MassFlowRate valve_TCV_mflow = 300 "Turbine Control valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
  parameter Modelica.Units.SI.Pressure valve_TCV_dp_nominal = 1000000 "Nominal pressure drop for turbine control"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));

  //Turbine Parameters
  parameter Modelica.Units.SI.Pressure HPT_p_a_start = 3400000 "Initial HPT inlet pressure"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));
  parameter Modelica.Units.SI.Pressure HPT_p_b_start = 700000 "Initial HPT outlet pressure"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));
  parameter Modelica.Units.SI.Temperature HPT_T_a_start = 579.15 "Initial HPT inlet temperature"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));
  parameter Modelica.Units.SI.Temperature HPT_T_b_start = 473.15 "Initial HPT outlet temperature"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));


  parameter Modelica.Units.SI.Pressure LPT_p_a_start = 700000 "Initial LPT inlet pressure"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Modelica.Units.SI.Pressure LPT_p_b_start = 8000 "Initial LPT outlet pressure"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Modelica.Units.SI.Temperature LPT_T_a_start = 473.15 "Initial LPT inlet temperature"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Modelica.Units.SI.Temperature LPT_T_b_start = 373.15 "Initial LPT outlet temperature"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));

  //Heat Exchangers
    //Main Feedwater Heater
  parameter Modelica.Units.SI.Pressure MainFeedHeater_p_start_tube = 1000000 "Initial Tube pressure of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure MainFeedHeater_p_start_shell = 600000 "Initial Shell pressure of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Enthalpy MainFeedHeater_h_start_tube_inlet = 1e6 "Initial Tube inlet enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Enthalpy MainFeedHeater_h_start_tube_outlet = 1.05e6 "Initial Tube outlet enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Enthalpy MainFeedHeater_h_start_shell_inlet = 3e6 "Initial Shell inlet enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Enthalpy MainFeedHeater_h_start_shell_outlet = 2.9e6 "Initial Shell outlet enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure MainFeedHeater_dp_init_tube = 0 "Initial Tube pressure drop of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure MainFeedHeater_dp_init_shell = 100000 "Initial Shell pressure drop of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));


  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"),
              Dialog(tab="System Setpoints"),
              Dialog(tab="System Setpoints"),
    defaultComponentName="init",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbineInitialisation")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end IntermediateTurbineInitialisation;
