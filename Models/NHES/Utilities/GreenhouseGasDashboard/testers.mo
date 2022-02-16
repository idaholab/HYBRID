within NHES.Utilities.GreenhouseGasDashboard;
model testers
  displayCO2 display(val=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TRANSFORM.Utilities.Visualizers.displayReal display1(val=20)
    annotation (Placement(transformation(extent={{-10,32},{10,52}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testers;
