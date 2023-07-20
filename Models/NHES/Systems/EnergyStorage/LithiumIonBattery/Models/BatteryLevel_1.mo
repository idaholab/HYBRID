within NHES.Systems.EnergyStorage.LithiumIonBattery.Models;
model BatteryLevel_1
  "Level_1 DC power source with output/input regulator. assume linear power rate"
  // Developer: Roberto Ponciroli, Yu Tang, Thanh Hua, Richard Vilim,
  // Argonne National Laboratory
  // Date: 2016-Sept-30
  import Modelica.Units.NonSI.*;
  import Modelica.Units.Conversions.*;

  Modelica.Units.SI.Frequency f "Electrical frequency";
  Modelica.Units.SI.Power outputPower "Power set";

  Modelica.Blocks.Interfaces.RealInput pSetPoint(unit="W")
    "Demanded power output [W]" annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}), iconTransformation(extent={{-120,-20},{-80,20}})));
  NHES.Electrical.Interfaces.ElectricalPowerPort_b powerConnection
    "Interface to grid model"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  final constant Real HOUR2SECOND=from_hour(1) "Convert 1 hour to second";
  constant Real ONEHOUR=1.0 "one hour";
  parameter Integer N=1
    "External - number of Battery Bank in parallel connection";
  parameter Modelica.Units.SI.Energy TotalCapacity=from_kWh(480)
    "Full capacity of a battery bank can provide=480 kWh";
  parameter Modelica.Units.SI.Energy InitialEnergyStored=0.5*TotalCapacity
    "initial Capacity is set to full capacity";
  parameter Modelica.Units.SI.Energy usableCapacity=from_kWh(384)
    "usable capacity = 384 kWh";
  parameter Modelica.Units.SI.Energy minCapacity=TotalCapacity -
      usableCapacity "minimum capacity";
  parameter Modelica.Units.SI.Time usefulTime=5.0*HOUR2SECOND
    "time span in hour when battery is useful. Assume 5 hours";
  parameter Modelica.Units.SI.Power MaxDischargeRate=usableCapacity/usefulTime
    "assume constant discharge";
  parameter Modelica.Units.SI.Power MaxChargeRate=380*480*N
    "380A*480V*N=182400*N W";
  //maximum charge current=380A, Voltage=480V
  Modelica.Units.SI.Energy Energy_Stored(start=InitialEnergyStored, fixed=
        true) "current battery capacity";
  Modelica.Units.SI.Power changeRate(start=0) "Charge or Discharge power";
  // Modelica.SIunits.Power outputPower;
  Modelica.Units.SI.Energy capacityChange(start=0)
    "Capacity change since time=0";

equation
  der(capacityChange) = changeRate;

  if pSetPoint < 0 then
    //Charge mode, pSetPoint == negative
    //Filter the output, the battery may not be able to afford the max
    //charging rate
    if Energy_Stored <= TotalCapacity - MaxChargeRate*ONEHOUR*HOUR2SECOND then
      // The battery can be charged at max rate for at least one hour
      changeRate = if abs(pSetPoint) < MaxChargeRate then -pSetPoint else
        MaxChargeRate;
    elseif Energy_Stored <= TotalCapacity then
      // The battery can be charged at max rate for less than one hour
      changeRate = if abs(pSetPoint) < (TotalCapacity - Energy_Stored)/
        ONEHOUR/HOUR2SECOND then -pSetPoint else (TotalCapacity -
        Energy_Stored)/ONEHOUR/HOUR2SECOND;
    else
      // The battery cannot accept any more charge due to over-charging
      changeRate = 0.0;
    end if;

  elseif pSetPoint > 0 then
    //Discharge mode, pSetPoint == positive
    //filter the output, the battery may not be able to meet the demand
    //see if Capacity can last for one hour
    if Energy_Stored >= minCapacity + MaxDischargeRate*ONEHOUR*HOUR2SECOND then
      // The battery can be discharged at max rate for at least one hour
      changeRate = if pSetPoint < MaxDischargeRate then -pSetPoint else -MaxDischargeRate;
    elseif Energy_Stored > minCapacity then
      // The battery can be discharged at max rate for less than one hour
      changeRate = if pSetPoint < (Energy_Stored - minCapacity)/ONEHOUR/
        HOUR2SECOND then -pSetPoint else -(Energy_Stored - minCapacity)/
        ONEHOUR/HOUR2SECOND;
    else
      // The battery cannot release any more charge due to low capacity
      changeRate = 0.0;

    end if;

  else
    //Offline or unknown mode, say sign(pSetPoint)==0
    changeRate = 0.0;
  end if;

  outputPower = -changeRate;

  if capacityChange < 0 then
    Energy_Stored = if (InitialEnergyStored + capacityChange) < minCapacity
       then minCapacity else (InitialEnergyStored + capacityChange);
  else
    Energy_Stored = if (InitialEnergyStored + capacityChange) > TotalCapacity
       then TotalCapacity else (InitialEnergyStored + capacityChange);
  end if;

  // Boundary conditions

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
    
    <p>This model shows a simple input/output power regulator. </p>
    <p>The constraints of max charging power and max discharging power can be specified in the battery model. </p>
    <p>In addition to the hard constraints, </p>
    <p>When charging, the input power will gradually decrease when the charging level is approaching the max capacity. </p>
    <p>When discharging, the output power will gradually decrease when the capacity is approaching the emptyness. </p>


</html>"));
end BatteryLevel_1;
