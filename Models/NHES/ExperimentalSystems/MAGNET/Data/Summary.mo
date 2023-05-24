within NHES.ExperimentalSystems.MAGNET.Data;
model Summary
  extends TRANSFORM.Icons.Record;

  input Modelica.Units.SI.Temperature Ts[:] annotation (Dialog(group="Inputs"));
  input Modelica.Units.SI.Pressure ps[:] annotation (Dialog(group="Inputs"));
  input Modelica.Units.SI.MassFlowRate m_flows[:]
    annotation (Dialog(group="Inputs"));
  input Modelica.Units.SI.HeatFlowRate Q_flows[:]
    annotation (Dialog(group="Inputs"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Summary;
