within NHES.Fluid;
model Intermediate_Rankine
  parameter Modelica.Units.SI.Pressure p_steam_vent = 50e5 "Overpressurization relief valve setpoint"; //error associated with too high Temperature calling using the steam generator pipe surface temperature and the water fluid pressure is your indicator that the system is overpressurized and leaving the steam tables
  parameter Modelica.Units.SI.Temperature T_Steam_Ref = 540+273.15 "Reference steam temperature";
  parameter Modelica.Units.SI.Power Q_Nom = 50e6 "Reference electrical power";
  parameter Modelica.Units.SI.Temperature T_Feedwater = 208+273.15 "Reference feedwater temperature";

  extends Systems.BalanceOfPlant.Turbine.BaseClasses.Record_Data;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="Rankine")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end Intermediate_Rankine;
