within NHES.SIunits.Conversions;
function from_lbm "Convert mass from lbm to kg"
  extends Modelica.Units.Icons.Conversion;

  input Real lbm "lbm value";
  output SI.Mass kg "kg value";
algorithm
  kg := lbm*0.453592;
end from_lbm;
