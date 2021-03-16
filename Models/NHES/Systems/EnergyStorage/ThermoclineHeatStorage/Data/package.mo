within NHES.Systems.EnergyStorage.ThermoclineHeatStorage;
package Data

  record Data_TEDS

    extends BaseClasses.Record_Data;

  parameter SI.Temperature T_hot_side = 325;
  parameter SI.Temperature T_cold_side = 225;
    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="TES")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
</html>"));
  end Data_TEDS;
end Data;
