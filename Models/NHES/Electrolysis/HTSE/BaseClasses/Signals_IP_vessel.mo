within NHES.Electrolysis.HTSE.BaseClasses;
expandable connector Signals_IP_vessel "Data bus for IP signals"
  extends Electrolysis.Interfaces.SignalSubBus;

  SI.Power W_Aux( displayUnit="MW")
      "Power consumption in the feedpump and multistage compression system" annotation ();
  SI.Power W_SOEC( displayUnit="MW")
      "Power consumption in the SOEC stacks" annotation ();
  SI.Power W_Vessel( displayUnit="MW")
      "Power consumption in the HTSE vessels";
  SI.Power W_HTSE( displayUnit="MW")
      "Total power consumption in the HTSE plant" annotation ();
  SI.Power W_GT( displayUnit="MW")
      "Power consumption from the gas turbine" annotation ();

  SI.MassFlowRate m_flow_H2_prod "H2 produced during electrolysis" annotation ();
  SI.MassFlowRate m_flow_O2_prod "O2 produced during electrolysis" annotation ();

  SI.MassFlowRate m_flow_in
      "Mass flow rate of entering fluid (from the EM to the IP )"
      annotation ();
  SI.Temperature T_in( displayUnit="degC")
      "Temperature of entering fluid (from the EM to the IP)" annotation ();
  SI.Pressure p_in "Pressure of entering fluid (from the EM to the IP)"
      annotation ();

  SI.MassFlowRate m_flow_out
      "Mass flow rate of fluid going out (from the IP to the EM)"
      annotation ();
  SI.Temperature T_out( displayUnit="degC")
      "Temperature of fluid going out (from the IP to the EM)" annotation ();
  SI.Pressure p_out "Pressure of fluid going out (from the IP to the EM)"
      annotation ();

  SI.Temperature TNOut_anodeGas( displayUnit="degC") "Measured anode stream temperature at the anode HX outlet";
  SI.Temperature TNOut_cathodeGas( displayUnit="degC") "Measured cathode stream temperature at the cathode HX outlet";

  annotation (defaultComponentPrefixes="protected",
              Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-20,2},{22,-2}},
          lineColor={255,204,51},
          lineThickness=0.5)}),
    Documentation(info="<html>
<p>
Signal bus that is used to communicate all signals for <b>one</b> axis.
This is an expandable connector which has a \"default\" set of
signals. Note, the input/output causalities of the signals are
determined from the connections to this bus.
</p>

</html>"));
end Signals_IP_vessel;
