within NHES.Desalination.Media.BrineProp.Utilities;
function massToMoleFractions
  //  extends Modelica.Media.Interfaces.PartialMixtureMedium.massToMoleFractions;
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.MassFraction X[:] "Mass fractions of mixture";
  input Modelica.Units.SI.MolarMass MMX[:] "molar masses of components";
  output Modelica.Units.SI.MoleFraction molefractions[size(X, 1)] "Molalities";
  output Types.Molality molalities[size(X, 1)] "Molalities moles/m_H2O";
protected
  Real n_total;
  Integer n = size(X, 1);
algorithm
  assert(n == size(MMX, 1), "Inconsistent vectors for mass fraction(" + String(n) + ") and molar masses(" + String(size(MMX, 1)) + ")");
  // assert(min(MMX)>0, "Invalid molar mass vectors");
  // print(String(size(X,1))+" "+String(X[end]));
  //  printVector(MM);
  for i in 1:n loop
    molalities[i] := if X[end] > 0 then X[i] / (MMX[i] * X[end]) else -1;
  end for;
  // print("MMX["+String(i)+"]="+String(MMX[i]));
  //   assert(MMX[i]>0, "Invalid molar mass: "+String(MMX[i])+"");
  //    n[i] := X[i]/MMX[i];
  n_total := sum(molalities);
  for i in 1:n loop
    molefractions[i] := molalities[i] / n_total;
  end for;
  annotation(smoothOrder = 5);
end massToMoleFractions;
