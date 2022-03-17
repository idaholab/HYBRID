within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Data;
model Data_HTGR_Pebble

  extends BaseClasses.Record_Data;

  import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

  replaceable package Coolant_Medium =
      Modelica.Media.Interfaces.PartialMedium                                  annotation(choicesAllMatching = true,dialog(group="Media"));
  replaceable package Fuel_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
  replaceable package Pebble_Medium =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                      annotation(dialog(group = "Media"),choicesAllMatching=true);
      replaceable package Aux_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
      replaceable package Waste_Heat_App_Medium =
      Modelica.Media.Interfaces.PartialMedium                                             annotation(choicesAllMatching = true, dialog(group = "Media"));

  //per module
  parameter SI.Power Q_total=160e6 "Total thermal output" annotation(dialog(group = "System Reference"));
  parameter SI.Power Q_total_el=45e6 "Total electrical output" annotation(dialog(group = "System Reference"));
  parameter Real eta=Q_total_el/Q_total "Net efficiency" annotation(dialog(group = "System Reference"));

  parameter SI.Pressure P_Release = 19.3e5 "Boundary release valve pressure downstream of precooler" annotation(dialog(group = "System Boundary Conditions"));
  parameter Real K_P_Release( unit="1/(m.kg)") annotation(dialog(tab = "Physical Components",group = "Valves"));
  parameter SI.Temperature T_Intercooler = 35+273.15 annotation(dialog(group = "System Boundary Conditions"));
  parameter SI.Temperature T_Precooler = 33+273.15 annotation(dialog(group = "System Boundary Conditions"));

  parameter SI.MassFlowRate m_flow=700 "Primary Side Flow";

  parameter SI.Length length_core=2.408 "meters (based on 1.33 H/D ratio)";
  parameter SI.Length d_core=1.5;

  parameter SI.Length r_outer_fuelRod=0.5*from_in(0.374) "Outside diameter of fuel rod (d3s1)";
  parameter SI.Length th_clad_fuelRod=from_in(0.024) "Cladding thickness of fuel rod (d3s1)";
  parameter SI.Length th_gap_fuelRod=0.5*from_in(0.0065) "Gap thickness between pellet and cladding (d3s1)";
  parameter SI.Length r_pellet_fuelRod=0.5*from_in(0.3195) "Pellet radius (d3s1)";
  parameter SI.Length pitch_fuelRod=from_in(0.496) "Fuel rod pitch (d3s1)";
  parameter TRANSFORM.Units.NonDim sizeAssembly=17 "square size of assembly (e.g., 17 = 17x17)";
  parameter TRANSFORM.Units.NonDim nRodFuel_assembly=264 "# of fuel rods per assembly (d3s1)";
  parameter TRANSFORM.Units.NonDim nRodNonFuel_assembly=sizeAssembly^2 - 264 "# of non-fuel rods per assembly (d3s1)";
  parameter TRANSFORM.Units.NonDim nAssembly=floor(Modelica.Constants.pi*d_core^2/4/(pitch_fuelRod*sizeAssembly)^2);

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
  parameter Real HX_Aux_K_tube(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Aux HX"));
  parameter Real HX_Aux_K_shell(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Aux HX"));

  parameter Real HX_Reheat_NTU = 10 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter SI.Volume HX_Reheat_Tube_Vol = 0.2 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter SI.Volume HX_Reheat_Shell_Vol = 0.2 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter Real HX_Reheat_K_tube(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter Real HX_Reheat_K_shell(unit = "1/m4") = 1 annotation(dialog(tab = "HXs", group = "Reheat HX"));
  parameter SI.Volume V_Intercooler = 0.0 annotation(dialog(tab = "HXs",group = "Coolers"));
  parameter SI.Volume V_Precooler = 0.0 annotation(dialog(tab = "HXs", group = "Coolers"));

  parameter Real nKernel_per_Pebble = 15000 annotation(dialog(tab = "Pebble Data"));
  parameter Real nPebble = 55000 annotation(dialog(tab = "Pebble Data"));
  parameter Integer nR_Fuel = 1 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Length r_Pebble = 0.03 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Length r_Fuel = 200e-6 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Length r_Buffer = r_Fuel + 100e-6 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Length r_IPyC = r_Buffer+40e-6 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Length r_SiC = r_IPyC+35e-6 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Length r_OPyC = r_SiC+40e-6 annotation(dialog(tab = "Pebble Data"));
  parameter SI.ThermalConductivity k_Buffer= 2.25 annotation(dialog(tab = "Pebble Data"));
  parameter SI.ThermalConductivity k_IPyC = 8.0 annotation(dialog(tab = "Pebble Data"));
  parameter SI.ThermalConductivity k_SiC = 175 annotation(dialog(tab = "Pebble Data"));
  parameter SI.ThermalConductivity k_OPyC = 8.0 annotation(dialog(tab = "Pebble Data"));
  parameter SI.Temperature Pebble_Surface_Init = 750+273.15 annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));
  parameter SI.Temperature Pebble_Center_Init = 1100+273.15 annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));

  parameter SI.Area A_LPDelay = 1;
  parameter SI.Length L_LPDelay = 5;
  parameter SI.Area A_HPDelay = 1;
  parameter SI.Length L_HPDelay = 1;

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
end Data_HTGR_Pebble;
