within NHES.HydrogenTurbine.Interfaces;
connector ElectricalPowerPort_a "Electrical power connector at design inlet"
  extends HydrogenTurbine.Interfaces.ElectricalPowerPort;
  annotation (defaultComponentName="port_a",
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
            textString="%name")}),
       Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}));
end ElectricalPowerPort_a;
