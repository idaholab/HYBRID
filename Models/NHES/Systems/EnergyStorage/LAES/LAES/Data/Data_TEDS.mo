within NHES.Systems.EnergyStorage.LAES.LAES.Data;
record Data_TEDS

  extends BaseClasses.Record_Data;

parameter Modelica.Units.SI.Temperature T_hot_side=325;
parameter Modelica.Units.SI.Temperature T_cold_side=225;
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
