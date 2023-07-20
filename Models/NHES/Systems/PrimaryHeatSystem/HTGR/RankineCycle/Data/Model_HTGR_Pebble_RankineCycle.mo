within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.Data;
model Model_HTGR_Pebble_RankineCycle

  extends BaseClasses.Record_Data;

  import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

  replaceable package Coolant_Medium =
      Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));

  //-----------------------------------------------------------------//
  // General //
  //-----------------------------------------------------------------//
  parameter SI.Power Q_total=160e6 "Total thermal output"                                                              annotation(dialog(tab = "General", group = "System Reference"));
  parameter SI.Power Q_total_el=45e6 "Total electrical output"                                                         annotation(dialog(tab = "General", group = "System Reference"));
  parameter Real eta=Q_total_el/Q_total "Net efficiency"                                                               annotation(dialog(tab = "General", group = "System Reference"));

  parameter SI.Pressure P_Release = 19.3e5 "Boundary release valve pressure downstream of precooler"                   annotation(dialog(tab = "General", group = "System Boundary Conditions"));
  parameter SI.Temperature T_Intercooler = 35+273.15                                                                   annotation(dialog(tab = "General", group = "System Boundary Conditions"));
  parameter SI.Temperature T_Precooler = 33+273.15                                                                     annotation(dialog(tab = "General", group = "System Boundary Conditions"));
  parameter SI.MassFlowRate m_flow=700 "Primary Side Flow"                                                             annotation(dialog(tab = "General", group = "System Boundary Conditions"));

  parameter SI.Length length_core=2.408 "meters (based on 1.33 H/D ratio)"                                             annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length d_core=1.5                                                                                       annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length r_outer_fuelRod=0.5*from_in(0.374) "Outside diameter of fuel rod (d3s1)"                         annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length th_clad_fuelRod=from_in(0.024) "Cladding thickness of fuel rod (d3s1)"                           annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length th_gap_fuelRod=0.5*from_in(0.0065) "Gap thickness between pellet and cladding (d3s1)"            annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length r_pellet_fuelRod=0.5*from_in(0.3195) "Pellet radius (d3s1)"                                      annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length pitch_fuelRod=from_in(0.496) "Fuel rod pitch (d3s1)"                                             annotation(dialog(tab = "General", group = "Geometry"));
  parameter TRANSFORM.Units.NonDim sizeAssembly=17 "square size of assembly (e.g., 17 = 17x17)"                        annotation(dialog(tab = "General", group = "Geometry"));
  parameter TRANSFORM.Units.NonDim nRodFuel_assembly=264 "# of fuel rods per assembly (d3s1)"                          annotation(dialog(tab = "General", group = "Geometry"));
  parameter TRANSFORM.Units.NonDim nRodNonFuel_assembly=sizeAssembly^2 - 264 "# of non-fuel rods per assembly (d3s1)"  annotation(dialog(tab = "General", group = "Geometry"));
  parameter TRANSFORM.Units.NonDim nAssembly=floor(Modelica.Constants.pi*d_core^2/4/(pitch_fuelRod*sizeAssembly)^2)    annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Volume V_Core_Outlet = 0.5                                                                              annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Area A_LPDelay = 1                                                                                      annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length L_LPDelay = 5                                                                                    annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Area A_HPDelay = 1                                                                                      annotation(dialog(tab = "General", group = "Geometry"));
  parameter SI.Length L_HPDelay = 1                                                                                    annotation(dialog(tab = "General", group = "Geometry"));

  parameter Real K_P_Release( unit="1/(m.kg)")                                                                         annotation(dialog(tab = "General",group = "Valves"));

  parameter Real Turbine_Efficiency = 0.93                                                                             annotation(dialog(tab = "General", group = "Turbine"));
  parameter Real Turbine_Pressure_Ratio = 2.975                                                                        annotation(dialog(tab = "General", group = "Turbine"));
  parameter SI.MassFlowRate Turbine_Nominal_MassFlowRate = 296                                                         annotation(dialog(tab = "General", group = "Turbine"));

  parameter Real LP_Comp_Efficiency = 0.91                                                                             annotation(dialog(tab = "General", group = "Compressors"));
  parameter Real LP_Comp_P_Ratio = 1.77                                                                                annotation(dialog(tab = "General", group = "Compressors"));
  parameter SI.MassFlowRate LP_Comp_MassFlowRate = 300                                                                 annotation(dialog(tab = "General", group = "Compressors"));
  parameter Real HP_Comp_Efficiency = 0.91                                                                             annotation(dialog(tab = "General", group = "Compressors"));
  parameter Real HP_Comp_P_Ratio = 1.77                                                                                annotation(dialog(tab = "General", group = "Compressors"));
  parameter SI.MassFlowRate HP_Comp_MassFlowRate = 300                                                                 annotation(dialog(tab = "General", group = "Compressors"));

  parameter Real HX_Aux_NTU = 1                                                                                        annotation(dialog(tab = "General", group = "HX_Aux"));
  parameter SI.Volume HX_Aux_Tube_Vol = 3                                                                              annotation(dialog(tab = "General", group = "HX_Aux"));
  parameter SI.Volume HX_Aux_Shell_Vol = 3                                                                             annotation(dialog(tab = "General", group = "HX_Aux"));
  parameter SI.Volume HX_Aux_Buffer_Vol = 1                                                                            annotation(dialog(tab = "General", group = "HX_Aux"));
  parameter Real HX_Aux_K_tube(unit = "1/m4") = 1                                                                      annotation(dialog(tab = "General", group = "HX_Aux"));
  parameter Real HX_Aux_K_shell(unit = "1/m4") = 1                                                                     annotation(dialog(tab = "General", group = "HX_Aux"));

  parameter Real HX_Reheat_NTU = 10                                                                                    annotation(dialog(tab = "General", group = "HX_Reheat"));
  parameter SI.Volume HX_Reheat_Tube_Vol = 0.2                                                                         annotation(dialog(tab = "General", group = "HX_Reheat"));
  parameter SI.Volume HX_Reheat_Shell_Vol = 0.2                                                                        annotation(dialog(tab = "General", group = "HX_Reheat"));
  parameter SI.Volume HX_Reheat_Buffer_Vol = 0.1                                                                       annotation(dialog(tab = "General", group = "HX_Reheat"));
  parameter Real HX_Reheat_K_tube(unit = "1/m4") = 1                                                                   annotation(dialog(tab = "General", group = "HX_Reheat"));
  parameter Real HX_Reheat_K_shell(unit = "1/m4") = 1                                                                  annotation(dialog(tab = "General", group = "HX_Reheat"));

  parameter SI.Volume V_Intercooler = 0.0                                                                              annotation(dialog(tab = "General", group = "Coolers"));
  parameter SI.Volume V_Precooler = 0.0                                                                                annotation(dialog(tab = "General", group = "Coolers"));

  parameter Real nKernel_per_Pebble = 15000                                                                            annotation(dialog(tab = "General", group = "Pebble"));
  parameter Real nPebble = 55000                                                                                       annotation(dialog(tab = "General", group = "Pebble"));
  parameter Integer nR_Fuel = 1                                                                                        annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.Length r_Pebble = 0.03                                                                                  annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.Length r_Fuel = 200e-6                                                                                  annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.Length r_Buffer = r_Fuel + 100e-6                                                                       annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.Length r_IPyC = r_Buffer+40e-6                                                                          annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.Length r_SiC = r_IPyC+35e-6                                                                             annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.Length r_OPyC = r_SiC+40e-6                                                                             annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.ThermalConductivity k_Buffer= 2.25                                                                      annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.ThermalConductivity k_IPyC = 8.0                                                                        annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.ThermalConductivity k_SiC = 175                                                                         annotation(dialog(tab = "General", group = "Pebble"));
  parameter SI.ThermalConductivity k_OPyC = 8.0                                                                        annotation(dialog(tab = "General", group = "Pebble"));

  //-----------------------------------------------------------------//
  // Initialization //
  //-----------------------------------------------------------------//
  parameter SI.Temperature Pebble_Surface_Init = 750+273.15           annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));
  parameter SI.Temperature Pebble_Center_Init = 1100+273.15           annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));

  parameter SI.Pressure P_Turbine_Ref = 19.9e5                        annotation(dialog(tab = "Initialization", group = "Turbine"));
  parameter SI.Temperature TStart_In_Turbine = 850+273.15             annotation(dialog(tab = "Initialization", group = "Turbine"));
  parameter SI.Temperature TStart_Out_Turbine = 478+273.15            annotation(dialog(tab = "Initialization", group = "Turbine"));

  parameter SI.Pressure P_LP_Comp_Ref = 19.3e5                        annotation(dialog(tab = "Initialization", group = "Turbine"));
  parameter SI.Temperature TStart_LP_Comp_In = 33+273.15              annotation(dialog(tab = "Initialization", group = "Turbine"));
  parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15            annotation(dialog(tab = "Initialization", group = "Turbine"));

  parameter SI.Pressure P_HP_Comp_Ref = 19.9e5                        annotation(dialog(tab = "Initialization", group = "Turbine"));
  parameter SI.Temperature TStart_HP_Comp_In = 850+273.15             annotation(dialog(tab = "Initialization", group = "Turbine"));
  parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15            annotation(dialog(tab = "Initialization", group = "Turbine"));

  parameter SI.Power HX_Aux_Q_Init = -1e6                             annotation(dialog(tab = "Initialization", group = "HX_Aux"));
  parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3              annotation(dialog(tab = "Initialization", group = "HX_Aux"));
  parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3             annotation(dialog(tab = "Initialization", group = "HX_Aux"));
  parameter SI.Pressure HX_Aux_p_tube = 1e5                           annotation(dialog(tab = "Initialization", group = "HX_Aux"));

  parameter SI.Pressure P_Core_Inlet = 60e5                         annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
  parameter SI.Pressure P_Core_Outlet = 59.4e5                      annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
  parameter SI.Temperature T_Core_Inlet = 623.15                    annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
  parameter SI.Temperature T_Core_Outlet = 1023.15                  annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
  parameter SI.Temperature T_Pebble_Init = T_Core_Outlet            annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
  parameter SI.Temperature T_Fuel_Center_Init = 1473.15             annotation(dialog(tab = "Initialization", group = "Reactor_Core"));

  parameter SI.Pressure Recuperator_P_Tube = 19.4e5                   annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
  parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3     annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
  parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3    annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
  parameter SI.Pressure Recuperator_dp_Tube = 0.3e5                   annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
  parameter SI.MassFlowRate Recuperator_m_Tube = 296.1                annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));

  parameter SI.Pressure Recuperator_P_Shell = 60.4e5                  annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
  parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3    annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
  parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3   annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
  parameter SI.Pressure Recuperator_dp_Shell = 0.4e5                  annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
  parameter SI.MassFlowRate Recuperator_m_Shell = 296.1               annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));

  parameter SI.Pressure P_Intercooler = 59.2e5                        annotation(dialog(tab = "Initialization", group = "Cooler"));
  parameter SI.Pressure P_Precooler = 30e5                            annotation(dialog(tab = "Initialization", group = "Cooler"));

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
end Model_HTGR_Pebble_RankineCycle;
