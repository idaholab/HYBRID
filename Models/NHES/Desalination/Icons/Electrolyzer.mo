within NHES.Desalination.Icons;
partial model Electrolyzer

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={      Rectangle(
            extent={{-63.8816,56.0534},{-94.9939,44.7382}},
            lineColor={170,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            rotation=45,
            fillColor={240,0,0},
            origin={140.807,-2.46462}),
                Rectangle(
            extent={{-109.583,99.6675},{-139.28,75.6255}},
            fillPattern=FillPattern.HorizontalCylinder,
            rotation=45,
            fillColor={0,0,240},
            origin={193.961,49.0104},
          pattern=LinePattern.None),        Polygon(
            points={{-10,64},{-10,56},{-6,52},{4,42},{4,-52},{-2,-52},{10,
              -64},{10,44},{-10,64}},
            smooth=Smooth.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0},
          origin={0,-34},
          rotation=-90),       Line(
            points={{0,47},{0,-47}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
          origin={-40,-5},
          rotation=0),           Polygon(
            points={{-10,64},{10,44},{10,-64},{-10,-44},{-10,64}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
          origin={0,50},
          rotation=-90),              Rectangle(
            extent={{-8,47},{8,-47}},
            lineColor={179,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={240,0,0},
          origin={-5,-30},
          rotation=-90),     Rectangle(
            extent={{-10,54},{10,-54}},
            lineColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={135,135,135},
          origin={-10,-54},
          rotation=-90),              Rectangle(extent={{-10,54},{10,-54}},
          lineColor={0,0,0},
          origin={-10,-54},
          rotation=-90),     Rectangle(
            extent={{-10,54},{10,-54}},
            lineColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={135,135,135},
          radius=0,
          origin={-10,30},
          rotation=-90),             Rectangle(extent={{-10,54},{10,-54}},
          lineColor={0,0,0},
          origin={-10,30},
          rotation=-90),        Polygon(
            points={{0,10},{-20,10},{0,-10},{20,-10},{0,10}},
            lineColor={0,0,0},
            smooth=Smooth.None,
          origin={54,-44},
          rotation=-90),        Text(
            extent={{-100,-20},{100,20}},
            textString="%name",
            lineColor={0,0,255},
          origin={4,80},
          rotation=0),                     Rectangle(
            extent={{-54.176,45.8261},{-86.7031,33.0985}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            rotation=45,
            fillColor={255,255,255},
            origin={126.712,19.9043}),Rectangle(
            extent={{-9,47},{9,-47}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={255,255,255},
          origin={-5,-9},
          rotation=-90),        Polygon(
            points={{56,-11},{56,-1},{31,1.08233e-017},{19,12},{-37,12},{
              -37,-4.51505e-017},{-57,6.24703e-017},{-57,4},{56,-11}},
            smooth=Smooth.None,
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255},
            pattern=LinePattern.None,
          origin={68,13},
          rotation=90),         Polygon(
            points={{0,-10},{-20,10},{0,10},{20,-10},{0,-10}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
          origin={54,40},
          rotation=-90),     Line(
            points={{6,6},{-6,-6}},
            color={0,0,0},
            smooth=Smooth.None,
          origin={-58,-38},
          rotation=0),          Polygon(
            points={{0,-10},{-20,10},{0,10},{20,-10},{0,-10}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
          origin={54,-44},
          rotation=-90),              Rectangle(
            extent={{-8,47},{8,-47}},
            lineColor={0,0,170},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,240},
          origin={-5,12},
          rotation=-90), Line(
            points={{-76,-52},{18,-52}},
            color={0,0,0},
            smooth=Smooth.None,
          origin={24,14},
          rotation=0),   Line(
            points={{14,-38},{0,-52}},
            color={0,0,0},
            smooth=Smooth.None,
          origin={42,14},
          rotation=0),   Line(
            points={{8,-52},{0,-52}},
            color={0,0,0},
            smooth=Smooth.None,
          origin={56,28},
          rotation=0),                      Ellipse(
            extent={{-4,2},{4,-2}},
            lineColor={135,135,135},
            fillColor={0,0,240},
            fillPattern=FillPattern.Sphere,
          origin={-58,30},
          rotation=0),         Ellipse(
            extent={{-4,2},{4,-2}},
            lineColor={135,135,135},
            fillColor={250,0,0},
            fillPattern=FillPattern.Sphere,
          origin={-58,-54},
          rotation=0),                      Ellipse(
            extent={{-4,2},{4,-2}},
            lineColor={135,135,135},
            fillColor={0,0,240},
            fillPattern=FillPattern.Sphere,
          origin={58,46},
          rotation=0),         Ellipse(
            extent={{-4,2},{4,-2}},
            lineColor={135,135,135},
            fillColor={250,0,0},
            fillPattern=FillPattern.Sphere,
          origin={58,-38},
          rotation=0),
        Line(
          points={{34,30},{-48,30}},
          color={0,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{34,-54},{-48,-54}},
          color={0,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(points={{-52,20},{-52,-38},{-52,-38}}, color={0,0,0}),
        Line(points={{42,20},{42,-38},{42,-38}}, color={0,0,0}),
        Line(points={{56,32},{56,-24},{56,-24}}, color={0,0,0}),
        Rectangle(
          extent={{-52,4},{42,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Polygon(
          points={{42,4},{42,0},{56,14},{56,18},{42,4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Rectangle(
          extent={{-52,-18},{42,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Polygon(
          points={{42,-18},{42,-22},{56,-8},{56,-4},{42,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0})}),   Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.1)));
end Electrolyzer;
