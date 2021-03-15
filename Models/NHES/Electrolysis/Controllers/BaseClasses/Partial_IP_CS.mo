within NHES.Electrolysis.Controllers.BaseClasses;
partial model Partial_IP_CS "Partial control system for the Industrial Process"
  //extends Electrolysis.Icons.PartialBackground;

  Electrolysis.Interfaces.SignalBus signalBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{-34,-56},{34,-86}},
          lineColor={0,0,0},
          textString="IP Control System")}),                     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Partial_IP_CS;
