within NHES.Systems.BalanceOfPlant.RankineCycle.Data;
model Data_L3_master
  "Density inputs have large effects on nominal turbine pressures"
  extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Power Power_nom=5e6 "Electrical Power Nominal";

  parameter Modelica.Units.SI.Pressure HPT_p_in=36e5 "High Pressure Turbine Inlet Pressure" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure p_dump=45e5 "Overpressure Set Pressure  " annotation(Dialog(group="Pressure Sets"));

  parameter Modelica.Units.SI.Pressure p_i1=3e5 "Set Pressure Between High Pressure Turbine and Low Pressure Turbine 1" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure p_i2=1.5e5 "Set Pressure Between Low Pressure Turbine 1 and Low Pressure Turbine 2" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure cond_p=0.1e5 "Condenser Pressure"
                                                   annotation(Dialog(group="Pressure Sets"));

  parameter Modelica.Units.SI.Temperature Tin=573.15 "Inlet Steam Temperature" annotation(Dialog(group="Temperature Sets"));
  parameter Modelica.Units.SI.Temperature Tfeed=331.65 "Target Feed Water Temperature" annotation(Dialog(group="Temperature Sets"));

  parameter Modelica.Units.SI.Density d_HPT_in = 15.07744  "HPT inlet density"  annotation(Dialog(group="Density Sets"));
  parameter Modelica.Units.SI.Density d_LPT1_in = 1.81354   "LPT1 inlet density"  annotation(Dialog(group="Density Sets"));
  parameter Modelica.Units.SI.Density d_LPT2_in = 0.86254   "LPT2 inlet density"  annotation(Dialog(group="Density Sets"));

  parameter Modelica.Units.SI.MassFlowRate mdot_total=5.5 "Nominal Total Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_fh =0.1
                                                       "Nominal Controlled Feed Heating Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdpt_HPFH=0.002 "Set High pressure feedwater heating flow (Used in models with both LP and HP feed heating)" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_hpt= 5.5 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_lpt1= 5.5 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_lpt2= 4.794 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));

  parameter Modelica.Units.SI.MassFlowRate m_ext =1 annotation(Dialog(group="Extraction"));
  parameter Modelica.Units.SI.AbsolutePressure p_use =1e5 annotation(Dialog(group="Extraction"));
  parameter Real eta_t=0.93 "Isentropic Efficiency of the Turbines" annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_mech=1 "Mechincal Effieiency of the Turbines"  annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_p=0.9 "Isentropic Efficiency of the Pumps" annotation(Dialog(group="Efficiency Sets"));

  parameter Modelica.Units.SI.Pressure HPT_p_out=p_i1 annotation(Dialog(tab="Initialization",group="Pressures"));
  parameter Modelica.Units.SI.Pressure LPT1_p_in=p_i1 annotation(Dialog(tab="Initialization",group="Pressures"));
  parameter Modelica.Units.SI.Pressure LPT1_p_out=p_i2 annotation(Dialog(tab="Initialization",group="Pressures"));
  parameter Modelica.Units.SI.Pressure LPT2_p_in=p_i2 annotation(Dialog(tab="Initialization",group="Pressures"));
  parameter Modelica.Units.SI.Pressure LPT2_p_out=cond_p annotation(Dialog(tab="Initialization",group="Pressures"));

  parameter Modelica.Units.SI.SpecificEnthalpy h1=2782e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h4=2422e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h7=2174e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h9=2329e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h10=191e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h11=191e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h13=256e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h14=267e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h16=724e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));
  parameter Modelica.Units.SI.SpecificEnthalpy h17=724e3 annotation(Dialog(tab="Initialization",group="Enthalpies"));

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L3_master;
