within NHES.SIunits.Conversions;
function from_psi "Convert pressure from psi to Pa"
  extends Modelica.Units.Icons.Conversion;

  input Real psi "psi value";
  output SI.Pressure pa "Pa value";
algorithm
  pa := psi*6894.75728;
end from_psi;
