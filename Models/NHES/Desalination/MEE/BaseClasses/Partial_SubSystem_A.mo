within NHES.Desalination.MEE.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;

  extends Record_SubSystem_A;

  annotation (
    defaultComponentName="changeMe",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Ellipse(
          extent={{-88,12},{-48,32}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=360,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-88,-28},{-48,-8}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-88,22},{-48,-18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,22},{-48,8}},
          lineColor={164,189,255},
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-54,6},{-50,10}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          closure=EllipseClosure.Chord),
        Ellipse(
          extent={{-88,4},{-82,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-88,22},{-88,-18}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-48,22},{-48,-18}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-74,4},{-66,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-62,4},{-54,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-54,6},{-50,6}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-88,8},{-84,10},{-78,6},{-70,10},{-66,8},{-62,8},{-56,10},{
              -54,6},{-48,8}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Ellipse(
          extent={{-20,12},{20,32}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=360,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-20,-28},{20,-8}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-20,22},{20,-18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,22},{20,8}},
          lineColor={164,189,255},
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,6},{18,10}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          closure=EllipseClosure.Chord),
        Ellipse(
          extent={{-20,4},{-14,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-20,22},{-20,-18}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{20,22},{20,-18}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-6,4},{2,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{6,4},{14,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{14,6},{18,6}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-20,8},{-16,10},{-10,6},{-2,10},{2,8},{6,8},{12,10},{14,6},{
              20,8}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Ellipse(
          extent={{48,12},{88,32}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=360,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{48,-28},{88,-8}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{48,22},{88,-18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{48,22},{88,8}},
          lineColor={164,189,255},
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{82,6},{86,10}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          closure=EllipseClosure.Chord),
        Ellipse(
          extent={{48,4},{54,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{48,22},{48,-18}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{88,22},{88,-18}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{62,4},{70,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{74,4},{82,10}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{82,6},{86,6}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{48,8},{52,10},{58,6},{66,10},{70,8},{74,8},{80,10},{82,6},{
              88,8}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{94,54},{-68,54},{-68,40}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{68,54},{68,40}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{0,54},{0,40}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{-48,16},{-34,16},{-34,-4},{-22,-4}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{20,14},{34,14},{34,-6},{46,-6}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Open}),
        Text(
          extent={{-76,28},{-58,10}},
          textColor={0,0,0},
          textString="1"),
        Text(
          extent={{-10,28},{8,10}},
          textColor={0,0,0},
          textString="2"),
        Text(
          extent={{60,28},{78,10}},
          textColor={0,0,0},
          textString="nE"),       Text(
          extent={{-94,94},{94,32}},
          textColor={28,108,200},
          textString="%data.nE Effect MEE
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
