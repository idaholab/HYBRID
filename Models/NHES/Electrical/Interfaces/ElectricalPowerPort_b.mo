within NHES.Electrical.Interfaces;
connector ElectricalPowerPort_b
  "Electrical power connector  at non-flow port"
  extends NHES.Electrical.Interfaces.ElectricalPowerPort;
  annotation (defaultComponentName="portElec_b",
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
        extent={{-40,40},{40,-40}},
        lineColor={0,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid),
        Ellipse(
        extent={{-30,30},{30,-30}},
        lineColor={255,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(extent={{-150,110},{150,50}}, textString="%name")}),
       Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Temporary connector until decision on how to exchange &QUOT;electrical power&QUOT;.... Want to specify V and I? what about 2 phase or 3 phase...</span></p>
</html>"));
end ElectricalPowerPort_b;
