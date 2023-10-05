within NHES.ExperimentalSystems.TEDS_New.Data;
model Data_AllModes

  extends BaseClasses.Record_Data;

  parameter Modelica.Units.SI.Temperature T_cold_design = 200+273.15;
  parameter Modelica.Units.SI.Temperature T_hot_design = 300+273.15;
  parameter Boolean  control_chiller_flow = true;
  parameter Modelica.Units.SI.MassFlowRate m_flow_glycolwater_chiller = 12.6;

  parameter Modelica.Units.SI.MassFlowRate MassFlow_Controlstart = 12.6;
  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_AllModes;
