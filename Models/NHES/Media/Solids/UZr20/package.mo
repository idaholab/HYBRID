within NHES.Media.Solids;
package UZr20 "UZr solid metal fuel properties"
extends NHES.Media.Interfaces.PartialAlloy(materialName="GenericSolid",
      materialDescription="A generic constant property solid");

redeclare function extends density "Density as a function of temperature"

algorithm
  rho := 15.7 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"

algorithm
  lambda := -1.763+0.04871*T-1.33e-5*T*T;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"

algorithm
  cp := 89.0913+0.174*T-0.00021267*T*T+0.00000021656*T*T*T;
end specificHeatCapacity;
// heat capacity value taken from "Heat Capacity Measurements of U_80Zr_20 and U_80Mo_20 Alloys from Room Temperature to 1300 K" by Matsui, Natsum, Naito in Journal of Nuclear Materials 167 (1989) pp 152-159
//Note that only the sub-transition temperatures are used for this correlation. Technically, it will be wildly innaccurate at temperatures above 850
redeclare function extends linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
algorithm
  alpha := -0.73/T+0.003489-0.000005154*T+0.00000000439*T^2;
end linearExpansionCoefficient;
end UZr20;
