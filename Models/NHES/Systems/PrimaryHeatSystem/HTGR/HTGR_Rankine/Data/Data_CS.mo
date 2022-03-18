within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Data;
model Data_CS

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref = 850+273.15;
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom = 600;
  parameter Modelica.Units.SI.Temperature T_Steam_Ref = 540+273.15;
  parameter Modelica.Units.SI.Power Q_Nom = 36e6;
  parameter Modelica.Units.SI.Power Q_RX_Therm_Nom = 125e6;
  parameter Modelica.Units.SI.Temperature T_Feedwater = 208+273.15;
  parameter Modelica.Units.SI.Pressure P_Steam_Ref = 140e5;

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
