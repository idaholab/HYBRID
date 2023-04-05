within NHES.Systems.IndustrialProcess.IS_Dummy.Data;
model Data_Dummy

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Pressure p_process = 200000;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_Dummy;
