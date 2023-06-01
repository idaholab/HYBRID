within NHES.TestModels_AS;
model Data_Condensation_AS2022

  extends Systems.PrimaryHeatSystem.GenericModular_PWR.BaseClasses.Record_Data;
  import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

  parameter SI.Length length_steamGenerator=5.5;
  parameter SI.Length d_steamGenerator_shell_inner=1.4;
  parameter SI.Length d_steamGenerator_shell_outer=2.75;

  parameter SI.Length d_steamGenerator_tube_outer=from_in(0.5);
  parameter SI.Length th_steamGenerator_tube=from_in(0.083) "Sch 10/20";
  parameter SI.Length d_steamGenerator_tube_inner=d_steamGenerator_tube_outer - 2*th_steamGenerator_tube;
  parameter SI.Length length_steamGenerator_tube = 26.0752;
  parameter Real nTubes_steamGenerator=2240;


equation

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="GenericModule")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_Condensation_AS2022;
