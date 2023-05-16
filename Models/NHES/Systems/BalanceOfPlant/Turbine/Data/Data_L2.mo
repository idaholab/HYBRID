within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Data_L2
  "Density inputs have large effects on nominal turbine pressures"
  extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Power Power_nom=5e6 "Electrical Power Nominal";

  parameter Modelica.Units.SI.Pressure HPT_p_in=36e5 "High Pressure Turbine Inlet Pressure" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure p_dump=45e5 "Overpressure Set Pressure  " annotation(Dialog(group="Pressure Sets"));

  parameter Modelica.Units.SI.Pressure p_i=3e5 "Set Pressure Between High Pressure Turbine and Low Pressure Turbine 1" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure cond_p=0.1e5 "Condenser Pressure"
                                                   annotation(Dialog(group="Pressure Sets"));

  parameter Modelica.Units.SI.Temperature Tin=573.15 "Inlet Steam Temperature" annotation(Dialog(group="Temperature Sets"));
  parameter Modelica.Units.SI.Temperature Tfeed=331.65 "Target Feed Water Temperature" annotation(Dialog(group="Temperature Sets"));

  parameter Modelica.Units.SI.Density d_HPT_in = 15.07744  "HPT inlet density"  annotation(Dialog(group="Density Sets"));
  parameter Modelica.Units.SI.Density d_LPT_in = 1.81354   "LPT1 inlet density"  annotation(Dialog(group="Density Sets"));

  parameter Modelica.Units.SI.Pressure HPT_p_out=p_i annotation(Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure LPT_p_in=p_i annotation(Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure LPT_p_out=cond_p annotation(Dialog(tab="Initialization"));


  parameter Modelica.Units.SI.MassFlowRate mdot_total=5.5 "Nominal Total Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_fh= 0.1
                                                       "Nominal Controlled Feed Heating Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_hpt= 5.5 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_lpt= 5.5 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));

  parameter Real eta_t=0.93 "Isentropic Efficiency of the Turbines" annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_mech=1 "Mechincal Effieiency of the Turbines"  annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_p=0.9 "Isentropic Efficiency of the Pumps" annotation(Dialog(group="Efficiency Sets"));

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L2;
