within NHES.Systems.EnergyStorage.SHS_Two_Tank.Data;
model Data_Default

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Length hot_tank_level_max = 15;
  parameter Modelica.Units.SI.Length cold_tank_level_max = 15;
  parameter Modelica.Units.SI.Temperature hot_tank_ref_temp = 273.15+245;
  parameter Modelica.Units.SI.Temperature cold_tank_ref_temp = 273.15+160;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_Default;
