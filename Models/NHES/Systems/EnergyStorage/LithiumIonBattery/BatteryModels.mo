within NHES.Systems.EnergyStorage.LithiumIonBattery;
package BatteryModels

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

  model BatteryLevel_2
    "Level_2 Li-ion Battery with charge curve and internal resistance"
    // Developer: Haoyu Wang & Roberto Ponciroli, Argonne National Laboratory
    // Date: 2021-June-17

    // Some parameters were found at:
    // 1. https://cdn.sparkfun.com/assets/5/6/e/1/5/SPE-DTP603450-1000mah-3.7V-En-1.0V.pdf
    // 2. Tremblay, Olivier, Louis-A. Dessaint, and Abdel-Illah Dekkiche. "A generic
    //   battery model for the dynamic simulation of hybrid electric vehicles." In
    //   2007 IEEE Vehicle Power and Propulsion Conference, pp. 284-289. Ieee, 2007.
    import Modelica.Units.NonSI.*;
    import Modelica.Units.Conversions.*;

    Modelica.Blocks.Interfaces.RealInput pSetPoint(unit="W")
      "Demanded power output [W]" annotation (Placement(transformation(extent={{-120,
              -20},{-80,20}}), iconTransformation(extent={{-120,-20},{-80,20}})));
    NHES.Electrical.Interfaces.ElectricalPowerPort_b powerConnection
      "Interface to grid model"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    parameter Integer N=1
      "External - number of Battery Bank in parallel connection";

    parameter Modelica.Units.SI.Voltage MaxChargeVoltage=4.2
      "External - Max External Charging Voltage = 4.2V";
    parameter Modelica.Units.SI.Voltage MinEMF=3.0
      "Boundary - Min EMF during discharging = 3.0V";
  //   parameter Modelica.Units.SI.ElectricCurrent MaxChargeCurrent=1*N
  //     "Boundary - Single Cell Max. Charge Current = 1A";
  //   parameter Modelica.Units.SI.ElectricCurrent MaxOutputCurrent=1*N
  //     "Boundary - Single Cell Max. Output Current = 1A";
  //   parameter Modelica.Units.SI.ElectricCharge Q_max=N*from_Ah(1)
  //     "Boundary - Single Cell Max. Allowed Charge = 1Ah";
  //   parameter Modelica.Units.SI.ElectricCharge InitialCharge=0.5*Q_max
  //     "Boundary - Initial Charge on each cell = 0.5Ah";
    parameter Modelica.Units.SI.Power MaxChargeRate=5*N
      "Boundary - Single Cell Max. Charge Power = 5W";
    parameter Modelica.Units.SI.Power MaxDischargeRate=5*N
      "Boundary - Single Cell Max. Discharge Power = 5W";
    parameter Modelica.Units.SI.Energy TotalCapacity=N*from_Wh(3.6)
      "Boundary - Single Cell Total Capacity = 3.6Wh";
    parameter Modelica.Units.SI.Energy InitialEnergyStored=0.5*TotalCapacity
      "Boundary - Initial Charge on each cell = 1.8Wh";
    parameter Modelica.Units.SI.Voltage E0_C=3.7348
      "Charging Curve - Constant Voltage = 3.7348V";
    parameter Modelica.Units.SI.Voltage K_C=0.00876
      "Charging Curve - Polarization Constant = 0.00876V";
    parameter Modelica.Units.SI.Voltage A_C=0.468
      "Charging Curve - Exponential Zone amplitude = 0.468V";
    parameter Modelica.Units.SI.ElectricCharge InvB_C=from_Ah(1/3.5294)
      "Charging Curve - Exponential Zone Charge constant = (1/3.5294)Ah";
    parameter Modelica.Units.SI.Voltage E0_D=3.7348
      "Discharg Curve - Constant Voltage = 3.7348V";
    parameter Modelica.Units.SI.Voltage K_D=0.03
      "Discharg Curve - Polarization Constant = 0.03V";
    parameter Modelica.Units.SI.Voltage A_D=0.468
      "Discharg Curve - Exponential Zone amplitude = 0.468V";
    parameter Modelica.Units.SI.ElectricCharge InvB_D=from_Ah(1/10)
      "Discharg Curve - Exponential Zone Charge constant = (1/10)Ah";
    parameter Modelica.Units.SI.Resistance R_int=0.09/N
      "Single Cell Internal Resistance = 0.09 Ohm";

    Modelica.Units.SI.ElectricCurrent MaxChargeCurrent "Single Cell Max. Charge Current";
    Modelica.Units.SI.ElectricCurrent MaxOutputCurrent "Single Cell Max. Discharge Current";
    Modelica.Units.SI.ElectricCharge Q_max "Single Cell Max. Allowed Charge";
    Modelica.Units.SI.ElectricCharge InitialCharge "Initial Charge on each cell";
    Modelica.Units.SI.ElectricCharge ResidualCharge(start=InitialEnergyStored/E0_C,
        fixed=true) "Residual Charge in Battery";
    Modelica.Units.SI.Energy Energy_Stored "Total Energy Stored in the Battery";
    Modelica.Units.SI.ElectricCharge DeltaCharge(start=0)
      "Charge change since time=0";
    Modelica.Units.SI.Voltage EMF "Li-ion Electromotive Force";
    Modelica.Units.SI.ElectricCurrent BatteryCurrent(start=0)
      "Battery Current, Charge(-) or Discharge(+)";
    Modelica.Units.SI.Power TerminalPower "Battery Terminal Power";
    Modelica.Units.SI.Power Chem_Potential_Energy_Rate
      "Battery Chemical Potential Energy Drop Rate Charging(-)/Discharge(+)";
    Modelica.Units.SI.Frequency f "Electrical frequency";
    Modelica.Units.SI.Voltage ChargeVoltage
      "Adjusted External Charging Voltage";
    Real StateOfCharge "Q/QMax";

  equation
    assert(MaxChargeVoltage > 0, "External Charging Voltage should be positive value!");
    assert(R_int > 0, "Internal Resistance R_int should be positive value!");

    Energy_Stored = ResidualCharge*E0_C;
    // Convert ResidualCharge to Energy Stored in the Battery

    MaxChargeCurrent = MaxChargeRate/E0_C;
    MaxOutputCurrent = MaxDischargeRate/E0_D;
    Q_max=TotalCapacity/E0_C;
    InitialCharge=InitialEnergyStored/E0_C;
    // Convert W to Amp, Convert Wh to Coulomb


    der(DeltaCharge) = -BatteryCurrent;
    // dQ/dt=-I, for the battery charging level

    StateOfCharge = ResidualCharge/Q_max;

    if pSetPoint <= 0 then
      // Charging curve of Li-ion battery, EMF as a function of residualCharge
      EMF = E0_C - K_C*Q_max/ResidualCharge + A_C*exp(-(Q_max - ResidualCharge)/InvB_C);
    else
      // Discharging curve of Li-ion battery, EMF as a function of residualCharge
      EMF = E0_D - K_D*Q_max/ResidualCharge + A_D*exp(-(Q_max - ResidualCharge)/InvB_D);
    end if;

    if pSetPoint < 0 then
      //Charge mode, pSetPoint == negative, BatteryCurrent == negative
      if ResidualCharge < Q_max then
        // When the battery is not full yet
        if EMF < MaxChargeVoltage then
          // MaxChargeVoltage is higher than EMF
          if (MaxChargeVoltage-EMF)/R_int < MaxChargeCurrent then
            // If Current doesn't overload when Charge under MaxChargeVoltage,
            // try to charge at MaxChargeVoltage.
            if abs(pSetPoint) < MaxChargeVoltage*(MaxChargeVoltage-EMF)/R_int then
              // If power exceeds demand when charging at MaxChargeVoltage,
              // solve the 2nd order polynomial Vc*(Vc-EMF)/Rint=abs(pSetPoint)
              ChargeVoltage = (EMF + sqrt(EMF^2+4*R_int*abs(pSetPoint)))/2;
            else
              // If power within demand when charging at MaxChargeVoltage,
              // impose the MaxChargeVoltage
              ChargeVoltage = MaxChargeVoltage;
            end if;
          else
            // If Current overloads when Charge under MaxChargeVoltage,
            // reduce the ChargeVoltage to match pSetPoint
            if abs(pSetPoint) < MaxChargeCurrent*(EMF+R_int*MaxChargeCurrent) then
              // If demanded charging power is less than the Max allowed terminal
              // power (under MaxChargeCurrent), solve the 2nd order polynomial
              ChargeVoltage = (EMF + sqrt(EMF^2+4*R_int*abs(pSetPoint)))/2;
            else
              // If demanded charging power exceeds the Max allowed terminal
              // power (under MaxChargeCurrent), impose the MaxChargeCurrent
              ChargeVoltage = EMF + R_int*MaxChargeCurrent;
            end if;
          end if;
          BatteryCurrent = -(ChargeVoltage-EMF)/R_int;
        else
          // MaxChargeVoltage is lower than EMF, no charging
          ChargeVoltage = 0.0;
          BatteryCurrent = 0.0;
        end if;
      else
        // When battery is full, no charging
        ChargeVoltage = 0.0;
        BatteryCurrent = 0.0;
      end if;
      TerminalPower = ChargeVoltage*BatteryCurrent;
      Chem_Potential_Energy_Rate = -1*EMF*BatteryCurrent;

    elseif pSetPoint > 0 then
      //Discharge mode, pSetPoint == positive, BatteryCurrent == positive
      if EMF > MinEMF then
        // When the battery is not empty yet
        // Regulate the output current, to below the maximum deliverable power
        // (EMF^2/4/R_int)
        if (EMF*EMF-4*R_int*pSetPoint)<=0.1 then // pSetPoint > EMF*EMF/(4*R_int)
          // If Demanded power exceeds the maximum deliverable value,
          // regulate the current for maximum power delivery
          BatteryCurrent = min(MaxOutputCurrent, EMF/2/R_int);
          ChargeVoltage = 0.0;
        else
          // If Demanded power is below the maximum deliverable value,
          // solve the 2nd order polynomial and use the smaller root.
          BatteryCurrent = min(MaxOutputCurrent, (EMF - sqrt(EMF*EMF - 4*
            R_int*pSetPoint))/2/R_int);
          ChargeVoltage = 0.0;
        end if;
      else
        // When the battery is empty
        BatteryCurrent = 0.0;
        ChargeVoltage = 0.0;
      end if;
      TerminalPower = (EMF - BatteryCurrent*R_int)*BatteryCurrent;
      Chem_Potential_Energy_Rate = -1*EMF*BatteryCurrent;

    else
      //Idle Mode, pSetPoint==0
      BatteryCurrent = 0.0;
      ChargeVoltage = 0.0;
      TerminalPower = 0.0;
      Chem_Potential_Energy_Rate = 0.0;
    end if;

    // Update the ResidualCharge value
    ResidualCharge = InitialCharge + DeltaCharge;

    // Boundary conditions

    TerminalPower = powerConnection.W;
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
    <p>Developer: Haoyu Wang & Roberto Ponciroli, Argonne National Laboratory</p>
    <p>Date: 2021-June-17</p>
    <p>Some parameters were found at:</p>
    <p>1. https://cdn.sparkfun.com/assets/5/6/e/1/5/SPE-DTP603450-1000mah-3.7V-En-1.0V.pdf</p>
    <p>2. Tremblay, Olivier, Louis-A. Dessaint, and Abdel-Illah Dekkiche. A generic battery model for the dynamic simulation of hybrid electric vehicles. In 2007 IEEE Vehicle Power and Propulsion Conference, pp. 284-289. Ieee, 2007.</p>
    
    <p>This model mimics a single Lithium-ion battery cell with 1Ah capacity. </p>
    <p>The battery EMF is a function of the charging level, represented by the equation in Reference [2]. </p>
    <p>The charging curve and discharging curve can be individually specified using the E0, K, A, InvB parameters. '_C' for charging and '_D' for discharging</p>
    <p>In addition, four protection features are implimented in this model:</p>

    <p>1. Over-charge / Over-discharge protection;</p>
    <p>2. Over-current protection;</p>
    <p>3. Over-voltage protection;</p>
    <p>4. Over-power protection.</p>


</html>"));
  end BatteryLevel_2;
end BatteryModels;
