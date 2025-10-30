within NHES.Systems.EnergyStorage.PCM_HITB.Data;
model Data_InitialConditions

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Temperature T_PCM = 400 + 273.15 annotation(Dialog(group = "PCM"));
  parameter Modelica.Units.SI.Temperature T_Wall = 400 + 273.15 annotation(Dialog(group = "PCM"));
  parameter Modelica.Units.SI.Temperature T_HT = 400 + 273.15 annotation(Dialog(group = "PCM"));
  parameter Modelica.Units.SI.Temperature T_Insulation_Inner = 400 + 273.15 annotation(Dialog(group = "PCM"));
  parameter Modelica.Units.SI.Temperature T_Insulation_Outer = 400 + 273.15 annotation(Dialog(group = "PCM"));

  parameter Modelica.Units.SI.Temperature T_Tube_UGT = 400 + 273.15 annotation(Dialog(group = "Upper GT"));
  parameter Modelica.Units.SI.Temperature T_Insulation_UGT = 400 + 273.15 annotation(Dialog(group = "Upper GT"));

  parameter Modelica.Units.SI.Temperature T_UHP = 300+273.15 annotation(Dialog(group = "Upper HP"));


  parameter Modelica.Units.SI.Temperature T_Tube_LGT = 400+273.15 annotation(Dialog(group = "Lower GT"));
  parameter Modelica.Units.SI.Temperature T_Insulation_LGT = 400+273.15 annotation(Dialog(group = "Lower GT"));

  parameter Modelica.Units.SI.Temperature T_LHP = 300+273.15 annotation(Dialog(group = "Lower HP"));
  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_InitialConditions;
