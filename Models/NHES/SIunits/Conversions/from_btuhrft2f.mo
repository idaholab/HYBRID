within NHES.SIunits.Conversions;
function from_btuhrft2f
  "Convert heat transfer coefficient from btu/(hr*ft^2*F) to W/(m^2*K)"
  extends Modelica.Units.Icons.Conversion;

  input Real btuhrft2f "btu/(hr*ft^2*F) value";
  output SI.CoefficientOfHeatTransfer Wm2K "W/(m^2*K) value";
algorithm
  Wm2K := btuhrft2f*5.678263398;
end from_btuhrft2f;
