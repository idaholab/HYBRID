within NHES.Desalination.Media.BrineProp;
function Xi2X "calculates the full mass vector X from Xi"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.MassFraction Xi[:] "Mass fractions of mixture";
  output Modelica.Units.SI.MassFraction X[size(Xi, 1) + 1]
    "Mass fractions of mixture";
algorithm
  X := cat(1, Xi, {1 - sum(Xi)});
end Xi2X;
