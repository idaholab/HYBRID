within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
block Timer "Delays a real signal until start time is established. Output=Input*multiplication_factor, which can be initially set to anything. Nominally, factor should be between 0 and 1"
  parameter Modelica.Units.SI.Time Start_Time=2700 "Time to allow multiplication rate change";
  parameter Real init_mult=0 "Initial multiplication rate";
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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The timer block is an initialization block. The output is equal to a value multiplying the input. The multiplier is initialized after some start time. </p>
</html>"));
end Timer;
