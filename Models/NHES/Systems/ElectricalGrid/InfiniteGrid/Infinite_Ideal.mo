within NHES.Systems.ElectricalGrid.InfiniteGrid;
model Infinite_Ideal
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
    redeclare Data.Infinite data);

  parameter SI.Frequency f=60 "Grid frequency";

  TRANSFORM.Electrical.Sources.FrequencySource boundary(f=f)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
equation
  connect(boundary.port, portElec_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={255,0,0}));
annotation(defaultComponentName="EG", Icon(graphics={Line(
          points={{-56,-6},{-58,0},{-54,10},{-42,18},{-20,18},{-4,10},{0,0},{4,-10},
              {20,-18},{38,-18},{54,-12},{58,0},{54,10},{38,18},{20,18},{4,10},{
              0,0},{-4,-10},{-20,-18},{-40,-18},{-54,-12},{-58,0},{-56,6}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=0.5),
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Infinite Grid: Ideal")}));
end Infinite_Ideal;
