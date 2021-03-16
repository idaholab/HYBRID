within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.Data;
record ROdesal

  extends BaseClasses.Record_Data;

  parameter SI.Power IP_Q_totalElec = 49.8e6 "nominal IP electric demand";

  annotation (defaultComponentName="data",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="ROdesal")}),            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ROdesal;
