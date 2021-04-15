within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Data;
record TightlyCoupled

  extends BaseClasses.Record_Data;

  parameter SI.Power IP_Q_totalElec = 51.1454e6 "nominal IP electric demand";

  annotation (defaultComponentName="data",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="TightlyCoupled")}),            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TightlyCoupled;
