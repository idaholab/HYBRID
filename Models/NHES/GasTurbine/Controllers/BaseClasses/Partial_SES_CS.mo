within NHES.GasTurbine.Controllers.BaseClasses;
partial model Partial_SES_CS "Partial control system for the Secondary Energy Supply"

  Interfaces.SignalBus signalBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,213,170},
          fillPattern=FillPattern.Sphere,
          radius=2,
          fillColor={255,213,170}),
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={175,175,175},
          fillColor={223,220,216},
          fillPattern=FillPattern.Solid,
          radius=1),
        Text(
          extent={{-40,-60},{40,-84}},
          lineColor={0,0,0},
          textString="SES Control System")}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Partial_SES_CS;
