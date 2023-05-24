within NHES.ExperimentalSystems.MAGNET.Data;
model data_hx
  extends TRANSFORM.Icons.Data;

  // Source 1: XLG Shell and Tube HX 2SEPT19BHFT Performance Worksheet

  parameter Modelica.Units.SI.Length d_shell=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(6.63);
  parameter Modelica.Units.SI.Length d_tube=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.98);
  parameter Modelica.Units.SI.Length th_shell=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.11);
  parameter Modelica.Units.SI.Length th_tube=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.04);

  parameter Real nTubes = 19;
  parameter Modelica.Units.SI.Length length_shell=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(4.92);
  parameter Modelica.Units.SI.Length length_tube=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(4.92);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end data_hx;
