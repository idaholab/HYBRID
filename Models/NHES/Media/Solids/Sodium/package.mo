within NHES.Media.Solids;
package Sodium "Liquid Sodium: thermal properties of liquid sodium"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="Sodium",
      materialDescription="Liquid Sodium");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 791 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda := 58.41;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := 1251;
end specificHeatCapacity;
end Sodium;
