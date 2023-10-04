within NHES.Systems.BalanceOfPlant.BraytonCycle.Data;
model Data_Brayton_One

  extends PrimaryHeatSystem.GenericModular_PWR.BaseClasses.Record_Data;

  import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

  parameter SI.Pressure P_Release = 19.3e5 "Boundary release valve pressure downstream of precooler" annotation(dialog(group = "System Boundary Conditions"));
  parameter Real K_P_Release( unit="1/(m.kg)") annotation(dialog(tab = "Physical Components",group = "Valves"));
  parameter SI.Temperature T_Intercooler = 35+273.15 annotation(dialog(group = "System Boundary Conditions"));
  parameter SI.Temperature T_Precooler = 33+273.15 annotation(dialog(group = "System Boundary Conditions"));

  //Turbine Data
  parameter Real Turbine_Efficiency = 0.93 annotation(dialog(tab = "Physical Components", group = "Turbine"));
  parameter Real Turbine_Pressure_Ratio = 2.975 annotation(dialog(tab = "Physical Components",group = "Turbine"));
  parameter SI.MassFlowRate Turbine_Nominal_MassFlowRate = 296 annotation(dialog(tab = "Physical Components", group = "Turbine"));

  //Compressors Data
  parameter Real LP_Comp_Efficiency = 0.91 annotation(dialog(tab = "Physical Components", group = "Compressors"));
  parameter Real LP_Comp_P_Ratio = 1.77 annotation(dialog(tab = "Physical Components", group = "Compressors"));
  parameter SI.MassFlowRate LP_Comp_MassFlowRate = 300 annotation(dialog(tab = "Physical Components", group = "Compressors"));

  parameter Real HP_Comp_Efficiency = 0.91 annotation(dialog(tab = "Physical Components", group = "Compressors"));
  parameter Real HP_Comp_P_Ratio = 1.77 annotation(dialog(tab = "Physical Components", group = "Compressors"));
  parameter SI.MassFlowRate HP_Comp_MassFlowRate = 300 annotation(dialog(tab = "Physical Components", group = "Compressors"));

  parameter SI.Volume V_Core_Outlet = 0.5;

  parameter Real HX_Aux_NTU = 1 annotation(dialog(tab = "HXs", group = "Aux HX"));
  parameter SI.Volume HX_Aux_Tube_Vol = 3 annotation(dialog(tab = "HXs", group = "Aux HX"));
  parameter SI.Volume HX_Aux_Shell_Vol = 3 annotation(dialog(tab = "HXs", group = "Aux HX"));
  parameter SI.Volume HX_Aux_Buffer_Vol = 1 annotation(dialog(tab = "HXs", group = "Aux HX"));
  parameter Real HX_Aux_K_tube(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Aux HX"));
  parameter Real HX_Aux_K_shell(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Aux HX"));

  parameter Real HX_Reheat_NTU = 10 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter SI.Volume HX_Reheat_Tube_Vol = 0.2 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter SI.Volume HX_Reheat_Shell_Vol = 0.2 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter SI.Volume HX_Reheat_Buffer_Vol = 0.1 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter Real HX_Reheat_K_tube(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter Real HX_Reheat_K_shell(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Reheat HX"));

  parameter SI.Volume V_Intercooler = 0.0 annotation(dialog(tab = "HXs",group = "Coolers"));
  parameter SI.Volume V_Precooler = 0.0 annotation(dialog(tab = "HXs", group = "Coolers"));

  parameter SI.Area A_LPDelay = 1;
  parameter SI.Length L_LPDelay = 5;
  parameter SI.Area A_HPDelay = 1;
  parameter SI.Length L_HPDelay = 1;

parameter SI.Pressure P_Turbine_Ref = 19.9e5 annotation(dialog(tab = "Initialization", group = "Physical Components"));
parameter SI.Temperature TStart_In_Turbine = 850+273.15 annotation(dialog(tab = "Initialization", group = "Physical Components"));
parameter SI.Temperature TStart_Out_Turbine = 478+273.15 annotation(dialog(tab = "Initialization", group = "Physical Components"));

parameter SI.Pressure P_LP_Comp_Ref = 19.3e5 annotation(dialog(tab = "Initialization", group = "Physical Components"));
parameter SI.Temperature TStart_LP_Comp_In = 33+273.15 annotation(dialog(tab = "Initialization", group = "Physical Components"));
parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15 annotation(dialog(tab = "Initialization", group = "Physical Components"));

parameter SI.Pressure P_HP_Comp_Ref = 19.9e5 annotation(dialog(tab = "Initialization", group = "Physical Components"));
parameter SI.Temperature TStart_HP_Comp_In = 850+273.15 annotation(dialog(tab = "Initialization", group = "Physical Components"));
parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15 annotation(dialog(tab = "Initialization", group = "Physical Components"));

parameter SI.Power HX_Aux_Q_Init = -1e6 annotation(dialog(tab = "Initialization", group = "HX_Aux"));
parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3 annotation(dialog(tab = "Initialization", group = "HX_Aux"));
parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3 annotation(dialog(tab = "Initialization", group = "HX_Aux"));
parameter SI.Pressure HX_Aux_p_tube = 1e5 annotation(dialog(tab = "Initialization", group = "HX_Aux"));

parameter Boolean use_T_Tube = true annotation(dialog(tab = "Initialization", group = "Recuperator HX"));
parameter SI.Temperature Recuperator_T_Tube_Inlet = 478+273.15 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = use_T_Tube));
parameter SI.Temperature Recuperator_T_Tube_Outlet = 125+273.15 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = use_T_Tube));

parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = not use_T_Tube));
parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = not use_T_Tube));
parameter SI.Pressure Recuperator_P_Tube = 19.4e5 annotation(dialog(tab = "Initialization", group = "Recuperator HX"));
parameter SI.Pressure Recuperator_dp_Tube = 0.3e5 annotation(dialog(tab = "Initialization", group = "Recuperator HX"));
parameter SI.MassFlowRate Recuperator_m_Tube = 296.1 annotation(dialog(tab = "Initialization", group = "Recuperator HX"));
parameter Boolean use_T_shell = true annotation(dialog(tab = "Initialization", group = "Recuperator HX"));
parameter SI.Temperature Recuperator_T_Shell_Inlet = 115+273.15 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = use_T_shell));
parameter SI.Temperature Recuperator_T_Shell_Outlet = 468+273.15 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = use_T_shell));
parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = not use_T_shell));
parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3 annotation(dialog(tab = "Initialization", group = "Recuperator HX", enable = not use_T_shell));
parameter SI.Pressure Recuperator_P_Shell = 60.4e5 annotation(dialog(tab = "Initialization", group = "Recuperator HX"));

parameter SI.Pressure Recuperator_dp_Shell = 0.4e5 annotation(dialog(tab = "Initialization", group = "Recuperator HX"));
parameter SI.MassFlowRate Recuperator_m_Shell = 296.1 annotation(dialog(tab = "Initialization", group = "Recuperator HX"));

parameter SI.Pressure P_Intercooler = 59.2e5 annotation(dialog(tab = "Initialization"));
parameter SI.Pressure P_Precooler = 30e5 annotation(dialog(tab="Initialization"));

equation
 // assert(abs(lengths[1] - lengths[2]) <= Modelica.Constants.eps, "Hot/cold leg lengths must be equal");
 // assert(abs(length_reactorVessel - lengths[1] - length_pressurizer) <= Modelica.Constants.eps, "Hot leg and pressurizer must be equal to reactor vessel length");

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="Pebble Bed")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_Brayton_One;
