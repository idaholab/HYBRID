within NHES.Systems.BalanceOfPlant.RankineCycle;
package Data

  model IdealTurbine

    extends BaseClasses.Record_Data;

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="IdealTurbine")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end IdealTurbine;

  model HTGR_Rankine
    parameter Modelica.Units.SI.Pressure p_steam_vent = 150e5 "Overpressurization relief valve setpoint"; //error associated with too high Temperature calling using the steam generator pipe surface temperature and the water fluid pressure is your indicator that the system is overpressurized and leaving the steam tables
    parameter Modelica.Units.SI.Temperature T_Steam_Ref = 540+273.15 "Reference steam temperature";
    parameter Modelica.Units.SI.Power Q_Nom = 36e6 "Reference electrical power";
    parameter Modelica.Units.SI.Temperature T_Feedwater = 208+273.15 "Reference feedwater temperature";

    extends BaseClasses.Record_Data;

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="Rankine")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end HTGR_Rankine;

  model TES_Setpoints
    parameter Modelica.Units.SI.Pressure p_steam = 35e5 "Reference steam pressure";
    parameter Modelica.Units.SI.Temperature T_Steam_Ref = 306.6+273.15 "Reference steam temperature";
    parameter Modelica.Units.SI.Power Q_Nom = 60e6 "Reference electrical power";
    parameter Modelica.Units.SI.Temperature T_Feedwater = 148+273.15 "Reference feedwater temperature";
    parameter Modelica.Units.SI.Pressure p_steam_vent = 150e5 "Overpressurization relief valve setpoint"; //error associated with too high Temperature calling using the steam generator pipe surface temperature and the water fluid pressure is your indicator that the system is overpressurized and leaving the steam tables
    parameter Modelica.Units.SI.Temperature T_SHS_Return = 218+273.15 "Reference SHS Return temperature";
    parameter Modelica.Units.SI.MassFlowRate m_flow_reactor = 67 "Reference mass flow rate";

    extends BaseClasses.Record_Data;

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="Rankine")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end TES_Setpoints;

  model TESTurbine

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

  end TESTurbine;

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

    annotation (Dialog(tab="Initialization", group="init_file"),
                Dialog(tab="System Setpoints"),
                Dialog(tab="System Setpoints"),
      defaultComponentName="init",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="IdealTurbineInitialisation")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end IntermediateTurbineInitialisation;

  model Turbine_2

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
    parameter Modelica.Units.SI.Pressure p_condensor = 8000 "Condensor pressure"
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

  end Turbine_2;

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
    parameter Modelica.Units.SI.Temperature moisturesep_T_start = 273.15 + 200 "Moisture Seperator inital temperature"
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

    annotation (Dialog(tab="Initialization"),
                Dialog(tab="System Setpoints"),
                Dialog(tab="System Setpoints"),
      defaultComponentName="init",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="IdealTurbineInitialisation")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));

  end Turbine_2_init;

  model Turbine_2_Setpoints

    parameter Modelica.Units.SI.Pressure p_steam = 35e5 "Reference steam pressure";
    parameter Modelica.Units.SI.Temperature T_Steam_Ref = 306.6+273.15 "Reference steam temperature";
    parameter Modelica.Units.SI.Power Q_Nom = 60e6 "Reference electrical power";
    parameter Modelica.Units.SI.Temperature T_Feedwater = 148+273.15 "Reference feedwater temperature";
    parameter Modelica.Units.SI.Pressure p_steam_vent = 150e5 "Overpressurization relief valve setpoint"; //error associated with too high Temperature calling using the steam generator pipe surface temperature and the water fluid pressure is your indicator that the system is overpressurized and leaving the steam tables

    extends BaseClasses.Record_Data;

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="Rankine")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));

  end Turbine_2_Setpoints;

  record DataInitial_HTGR_BoP_3stage

    extends TRANSFORM.Icons.Record;

    // HPT Boundary conditions
  parameter SI.Pressure HPT_P_inlet =     4.1384e6 annotation (Evaluate=true, Dialog(group="HPT_conditions"));
  parameter SI.Pressure HPT_P_outlet =    4.0723e5 annotation (Evaluate=true, Dialog(group="HPT_conditions"));
  parameter SI.Temperature HPT_T_inlet =  540.13 + 273.15 annotation (Evaluate=true, Dialog(group="HPT_conditions"));
  parameter SI.Temperature HPT_T_outlet = 253.77 + 273.15 annotation (Evaluate=true, Dialog(group="HPT_conditions"));

    // LPT1 Boundary conditions
  parameter SI.Pressure LPT1_P_inlet =     4.0562e5 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));
  parameter SI.Pressure LPT1_P_outlet =    2.0920e5 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));
  parameter SI.Temperature LPT1_T_inlet =  253.77 + 273.15 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));
  parameter SI.Temperature LPT1_T_outlet = 121.64 + 273.15 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));

    // LPT2 Boundary conditions
  parameter SI.Pressure LPT2_P_inlet =     2.0920e5 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));
  parameter SI.Pressure LPT2_P_outlet =    0.0080e5 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));
  parameter SI.Temperature LPT2_T_inlet =  121.64 + 273.15 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));
  parameter SI.Temperature LPT2_T_outlet =  41.52 + 273.15 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));

    // Circulation Pump Boundary conditions
    parameter SI.Pressure cirPump_P_nomi =     5.5e6 annotation (Evaluate=true, Dialog(group="CirculationPump_conditions"));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                  Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="BOP_3stage")}),                            Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DataInitial_HTGR_BoP_3stage;

  record DataInitial_HTGR_Pebble

    extends TRANSFORM.Icons.Record;

  parameter SI.Pressure P_Turbine_Ref = 19.9e5 annotation(dialog(tab = "Physical Components"));
  parameter SI.Temperature TStart_In_Turbine = 850+273.15 annotation(dialog(tab = "Physical Components"));
  parameter SI.Temperature TStart_Out_Turbine = 478+273.15 annotation(dialog(tab = "Physical Components"));

  parameter SI.Pressure P_LP_Comp_Ref = 19.3e5 annotation(dialog(tab = "Physical Components"));
  parameter SI.Temperature TStart_LP_Comp_In = 33+273.15 annotation(dialog(tab = "Physical Components"));
  parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15 annotation(dialog(tab = "Physical Components"));

  parameter SI.Pressure P_HP_Comp_Ref = 19.9e5 annotation(dialog(tab = "Physical Components"));
  parameter SI.Temperature TStart_HP_Comp_In = 850+273.15 annotation(dialog(tab = "Physical Components"));
  parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15 annotation(dialog(tab = "Physical Components"));

  parameter SI.Power HX_Aux_Q_Init = -1e6 annotation(dialog(tab = "HX_Aux"));
  parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3 annotation(dialog(tab = "HX_Aux"));
  parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3 annotation(dialog(tab = "HX_Aux"));
  parameter SI.Pressure HX_Aux_p_tube = 1e5 annotation(dialog(tab = "HX_Aux"));

    parameter SI.Pressure P_Core_Inlet = 60e5 annotation(dialog(tab = "Core"));
    parameter SI.Pressure P_Core_Outlet = 59.4e5 annotation(dialog(tab = "Core"));
  parameter SI.Temperature T_Core_Inlet = 623.15 annotation(dialog(tab = "Core"));
  parameter SI.Temperature T_Core_Outlet = 1023.15 annotation(dialog(tab = "Core"));
  parameter SI.Temperature T_Pebble_Init = T_Core_Outlet annotation(dialog(tab = "Core"));
  parameter SI.Temperature T_Fuel_Center_Init = 1473.15 annotation(dialog(tab = "Core"));

  parameter SI.Pressure Recuperator_P_Tube = 19.4e5 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.Pressure Recuperator_dp_Tube = 0.3e5 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.MassFlowRate Recuperator_m_Tube = 296.1 annotation(dialog(tab = "Recuperator HX"));

  parameter SI.Pressure Recuperator_P_Shell = 60.4e5 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.Pressure Recuperator_dp_Shell = 0.4e5 annotation(dialog(tab = "Recuperator HX"));
  parameter SI.MassFlowRate Recuperator_m_Shell = 296.1 annotation(dialog(tab = "Recuperator HX"));

  parameter SI.Pressure P_Intercooler = 59.2e5;
  parameter SI.Pressure P_Precooler = 30e5;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                  Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="Pebble Bed")}),                            Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DataInitial_HTGR_Pebble;
end Data;
