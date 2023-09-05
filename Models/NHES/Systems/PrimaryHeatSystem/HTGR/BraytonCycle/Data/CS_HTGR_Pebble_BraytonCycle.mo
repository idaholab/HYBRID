within NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.Data;
model CS_HTGR_Pebble_BraytonCycle

  extends BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref = 850;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end CS_HTGR_Pebble_BraytonCycle;
