within NHES.Systems.ElectricalGrid.InfiniteGrid;
model Infinite
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
    redeclare Data.Infinite data);

  parameter SI.Frequency f_nominal=60 "Nominal frequency";
  parameter SI.Power Q_nominal=10e10 "Nominal power installed on the network";
  parameter Real droop=0.05 "Network droop";

  Electrical.Grid             grid(
                     n=1,
    f_nominal=f_nominal,
    Q_nominal=Q_nominal,
    droop=droop)
             annotation (Placement(transformation(extent={{-12,-10},{8,10}})));

equation
  connect(grid.ports[1], portElec_a)
    annotation (Line(points={{-12,0},{-100,0}}, color={255,0,0}));
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
          textString="Infinite Grid")}));
end Infinite;
