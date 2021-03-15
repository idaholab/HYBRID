within NHES.SIunits.Conversions;
function from_inch "Convert length from inch to m"
  extends Modelica.Units.Icons.Conversion;

  input Real inch "inch value";
  output SI.Length m "m value";
algorithm
  m := inch*0.0254;
end from_inch;
