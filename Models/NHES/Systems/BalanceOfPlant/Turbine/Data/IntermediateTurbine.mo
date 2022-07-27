within NHES.Systems.BalanceOfPlant.Turbine.Data;
model IntermediateTurbine

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
  parameter Modelica.Units.SI.Pressure p_condensor = 10000 "Condensor pressure"
  annotation (Dialog(tab="General Parameters",group = "Pressures"));
  parameter Modelica.Units.SI.Pressure p_boundary = 100000 "Boundary pressure for venting"
  annotation (Dialog(tab="General Parameters", group= "Pressures"));
      //Component Volumes
  parameter Modelica.Units.SI.Volume  V_condensor = 150 "Condensor volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
  parameter Modelica.Units.SI.Volume  V_tee = 5 "Tee volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
  parameter Modelica.Units.SI.Volume  V_moistureseperator = 0.01 "Moisture Seperator volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
  parameter Modelica.Units.SI.Volume  V_FeedwaterMixVolume = 80 "Feedwater Mixing volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
  parameter Modelica.Units.SI.Volume  V_Header = 1 "Header Mixing volume"
  annotation (Dialog(tab="General Parameters", group = "Volumes"));
        //Moment of Inertia
  parameter Modelica.Units.SI.MomentOfInertia generator_MoI = 1e4 "Generator Moment of inertia"
  annotation (Dialog(tab="General Parameters",group = "Generator"));
        //Component Temperatures
  parameter Modelica.Units.SI.Temperature T_boundary = 573.15 "Boundary Temperature for venting"
  annotation (Dialog(tab="General Parameters", group= "Temperatures"));

      //Resistances
  parameter TRANSFORM.Units.HydraulicResistance  R_bypass = 1000 "Hydraulic Resistance of internal bypass stream"
  annotation (Dialog(tab="General Parameters", group = "Resistances"));
  parameter TRANSFORM.Units.HydraulicResistance  R_entry = 1 "Hydraulic Resistance of steam entry stream"
  annotation (Dialog(tab="General Parameters", group = "Resistances"));
  parameter TRANSFORM.Units.HydraulicResistance  R_feedwater = 1 "Hydraulic Resistance of LPT feedwater stream"
  annotation (Dialog(tab="General Parameters", group = "Resistances"));


  //Valve Parameters
  parameter Modelica.Units.SI.MassFlowRate valve_TCV_mflow = 300 "Turbine Control valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
  parameter Modelica.Units.SI.Pressure valve_TCV_dp_nominal = 1000000 "Nominal pressure drop for turbine control"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
   parameter Modelica.Units.SI.MassFlowRate valve_SHS_mflow = 60 "Turbine Control valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
  parameter Modelica.Units.SI.Pressure valve_SHS_dp_nominal = 450000 "Nominal pressure drop for turbine control"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
  parameter Modelica.Units.SI.MassFlowRate valve_TCV_LPT_mflow = 300 "Turbine Control valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
  parameter Modelica.Units.SI.Pressure valve_TCV_LPT_dp_nominal = 100000 "Nominal pressure drop for turbine control"
  annotation (Dialog(tab="Valves", group="Turbine Control Valve"));
  parameter Modelica.Units.SI.MassFlowRate valve_LPT_Bypass_mflow = 5 "LPT Bypass valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="LPT Bypass Valve"));
  parameter Modelica.Units.SI.Pressure valve_LPT_Bypass_dp_nominal = 10000 "Nominal pressure drop for LPT Bypass Valve"
  annotation (Dialog(tab="Valves", group="LPT Bypass Valve"));
  parameter Modelica.Units.SI.MassFlowRate valve_TBV_mflow = 50 "Turbine External Bypass valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Turbine External Bypass Valve"));
  parameter Modelica.Units.SI.Pressure valve_TBV_dp_nominal = 100000 "Nominal pressure drop for turbine external bypass"
  annotation (Dialog(tab="Valves", group="Turbine External Bypass Valve"));
  parameter Modelica.Units.SI.MassFlowRate InternalBypassValve_mflow_small = 1e-2 "Internal Bypass valve nominal mass flow"
  annotation (Dialog(tab="Valves", group="Internal Bypass Valve"));
  parameter Modelica.Units.SI.Pressure InternalBypassValve_p_spring = 5500000 "Internal Bypass valve spring pressure"
  annotation (Dialog(tab="Valves", group="Internal Bypass Valve"));
  parameter Real InternalBypassValve_K( unit="1/(m.kg)") = 60 "Internal Bypass valve K nominal"
  annotation (Dialog(tab="Valves", group="Internal Bypass Valve"));
  parameter Real InternalBypassValve_tau(unit="1/s") = 0.0001 "Internal Bypass valve time constant"
  annotation (Dialog(tab="Valves", group="Internal Bypass Valve"));



  //Turbine Parameters
  parameter Modelica.Units.SI.Pressure HPT_p_exit_nominal = 700000 "Nominal HPT outlet pressure"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));
  parameter Modelica.Units.SI.Temperature HPT_T_in_nominal = 563.15 "Nominal HPT inlet temperature"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));
  parameter Modelica.Units.SI.MassFlowRate HPT_nominal_mflow = 70 "HPT nominal mass flow"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));
  parameter Real HPT_efficiency = 0.93 "HPT mechanical efficiency"
  annotation (Dialog(tab="Turbines", group="High Pressure Turbine"));

  parameter Modelica.Units.SI.Pressure LPT_p_in_nominal = 700000 "Nominal LPT inlet pressure"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Modelica.Units.SI.Pressure LPT_p_exit_nominal = 8000 "Nominal LPT outlet pressure"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Modelica.Units.SI.Temperature LPT_T_in_nominal = 523.15 "Nominal LPT inlet temperature"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Modelica.Units.SI.MassFlowRate LPT_nominal_mflow = 70 "LPT nominal mass flow"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));
  parameter Real LPT_efficiency = 0.93 "LPT mechanical efficiency"
  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"));

  //Pump Parameters
  parameter Modelica.Units.SI.Pressure firstfeedpump_p_nominal = 1000000 "Pressure rise in first feedwater pump"
  annotation (Dialog(tab="Pumps", group="First Feedwater Pump"));
  parameter Modelica.Units.SI.Pressure secondfeedpump_p_nominal = 3600000 "Pressure rise in second feedwater pump"
  annotation (Dialog(tab="Pumps", group="Second Feedwater Pump"));
  parameter Modelica.Units.SI.MassFlowRate controlledfeedpump_mflow_nominal = 80 "Nominal mass flow in controlled feedwater pump"
  annotation (Dialog(tab="Pumps", group="Controlled Feedwater Pump"));

  //Heat Exchangers
    //Main Feedwater Heater
  parameter Real MainFeedHeater_NTU = 20 "NTU of main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Real MainFeedHeater_K_tube(unit = "1/m4") = 17000 "K value of tube in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Real MainFeedHeater_K_shell(unit = "1/m4") = 500 "K value of shell in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Volume  MainFeedHeater_V_tube = 5 "Tube side volume in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));
  parameter Modelica.Units.SI.Volume  MainFeedHeater_V_shell = 5 "Shell side volume in main feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Main Feedwater Heater"));

    //Bypass Feedwater Heater
  parameter Real BypassFeedHeater_NTU = 20 "NTU of bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Real BypassFeedHeater_K_tube(unit = "1/m4") = 17000 "K value of tube in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Real BypassFeedHeater_K_shell(unit = "1/m4") = 500 "K value of shell in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.Volume  BypassFeedHeater_V_tube = 5 "Tube side volume in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));
  parameter Modelica.Units.SI.Volume  BypassFeedHeater_V_shell = 5 "Shell side volume in bypass feedwater heater"
  annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater"));



  annotation (Dialog(tab="Turbines", group="Low Pressure Turbine"),
              Dialog(tab="System Setpoints"),
              Dialog(tab="System Setpoints"),
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbine")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));


end IntermediateTurbine;
