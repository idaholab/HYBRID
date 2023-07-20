within NHES.Systems.EnergyStorage.LithiumIonBattery.Models;
model BatteryLevel_0
  "Level_0 DC power generator. Echoes the demanded/supplied power, no integration"
  // Developer: Roberto Ponciroli, Yu Tang, Thanh Hua, Richard Vilim,
  // Argonne National Laboratory
  // Date: 2016-Sept-30
  import Modelica.Units.NonSI.*;

  Modelica.Units.SI.Frequency f "Electrical frequency";
  Modelica.Units.SI.Power outputPower "Power set";

  Modelica.Blocks.Interfaces.RealInput pSetPoint(unit="W")
    "Demanded power output [W], positive-discharging, negative-charging"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  NHES.Electrical.Interfaces.ElectricalPowerPort_b powerConnection
    "Interface to grid model"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation

  outputPower = pSetPoint;
  outputPower = powerConnection.W;
  f = powerConnection.f;

  annotation (
    defaultComponentName="battery",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,52},{40,-50}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{80,20},{100,-20}},
          lineColor={0,0,127},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,52},{80,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,128,0}),
        Line(points={{50,30},{70,30}}, color={0,0,127}),
        Line(points={{60,20},{60,40}}, color={0,0,127}),
        Line(points={{60,-40},{60,-20}}, color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
    <p>Developer: Roberto Ponciroli, Thanh Hua, Yu Tang, Richard Vilim, Argonne National Laboratory</p>
    <p>Date: 2016-September-30</p>
    
    <p>This model shows a ideal battery whose output power echoes the input demand. </p>
    <p>No integration features are implemented in this model.</p>


</html>"));
end BatteryLevel_0;
