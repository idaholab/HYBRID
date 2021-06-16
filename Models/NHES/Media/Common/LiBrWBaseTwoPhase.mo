within NHES.Media.Common;
record LiBrWBaseTwoPhase
  extends Modelica.Icons.Record;
  Integer phase(start=0)
    "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  Integer region(min=1, max=7);
  AbsolutePressure p "Pressure";
  Temperature T "Temperature";
  MassFraction X[2];
  SpecificEnthalpy h "Specific enthalpy";
  SpecificHeatCapacity R_s "Gas constant";
  SpecificHeatCapacity cp "Specific heat capacity";
  SpecificHeatCapacity cv "Specific heat capacity";
  Density rho "Density";
  SpecificEntropy s "Specific entropy";
  DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
  DerPressureByDensity pd "Derivative of pressure w.r.t. density";
  Real vt "Derivative of specific volume w.r.t. temperature";
  Real vp "Derivative of specific volume w.r.t. pressure";
  Real vx "Derivative of specific volume w.r.t. mass fraction of LiBr";
  Real hp "Derivative of specific enthalpy w.r.t. pressure";
  Real hx "Derivative of specific enthalpy w.r.t. mass fraction of LiBr";
  Real sx "Derivative of specific entropy w.r.t. mass fraction of LiBr";
  Real tp "Derivative of temperature w.r.t. pressure";
  Real th "Derivative of temperature w.r.t. specific enthalpy";
  Real tx "Derivative of temperature w.r.t. mass fraction of LiBr";
  Real x "Dryness fraction";
  Real dpT "dp/dT derivative of saturation curve";
end LiBrWBaseTwoPhase;
