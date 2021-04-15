within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Data;
record LooselyCoupled

  extends BaseClasses.Record_Data;

  parameter SI.Power IP_Q_totalElec = 69.62449e6 "nominal IP electric demand";

  annotation (defaultComponentName="data",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="LooselyCoupled")}),            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LooselyCoupled;
