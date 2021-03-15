within NHES.SIunits.Conversions;
function from_btu "Convert energy from btu to J"
  extends Modelica.Units.Icons.Conversion;

  input Real btu "btu value";
  output SI.SpecificEnergy J "J value";
algorithm
  J := btu*1055.0558526;
end from_btu;
