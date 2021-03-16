within NHES.Systems.BalanceOfPlant.Turbine.Data;
model IdealTurbine

  extends BaseClasses.Record_Data;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbine")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end IdealTurbine;
