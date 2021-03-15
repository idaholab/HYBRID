within NHES.Systems.SupervisoryControl.BaseClasses;
partial model Partial_ControlSystem

  extends NHES.Systems.BaseClasses.Partial_ControlSystem;

  annotation (defaultComponentName="SC",
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
                  Text(
          extent={{-94,-62},{94,-70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Supervisory")}),     Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end Partial_ControlSystem;
