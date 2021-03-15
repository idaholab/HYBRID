within NHES.SIunits.Conversions;
function from_inHg "Convert pressure from inHg to Pa"
  extends Modelica.Units.Icons.Conversion;

  input Real inHg "inHg value";
  output SI.Pressure pa "Pa value";
algorithm
  pa := inHg*3386.389;
end from_inHg;
