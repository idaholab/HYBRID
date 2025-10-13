within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data;
model Data_SHS

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Length ht_level_max = 15 annotation(Dialog(group = "Hot Tank"));
  parameter Modelica.Units.SI.Area ht_area = 50 annotation(Dialog(group = "Hot Tank"));
  parameter Modelica.Units.SI.Volume ht_zero_level_volume = 1 annotation(Dialog(group = "Hot Tank"));
  parameter Modelica.Units.SI.Pressure ht_surface_pressure = 101325 annotation(Dialog(group = "Hot Tank"));
  parameter Modelica.Units.SI.Length ht_init_level = ht_level_max*0.5 annotation(Dialog(tab = "Initialization", group = "Hot Tank"));
  parameter Modelica.Units.SI.Temperature hot_tank_init_temp = 273.15+240 annotation(Dialog(tab = "Initialization", group = "Hot Tank"));
  parameter Modelica.Units.SI.Length cold_tank_level_max = 15 annotation(Dialog(group = "Cold Tank"));
  parameter Modelica.Units.SI.Area cold_tank_area = 50 annotation(Dialog(group = "Cold Tank"));
  parameter Modelica.Units.SI.Volume ct_zero_level_volume = 1 annotation(Dialog(group = "Cold Tank"));
  parameter Modelica.Units.SI.Pressure ct_surface_pressure = 101325 annotation(Dialog(group = "Cold Tank"));
  parameter Modelica.Units.SI.Length cold_tank_init_level = ht_level_max*0.5 annotation(Dialog(tab = "Initialization", group = "Cold Tank"));
  parameter Modelica.Units.SI.Temperature cold_tank_init_temp = 273.15+240 annotation(Dialog(tab = "Initialization", group = "Cold Tank"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_ch_min = 2.0;
  parameter Integer CHXnV = 5 "Number of nodes in CHX" annotation(Dialog(tab = "Heat Exchangers", group = "CHX"));

  parameter Real CHX_NTU = 4.0 "DHX NTU value" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Boolean CHX_Use_derQ = true annotation (Evaluate = true,
                Dialog(enable = use_derQ, tab = "Heat Exchangers", group = "DHX"));
  parameter Modelica.Units.SI.Time CHX_tau = 1.0 annotation(Dialog(tab="Heat Exchangers", group = "DHX"));
  parameter Real CHX_K_tube(unit = "1/m4") = 100 "Pressure drop coefficient" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Real CHX_K_shell(unit = "1/m4") = 100 "Pressure drop coefficient" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Modelica.Units.SI.Volume CHX_v_tube = 10 "Tube side (SHS side) volume" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Modelica.Units.SI.Volume CHX_v_shell = 10 "Shell side volume" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));

  parameter Real DHX_NTU = 4.0 "DHX NTU value" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Boolean DHX_Use_derQ = true annotation (Evaluate = true,
                Dialog(enable = use_derQ, tab = "Heat Exchangers", group = "DHX"));
  parameter Modelica.Units.SI.Time DHX_tau = 1.0 annotation(Dialog(tab="Heat Exchangers", group = "DHX"));
  parameter Real DHX_K_tube(unit = "1/m4") = 100 "Pressure drop coefficient" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Real DHX_K_shell(unit = "1/m4") = 100 "Pressure drop coefficient" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Modelica.Units.SI.Volume DHX_v_tube = 10 "Tube side (SHS side) volume" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
  parameter Modelica.Units.SI.Volume DHX_v_shell = 10 "Shell side volume" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));

  parameter Modelica.Units.SI.Pressure DHX_p_start_tube = 100000 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Pressure DHX_dp_init_tube = 1000 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Boolean DHX_use_T_start_tube = false annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Temperature DHX_T_start_tube_inlet = 300e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Temperature DHX_T_start_tube_outlet = 100e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_tube_inlet = 300e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_tube_outlet = 100e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
    parameter Boolean DHX_use_T_start_shell = false annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Pressure DHX_p_start_shell = 5e5 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Pressure DHX_dp_init_shell = 1000 annotation(Dialog(tab = "Initialization", group = "DHX"));
    parameter Modelica.Units.SI.Temperature DHX_T_start_shell_inlet = 350 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Temperature DHX_T_start_shell_outlet = 450 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_shell_inlet = 1400e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_shell_outlet = 2000e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.MassFlowRate DHX_m_flow_start_tube = 50 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.MassFlowRate DHX_m_flow_start_shell = 50 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Modelica.Units.SI.Power DHX_Q_init = 1 "Do not set to 0" annotation(Dialog(tab = "Initialization", group = "DHX"));
    parameter Modelica.Units.SI.Pressure DHX_dp_general=10 annotation(Dialog(tab = "Initialization", group = "DHX"));
  parameter Real DHX_Cr_init = 0.0 annotation(Dialog(tab = "Initialization", group = "DHX"));



  parameter Modelica.Units.SI.Pressure CHX_p_start_tube = 100000 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Pressure CHX_dp_init_tube = 1000 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Boolean CHX_use_T_start_tube = false annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Temperature CHX_T_start_tube_inlet = 573.15 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Temperature CHX_T_start_tube_outlet = 573.15 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy CHX_h_start_tube_inlet = 300e3 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy CHX_h_start_tube_outlet = 100e3 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Pressure CHX_p_start_shell = 5e5 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Pressure CHX_dp_init_shell = 1000 annotation(Dialog(tab = "Initialization", group = "CHX"));
    parameter Boolean CHX_use_T_start_shell = false annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Temperature CHX_T_start_shell_inlet = 573.15 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Temperature CHX_T_start_shell_outlet = 573.15 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy CHX_h_start_shell_inlet = 1400e3 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.SpecificEnthalpy CHX_h_start_shell_outlet = 2000e3 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.MassFlowRate CHX_m_flow_start_tube = 50 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.MassFlowRate CHX_m_flow_start_shell = 50 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Modelica.Units.SI.Power CHX_Q_init = 1 "Do not set to 0" annotation(Dialog(tab = "Initialization", group = "CHX"));

  parameter Modelica.Units.SI.Pressure CHX_dp_general= 10 annotation(Dialog(tab = "Initialization", group = "CHX"));
  parameter Real CHX_Cr_init = 0.0 annotation(Dialog(tab = "Initialization", group = "CHX"));



  parameter Modelica.Units.SI.Volume discharge_pump_volume = 1 annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.Length discharge_pump_diameter = 0.5  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm discharge_pump_rpm_nominal = 1500  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.Length discharge_pump_diameter_nominal = 0.5  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.Pressure discharge_pump_dp_nominal = 2e5  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.MassFlowRate discharge_pump_m_flow_nominal = 10  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.Density discharge_pump_rho_nominal = 1  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm discharge_pump_constantRPM = 1500  annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.VolumeFlowRate dis_pump_V_flow_nom[3] = {0,1,2} annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.Height dis_pump_head_curve[3] = {0,8,20} annotation(Dialog(tab = "Pumps", group = "Discharge"));

  parameter Modelica.Units.SI.Volume charge_pump_volume = 1 annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.SI.Length charge_pump_diamter = 0.5  annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm charge_pump_rpm_nominal = 1500  annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.SI.Length charge_pump_diameter_nominal = 0.5  annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.SI.Pressure charge_pump_dp_nominal = 7e5  annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.SI.MassFlowRate charge_pump_m_flow_nominal = 20  annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.SI.Density charge_pump_rho_nominal = 1  annotation(Dialog(tab = "Pumps", group = "Charge"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm charge_pump_constantRPM = 2000  annotation(Dialog(tab = "Pumps", group = "Charge"));
    parameter Modelica.Units.SI.VolumeFlowRate charge_pump_V_flow_nom[3] = {0,1,2} annotation(Dialog(tab = "Pumps", group = "Discharge"));
  parameter Modelica.Units.SI.Height charge_pump_head_curve[3] = {0,8,20} annotation(Dialog(tab = "Pumps", group = "Discharge"));

  parameter Modelica.Units.SI.Area ctdp_area = 1 annotation(Dialog(tab = "Piping", group = "Discharge"));
  parameter Modelica.Units.SI.Length ctdp_length = 10 annotation(Dialog(tab = "Piping", group = "Discharge"));
  parameter Modelica.Units.SI.Length ctdp_d_height = 0.0 annotation(Dialog(tab = "Piping", group = "Discharge"));
  parameter Modelica.Units.SI.Volume ctvolume_volume = 1.0 annotation(Dialog(tab = "Piping", group = "Disharge"));
  parameter Modelica.Units.SI.MassFlowRate disvalve_m_flow_nom = 25 annotation(Dialog(tab = "Piping", group = "Discharge"));
  parameter Modelica.Units.SI.Pressure disvalve_dp_nominal = 1e5 annotation(Dialog(tab = "Piping", group = "Discharge"));
  parameter Modelica.Units.SI.Area htdp_area = 1 annotation(Dialog(tab = "Piping", group = "Charge"));
  parameter Modelica.Units.SI.Length htdp_length = 10 annotation(Dialog(tab = "Piping", group = "Charge"));
  parameter Modelica.Units.SI.Length htdp_d_height = 0.0 annotation(Dialog(tab = "Piping", group = "Charge"));
  parameter Modelica.Units.SI.MassFlowRate chvalve_m_flow_nom = 25 annotation(Dialog(tab = "Piping", group = "Charge"));
  parameter Modelica.Units.SI.Pressure chvalve_dp_nominal = 1e5 annotation(Dialog(tab = "Piping", group = "Charge"));
  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_SHS;
