within NHES.Media.Solids;
package Helium "Helium: pseudo-Helium gas/solid"

/*
Helium Thermal capacity, density, and specific heat.

The properties are just rough estimates (placeholders) for now.

IAEA. Thermophysical Properties of Materials for Nuclear Engineering:
A Tutorial and Collection of Data. IAEA-THPH. ISBN 978-92-0-106508-7. 2008

Taken at pressure = 1e5 Pa
k => regression from pg 57 table (units in table are wrong, off by 1000)
rho => regression from pg 57 table
cp => pg 56
*/

extends NHES.Media.Interfaces.PartialAlloy(materialName="Helium",
      materialDescription="Helium like solid");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho :=0.165 - 4.3e-4*T + 6.7e-7*T^2 - 5.5e-10*T^3 + 1.7e-13*T^4
    "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda :=0.1449 + 3e-4*T - 3e-8*T^2 - 9e-11*T^3 + 5e-14*T^4;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp :=5193;
end specificHeatCapacity;

redeclare function extends linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
algorithm
  alpha := 0;
end linearExpansionCoefficient;
end Helium;
