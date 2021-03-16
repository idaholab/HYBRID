within NHES.Systems.SwitchYard.SimpleYard.Data;
model SimpleBreakers

  extends BaseClasses.Record_Data;

  annotation (defaultComponentName="data",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="SimpleBreakers")}),            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleBreakers;
