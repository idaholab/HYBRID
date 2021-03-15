within NHES.Media.Solids;
package GenericSolid "GenericSolid: Constant, user specified, thermodynamic properties for a generic solid"
extends NHES.Media.Interfaces.PartialAlloy(materialName="GenericSolid",
      materialDescription="A generic constant property solid");

redeclare function extends density "Density as a function of temperature"
input Density rho_const=7000 "Constant density";
algorithm
  rho := rho_const "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
input ThermalConductivity k_const=28.5 "Constant thermal conductivity";
algorithm
  lambda := k_const;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
input SpecificHeatCapacity cp_const=680 "Constant specific heat capacity";
algorithm
  cp := cp_const;
end specificHeatCapacity;

redeclare function extends linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
algorithm
  alpha := 0;
end linearExpansionCoefficient;
end GenericSolid;
