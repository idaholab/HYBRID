within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Data_L3_out
  "Density inputs have large effects on nominal turbine pressures"
  extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
  replaceable Data_L3_in Data;
   annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L3_out;
