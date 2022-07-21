within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data;
model Data_CS

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Length hot_tank_level_min = 1.0;
  parameter Modelica.Units.SI.Length cold_tank_level_min = 1.0;
  parameter Modelica.Units.SI.Temperature hot_tank_ref_temp = 273.15+245;
  parameter Modelica.Units.SI.MassFlowRate steam_prod_rate = 2.5;
  parameter Modelica.Units.SI.MassFlowRate reference_charging_m_flow = 20;
  parameter Modelica.Units.SI.MassFlowRate reference_discharging_m_flow = 10;
  parameter Real discharge_control_ref_value = 100 "Change this value based on what control is based on. For temperature, make sure to enter in K";

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_CS;
