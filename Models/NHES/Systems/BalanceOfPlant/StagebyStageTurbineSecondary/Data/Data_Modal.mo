within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Data;
model Data_Modal

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Time Charge_Length = 17500; //Note this is adjusted in Trapezoid as Charge_Length-Charge_Ramp, same for discharge
  parameter Modelica.Units.SI.Time Charge_Ramp = 500;
  parameter Modelica.Units.SI.Time Charge_Delay = 9600;
  parameter Modelica.Units.SI.Time Cycle_Period = 86400;
  parameter Modelica.Units.SI.Time Discharge_Length = 22500;
  parameter Modelica.Units.SI.Time Discharge_Ramp = 1500;
  parameter Modelica.Units.SI.Time Discharge_Delay = 36000;

  parameter Modelica.Units.SI.Pressure P_Turbine_Reference = 37.6e5;
  parameter Modelica.Units.SI.PressureDifference dP_FCV_Reference = 2e5;
  parameter Modelica.Units.SI.MassFlowRate Feed_Flow_Nominal = 68.4;
  parameter Modelica.Units.SI.MassFlowRate Cycle_Bypass_Mflow_Reference = 32;
  parameter Modelica.Units.SI.Power Q_RX_Nominal = 162e6;
  parameter Modelica.Units.SI.Power Q_Turb_Nominal = 52e6;
  parameter Modelica.Units.SI.Power Q_Rx_Nom = 160e6;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_Modal;
