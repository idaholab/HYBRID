within NHES.Systems.BalanceOfPlant.Turbine.Data;
model IntermediateTurbine

  extends BaseClasses.Record_Data;

  parameter Modelica.Units.SI.Pressure p_steam_vent = 35e5 "Overpressurization relief valve setpoint"; //error associated with too high Temperature calling using the steam generator pipe surface temperature and the water fluid pressure is your indicator that the system is overpressurized and leaving the steam tables
  parameter Modelica.Units.SI.Temperature T_Steam_Ref = 306.6+273.15 "Reference steam temperature";
  parameter Modelica.Units.SI.Power Q_Nom = 60e6 "Reference electrical power";
  parameter Modelica.Units.SI.Temperature T_Feedwater = 148+273.15 "Reference feedwater temperature";
  parameter Modelica.Units.SI.MassFlowRate valve_BV_Mflow = 10 "Bypass valve nominal mass flow";
  parameter Modelica.Units.SI.Pressure p_in_nominal = 3447380 "Nominal input pressure";

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbine")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end IntermediateTurbine;
