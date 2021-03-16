within NHES.SIunits.Conversions;
function from_gpm
  "Convert volume flow rate from US fluid gallons/minute to m^3/s"
  extends Modelica.Units.Icons.Conversion;

  input Real gpm "gpm value";
  output SI.SpecificEnergy m3s "m3s value";
algorithm
  m3s := gpm/(264.172052*60);
end from_gpm;
