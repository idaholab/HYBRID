within NHES.SIunits.Conversions;
function from_degF "Convert from degFahrenheit to Kelvin"
  extends Modelica.Units.Icons.Conversion;
  input Real degF
    "Fahrenheit value";
  output SI.Temperature Kelvin "Kelvin value";
algorithm
  Kelvin := (degF - 32)*(5/9) + 273.15;
  annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}})));
end from_degF;
