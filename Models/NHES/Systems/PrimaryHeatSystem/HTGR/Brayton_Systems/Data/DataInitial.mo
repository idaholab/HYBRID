within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Data;
record DataInitial

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
end DataInitial;
