within NHES.Media.Interfaces.Types;
record SaturationProperties
  "Saturation properties of two phase medium"
  extends Modelica.Icons.Record;
  AbsolutePressure psat "Saturation pressure";
  Temperature Tsat "Saturation temperature";
  MassFraction[2] Xsat "Mass Fraction";
end SaturationProperties;
