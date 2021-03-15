within NHES.Electrolysis.Utilities;
function moleToMassFractions "Return mass fractions X from mole fractions"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.MoleFraction moleFractions[:]
    "Mole fractions of mixture";
  input Modelica.Media.Interfaces.Types.MolarMass[:] MMX
    "Molar masses of components";
  output Modelica.Units.SI.MassFraction X[size(moleFractions, 1)]
    "Mass fractions of gas mixture";
protected
  Modelica.Media.Interfaces.Types.MolarMass Mmix=moleFractions*MMX
    "Molar mass of mixture";
algorithm
  for i in 1:size(moleFractions, 1) loop
    X[i] := moleFractions[i]*MMX[i]/Mmix;
  end for;
  annotation (smoothOrder=5, Documentation(info="<html>
</html>"));
end moleToMassFractions;
