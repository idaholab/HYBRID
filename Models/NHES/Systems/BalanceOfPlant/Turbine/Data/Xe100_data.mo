within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Xe100_data

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Pressure p_steam_vent = 150e5;
  parameter Modelica.Units.SI.Temperature T_Steam_Ref = 540+273.15;
  parameter Modelica.Units.SI.Power Q_Nom = 36e6;
  parameter Modelica.Units.SI.Temperature T_Feedwater = 208+273.15;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbine")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end Xe100_data;
