within NHES.Systems.EnergyStorage.PCM_HITB.Data;
model Data_CS

  extends BaseClasses.Record_Data;
  parameter Real Q_PCM_HT_Max = 3000 "Maximum heat tape power wrapped around the PCM vessel";
  parameter Real Q_HT_HP = 600 "Maximum heat tape power wrapped around guide tubes";

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_CS;
