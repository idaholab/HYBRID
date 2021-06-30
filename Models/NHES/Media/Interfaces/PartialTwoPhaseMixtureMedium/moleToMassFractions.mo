within NHES.Media.Interfaces.PartialTwoPhaseMixtureMedium;
function moleToMassFractions
  "Return mass fractions X from mole fractions"
  extends Modelica.Icons.Function;
  input MoleFraction moleFractions[:] "Mole fractions of mixture";
  input MolarMass[:] MMX "Molar masses of components";
  output Modelica.Units.SI.MassFraction X[size(moleFractions, 1)]
    "Mass fractions of gas mixture";
protected
  MolarMass Mmix=moleFractions*MMX "Molar mass of mixture";
algorithm
  for i in 1:size(moleFractions, 1) loop
    X[i] := moleFractions[i]*MMX[i]/Mmix;
  end for;
  annotation (smoothOrder=5);
end moleToMassFractions;
