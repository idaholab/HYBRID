within NHES.SIunits.Conversions;
function from_lbmhr "Convert mass flow rate from lbm/hr to kg/s"
  extends Modelica.Units.Icons.Conversion;

  input Real lbmhr "lbm/hr value";
  output SI.MassFlowRate kgs "kg/s value";
algorithm
  kgs :=Conversions.from_lbm(lbmhr)/3600;
end from_lbmhr;
