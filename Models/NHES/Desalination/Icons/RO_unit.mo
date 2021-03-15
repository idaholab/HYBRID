within NHES.Desalination.Icons;
model RO_unit

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,80},{100,-100}},
          fillColor={170,213,255},
          fillPattern=FillPattern.VerticalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,255}),
        Rectangle(
          extent={{-100,80},{100,-30}},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,-30},{100,-40}},
          fillPattern=FillPattern.CrossDiag,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));

end RO_unit;
