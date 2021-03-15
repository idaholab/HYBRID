within NHES.SIunits.Conversions;
function from_feet "Convert length from feet to m"
  extends Modelica.Units.Icons.Conversion;

  input Real feet "ft value";
  output SI.Length m "m value";
algorithm
  m := feet*12*0.0254;
end from_feet;
