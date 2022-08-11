within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Turbine_2_init


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
      //Component Pressures
  parameter Modelica.Units.SI.Pressure tee_p_start = 700000 "Tee initial pressure"
  annotation (Dialog(tab="General Parameters",group = "Pressures"));
  parameter Modelica.Units.SI.Pressure moisturesep_p_start = 20000 "Moisture Seperator inital pressure"
  annotation (Dialog(tab="General Parameters",group = "Pressures"));
  parameter Modelica.Units.SI.Pressure FeedwaterMixVolume_p_start = 650000 "Feedwater mixing initial pressure"
  annotation (Dialog(tab="General Parameters", group="Pressures"));
  parameter Modelica.Units.SI.Pressure header_p_start = 3437400 "Header mixing initial pressure"
  annotation (Dialog(tab="General Parameters", group="Pressures"));
      //Component specific enthalpies
  parameter Modelica.Units.SI.SpecificEnthalpy header_h_start = 3e6 "Header mixing initial specific enthalpy"
  annotation (Dialog(tab="General Parameters", group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy FeedwaterMixVolume_h_start = 3.5e6 "Feedwater mixing initial specific enthalpy"
  annotation (Dialog(tab="General Parameters", group="Enthalpies"));
      //Component Volumes
  parameter Modelica.Units.SI.Volume  condensor_V_liquid_start = 1.2 "Condensor initial liquid volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
      //Temperatures
  parameter Modelica.Units.SI.Temperature moisturesep_T_start = 338.15 "Moisture Seperator inital temperature"
  annotation (Dialog(tab="General Parameters",group = "Temperatures"));

  //Valves
  parameter Modelica.Units.SI.Pressure InternalBypassValve_dp_start = 1000000 "Initial pressure drop in spring valve"
  annotation (Dialog(tab="Valves", group="InternalBypassValve"));
  parameter Modelica.Units.SI.MassFlowRate InternalBypassValve_mflow_start = 0 "Initial mass flow in spring valve"
  annotation (Dialog(tab="Valves", group="InternalBypassValve"));


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
  parameter Modelica.Units.SI.SpecificEnthalpy MainFeedHeater_h_start_tube_inlet = 1e6 "Initial Tube inlet specific enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy MainFeedHeater_h_start_tube_outlet = 1.05e6 "Initial Tube outlet specific enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy MainFeedHeater_h_start_shell_inlet = 3e6 "Initial Shell inlet specific enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy MainFeedHeater_h_start_shell_outlet = 2.9e6 "Initial Shell outlet specific enthalpy of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure MainFeedHeater_dp_init_tube = 0 "Initial Tube pressure drop of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure MainFeedHeater_dp_init_shell = 100000 "Initial Shell pressure drop of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.MassFlowRate MainFeedHeater_m_start_tube = 50 "Initial tube mass flow rate in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.MassFlowRate MainFeedHeater_m_start_shell = 26 "Initial shell mass flow rate in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Power MainFeedHeater_Q_init = 1e6 "Initial Heat Flow in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
    //Bypass Feedwater Heater
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_p_start_tube = 3600000 "Initial Tube pressure of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_p_start_shell = 2400000 "Initial Shell pressure of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_tube_inlet = 2e6 "Initial Tube inlet specific enthalpy of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_tube_outlet = 3e6 "Initial Tube outlet specific enthalpy of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_shell_inlet = 3e6 "Initial Shell inlet specific enthalpy of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_shell_outlet = 2.9e6 "Initial Shell outlet specific enthalpy of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_dp_init_tube = 0 "Initial Tube pressure drop of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.Pressure BypassFeedHeater_dp_init_shell = 100000 "Initial Shell pressure drop of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.MassFlowRate BypassFeedHeater_m_start_tube = 72 "Initial tube mass flow rate in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.MassFlowRate BypassFeedHeater_m_start_shell = 10 "Initial shell mass flow rate in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.Power  BypassFeedHeater_Q_init = 1e6 "Initial Heat Flow in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));


  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"),
              Dialog(tab="System Setpoints"),
              Dialog(tab="System Setpoints"),
    defaultComponentName="init",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbineInitialisation")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));

end Turbine_2_init;
