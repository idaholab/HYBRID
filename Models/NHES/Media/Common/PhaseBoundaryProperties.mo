within NHES.Media.Common;
record PhaseBoundaryProperties
  "Thermodynamic base properties on the phase boundary"
  extends Modelica.Icons.Record;
  Density d "Density";
  SpecificEnthalpy h "Specific enthalpy";
  SpecificEnergy u "Inner energy";
  SpecificEntropy s "Specific entropy";
  SpecificHeatCapacity cp
    "Heat capacity at constant pressure";
  SpecificHeatCapacity cv
    "Heat capacity at constant volume";
  DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
  DerPressureByDensity pd "Derivative of pressure w.r.t. density";
end PhaseBoundaryProperties;
