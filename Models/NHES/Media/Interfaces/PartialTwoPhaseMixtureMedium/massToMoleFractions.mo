within NHES.Media.Interfaces.PartialTwoPhaseMixtureMedium;
function massToMoleFractions
  "Return mole fractions from mass fractions X"
  extends Modelica.Icons.Function;
  input MassFraction X[:] "Mass fractions of mixture";
  input MolarMass[:] MMX "Molar masses of components";
  output MoleFraction moleFractions[size(X, 1)]
    "Mole fractions of gas mixture";
protected
  Real invMMX[size(X, 1)] "Inverses of molar weights";
  MolarMass Mmix "Molar mass of mixture";
algorithm
  for i in 1:size(X, 1) loop
    invMMX[i] := 1/MMX[i];
  end for;
  Mmix := 1/(X*invMMX);
  for i in 1:size(X, 1) loop
    moleFractions[i] := Mmix*X[i]/MMX[i];
  end for;
  annotation (smoothOrder=5);
end massToMoleFractions;
