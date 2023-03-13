within NHES.Systems.BalanceOfPlant.Turbine.Data;
model VN_Data

  extends BaseClasses.Record_Data;

  parameter Modelica.Units.SI.Temperature T_Steam_Ref = 550+273.15 "Reference steam temperature";

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IdealTurbine")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end VN_Data;
