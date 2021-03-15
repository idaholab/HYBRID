within NHES.Electrolysis.Icons;
partial model FlashDrum

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(extent={{-80,-90},{80,-30}}, lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,60},{80,-60}}, lineColor={28,108,200},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Ellipse(extent={{-80,30},{80,90}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,60},{80,-30}}, lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(extent={{-80,60},{80,50}},  lineColor={0,0,0},
          fillPattern=FillPattern.CrossDiag,
          fillColor={255,255,255}),
        Line(
          points={{-60,-28},{-60,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-40,-28},{-40,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-20,-28},{-20,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{0,-28},{0,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{20,-28},{20,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{40,-28},{40,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{60,-28},{60,-12}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-60,28},{-60,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-40,28},{-40,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-20,28},{-20,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{0,28},{0,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{20,28},{20,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{40,28},{40,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{60,28},{60,12}},
          color={255,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-50,38},{-50,50}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-30,38},{-30,50}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-10,38},{-10,50}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{10,38},{10,50}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{30,38},{30,50}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{50,38},{50,50}},
          color={0,0,255},
          arrow={Arrow.Open,Arrow.None})}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FlashDrum;
