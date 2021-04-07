within NHES.Systems.BalanceOfPlant.Control_and_Distribution;
block Timer "Delays an input or output signal"
  parameter Modelica.Units.SI.Time Start_Time=2700;
  parameter Real init_mult=0;
  Real mult;
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{100,-14},{128,14}}), iconTransformation(extent={{100,-14},{128,
            14}})));
initial equation
mult=init_mult;
equation
  if
    (time < Start_Time) then
    der(mult) = 0;
  else
    der(mult) = 1-mult;
  end if;
  y=mult*u;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Timer;
