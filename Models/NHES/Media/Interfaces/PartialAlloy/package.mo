within NHES.Media.Interfaces;
partial package PartialAlloy "partial solid alloy properties"

extends Modelica.Icons.MaterialPropertiesPackage;

// Constants to be set in Material
constant String materialName "Name of the material";
constant String materialDescription "Description of the material";

// Material properties depending on the material state

replaceable partial function density "Density as a function of temperature"
  input Temperature T "Temperature (K)";
  output Density rho "Density (kg/m3)";
end density;

replaceable partial function thermalConductivity
  "Thermal conductivity as a function of temperature"
  input Temperature T "Temperature (K)";
  output ThermalConductivity lambda "Thermal conductivity (W/mK)";
end thermalConductivity;

replaceable partial function specificHeatCapacity
  "Specific heat capacity as a function of temperature"
  input Temperature T "Temperature (K)";
  output SpecificHeatCapacity cp "Specific heat capacity (J/kgK)";
end specificHeatCapacity;

replaceable partial function linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
  input Temperature T "Temperature (K)";
  output LinearExpansionCoefficient alpha
    "Linear expansion coefficient of the material (1/K)";
end linearExpansionCoefficient;

replaceable partial function emissivity "Emissivity"
  input Temperature T "Temperature (K)";
  output Emissivity eps "Emissivity";
end emissivity;
end PartialAlloy;
