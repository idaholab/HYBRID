within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Data;
model Data_1

  extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Length l_ci=0.7;
  parameter Modelica.Units.SI.Length l_co=0.7;
  parameter Modelica.Units.SI.Radius r_coolant=0.0075;
  parameter Modelica.Units.SI.Volume V_up=11;
  parameter Modelica.Units.SI.Volume V_lp=11;
  parameter Integer nAsm=30;
  parameter Integer nSCs=19;
  parameter Modelica.Units.SI.Length l_fRX=7;
  parameter Modelica.Units.SI.Radius r_fRX=0.35;
  parameter Modelica.Units.SI.Length l_tRX=7;
  parameter Modelica.Units.SI.Radius r_i_tRX=0.35;
  parameter Modelica.Units.SI.Radius r_o_tRX=0.5;
  parameter Modelica.Units.SI.Length l_CO=5.6;
  parameter Modelica.Units.SI.Radius r_i_CO=3.25;
  parameter Modelica.Units.SI.Radius r_o_CO=3.5;
  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_1;
