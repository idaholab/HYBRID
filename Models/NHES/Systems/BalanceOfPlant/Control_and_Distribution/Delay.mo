within NHES.Systems.BalanceOfPlant.Control_and_Distribution;
block Delay "Delays an input or output signal"
  parameter Modelica.Units.SI.Time Ti=1;

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{100,-14},{128,14}}), iconTransformation(extent={{100,-14},{128,
            14}})));
initial equation
  y=u;
equation
  der(y)*Ti = u-y;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Delay;
