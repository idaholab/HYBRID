within NHES.Systems.IndustrialProcess.HeaderTurbineCombo.Data;
model Data_Dummy

  extends BaseClasses.Record_Data;

    package Medium = Modelica.Media.Water.StandardWater;

    parameter SI.Power Q_total = 400e6;
    parameter SI.Power Q_total_el = 0.35*Q_total;

  parameter Real frac_m_flow_HP_toProcess = 0.1;
  parameter Real frac_m_flow_IP_toProcess = 0.1;
  parameter Real frac_m_flow_LP_toProcess = 0.1;

  parameter SI.MassFlowRate m_flow_total = m_flow_HP/(1-frac_m_flow_HP_toProcess);

  parameter SI.MassFlowRate m_flow_HP = 0.5*Q_total_el/(h_HP-h_IP);
  parameter SI.MassFlowRate m_flow_HP_toProcess=frac_m_flow_HP_toProcess*m_flow_total;

  parameter SI.MassFlowRate m_flow_IP=m_flow_HP - m_flow_IP_toProcess;
  parameter SI.MassFlowRate m_flow_IP_toProcess=frac_m_flow_IP_toProcess*m_flow_HP;

  parameter SI.MassFlowRate m_flow_LP=m_flow_IP - m_flow_LP_toProcess;
  parameter SI.MassFlowRate m_flow_LP_toProcess=frac_m_flow_LP_toProcess*m_flow_IP;

  parameter SI.Pressure p_HP = 4.13e6;
  parameter SI.Temperature T_HP = 400+273.15;
  parameter SI.SpecificEnthalpy  h_HP = Medium.specificEnthalpy_pT(p_HP,T_HP);

  parameter SI.Pressure p_IP = 0.68e6;
  parameter SI.Temperature T_IP = 191+273.15;
  parameter SI.SpecificEnthalpy  h_IP = Medium.specificEnthalpy_pT(p_IP,T_IP);

  parameter SI.Pressure p_LP = 0.1e6;
  parameter SI.Temperature T_LP = 127+273.15;
  parameter SI.SpecificEnthalpy  h_LP = Medium.specificEnthalpy_pT(p_LP,T_LP);

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IP")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));

end Data_Dummy;
