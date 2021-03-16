within NHES.GasTurbine.Icons;
model PartialBackground "Base layout for the gas turbine power plant model"

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-120,120},{120,-120}},
          lineColor={255,213,170},
          fillPattern=FillPattern.Sphere,
          radius=2,
          fillColor={255,213,170}),
        Rectangle(
          extent={{-90,90},{90,-90}},
          lineColor={175,175,175},
          fillColor={223,220,216},
          fillPattern=FillPattern.Solid,
          radius=1)}));
end PartialBackground;
