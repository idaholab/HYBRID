within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
block MinMaxFilter "Delays an input or output signal"
  parameter Real min = 0 "Minimum output value";
  parameter Real max = 1 "Maximum output value";

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{100,-14},{128,14}}), iconTransformation(extent={{100,-14},{128,
            14}})));
initial equation
y=u;
equation
  if
    (y <= min and u <= min) then
    der(y)=0;
  elseif
        (u >=max and y >= max) then
    der(y) = 0;
  else
    der(y) = u-y;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The Min/Max filter uses a derivative term to exponentially approach a value. Once the minimum or maximum value is reached, then the derivative of the output is set to 0. </p>
</html>"));
end MinMaxFilter;
