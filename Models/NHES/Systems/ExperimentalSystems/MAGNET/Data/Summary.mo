within NHES.Systems.ExperimentalSystems.MAGNET.Data;
model Summary
  extends TRANSFORM.Icons.Record;

  input SI.Temperature Ts[:] annotation(Dialog(group="Inputs"));
  input SI.Pressure ps[:] annotation(Dialog(group="Inputs"));
  input SI.MassFlowRate m_flows[:] annotation(Dialog(group="Inputs"));
  input SI.HeatFlowRate Q_flows[:] annotation(Dialog(group="Inputs"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Summary;
