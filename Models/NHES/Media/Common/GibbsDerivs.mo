within NHES.Media.Common;
record GibbsDerivs
  "Derivatives of Gibbs-function w.r.t. pressure and temperature"
  extends Modelica.Icons.Record;
  AbsolutePressure p(min=100, max=100e6) "Pressure";
  Temperature T(min=268, max=573.15) "Temperature";
  MassFraction X[2] "Mass Fraction";
  SpecificHeatCapacity R_s "Gas constant";
  MolarMass MM "Molar mass";
  SpecificGibbsFreeEnergy g "Gibbs-function";
  SpecificVolume dgdp;
  Real dgdpdT(unit="m3/(kg.K)");
  SpecificVolume dgdpdX;
  SpecificEntropy dgdT;
  Real d2gdT2(unit="J/(kg.K2)");
  SpecificEntropy dgdTdX;
  SpecificGibbsFreeEnergy dgdX;
  SpecificEntropy dudT;
  SpecificEnthalpy dhdX;
  Real dhdp(unit="J/(kg.Pa)");
end GibbsDerivs;
