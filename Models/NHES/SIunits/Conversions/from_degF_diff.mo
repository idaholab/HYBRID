within NHES.SIunits.Conversions;
function from_degF_diff
  "Convert from temperature difference in degFahrenheit to Kelvin"
  extends Modelica.Units.Icons.Conversion;
  input Real degF_diff
    "Fahrenheit value";
  output SI.Temperature Kelvin "Kelvin value";
algorithm
  Kelvin := degF_diff*(5/9);
  annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}})));
end from_degF_diff;
