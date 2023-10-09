within NHES.ExperimentalSystems.TEDS_New.Data;
model Initial_Data_Dummy

  extends BaseClasses.Record_Data;


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
end Initial_Data_Dummy;
