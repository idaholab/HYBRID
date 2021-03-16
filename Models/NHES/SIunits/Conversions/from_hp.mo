within NHES.SIunits.Conversions;
function from_hp "Convert power from horsepower to Watts"
  extends Modelica.Units.Icons.Conversion;

  input Real hp "hp value";
  output SI.Power W "W value";
algorithm
  W := hp*745.7;
end from_hp;
