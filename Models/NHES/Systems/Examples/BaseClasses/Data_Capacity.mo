within NHES.Systems.Examples.BaseClasses;
model Data_Capacity
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Power BOP_capacity=300e6;
  parameter Modelica.Units.SI.Power IP_capacity=51.1454e6;
  parameter Modelica.Units.NonSI.Energy_Wh ES_capacity=20e6;
  parameter Modelica.Units.SI.Power SES_capacity=35e6;

  annotation(defaultComponentName="data");
end Data_Capacity;
