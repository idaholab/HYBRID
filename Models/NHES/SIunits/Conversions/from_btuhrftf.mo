within NHES.SIunits.Conversions;
function from_btuhrftf
  "Convert thermal conductivity from btu/(hr*ft*F) to W/(m*K)"
  extends Modelica.Units.Icons.Conversion;

  input Real btuhrftf "btu/(hr*ft*F) value";
  output SI.ThermalConductivity WmK "W/(m*K) value";
algorithm
  WmK := btuhrftf*1.7295772056;
end from_btuhrftf;
