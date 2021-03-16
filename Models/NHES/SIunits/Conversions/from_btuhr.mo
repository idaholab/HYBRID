within NHES.SIunits.Conversions;
function from_btuhr "Convert power from btu/hr to W"
  extends Modelica.Units.Icons.Conversion;

  input Real btuhr "btu/hr value";
  output SI.HeatFlowRate W "W value";
algorithm
  W := btuhr*1055.0558526/3600;
end from_btuhr;
