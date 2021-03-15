within NHES.Electrolysis.HTSE.BaseClasses;
expandable connector Signals_IP "Data bus for IP signals"
  extends Electrolysis.Interfaces.SignalSubBus;

  SI.Power c_We_SOEC( displayUnit="MW")
    "Total electrical load in the SOEC stacks"
                                              annotation ();

  SI.Power s_We_SOEC( displayUnit="MW")
    "Total power consumption in the SOEC stacks"
                                                annotation ();
  SI.Power s_We_HTSE( displayUnit="MW")
    "Total power consumption in the HTSE plant"
                                               annotation ();
  SI.MassFlowRate s_mH2_prod "H2 produced during electrolysis" annotation ();
  SI.MassFlowRate s_mO2_prod "O2 produced during electrolysis" annotation ();

  SI.MassFlowRate s_w_in
    "Mass flow rate of entering fluid (from the EM to the IP )"
      annotation ();
  SI.Temperature s_T_in( displayUnit="degC")
    "Temperature of entering fluid (from the EM to the IP)"   annotation ();
  SI.Pressure s_p_in "Pressure of entering fluid (from the EM to the IP)"
      annotation ();

  SI.MassFlowRate s_w_out
    "Mass flow rate of fluid going out (from the IP to the EM)"
      annotation ();
  SI.Temperature s_T_out( displayUnit="degC")
    "Temperature of fluid going out (from the IP to the EM)"   annotation ();
  SI.Pressure s_p_out "Pressure of fluid going out (from the IP to the EM)"
      annotation ();

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
end Signals_IP;
