within NHES.Systems.ElectricalGrid.InfiniteGrid.Data;
model Infinite

  extends BaseClasses.Record_Data;

  annotation (defaultComponentName="data",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="Infinite")}),                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Infinite;
