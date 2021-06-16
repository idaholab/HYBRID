within NHES.Media.Common;
record SaturationProperties "Properties in the two phase region"
  extends Modelica.Icons.Record;
  Temperature T "Temperature";
  Density d "Density";
  AbsolutePressure p "Pressure";
  MassFraction[:] X "Component mass fractions";
  SpecificEnergy u "Specific inner energy";
  SpecificEnthalpy h "Specific enthalpy";
  SpecificEntropy s "Specific entropy";
  SpecificHeatCapacity cp
    "Heat capacity at constant pressure";
  SpecificHeatCapacity cv
    "Heat capacity at constant volume";
  //Modelica.Units.SI.SpecificHeatCapacity R "Gas constant";
  RatioOfSpecificHeatCapacities kappa
    "Isentropic expansion coefficient";
  PhaseBoundaryProperties liq
    "Thermodynamic base properties on the boiling curve";
  PhaseBoundaryProperties vap
    "Thermodynamic base properties on the dew curve";
  Real dpT(unit="Pa/K")
    "Derivative of saturation pressure w.r.t. temperature";
  MassFraction x "Vapour mass fraction";
end SaturationProperties;
