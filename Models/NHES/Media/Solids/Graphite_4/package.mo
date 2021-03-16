within NHES.Media.Solids;
package Graphite_4 "GRAPHITE: Thermodynamic properties for nuclear graphite at 3-8e25-n/m2 fluence"

extends NHES.Media.Interfaces.PartialAlloy(materialName="Graphite",
      materialDescription="Nuclear-grade graphite");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 1776.66 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda := 29.8193 - 7.56914e-3*T + 1.20901e-6*T^2;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := -143.9883 + 3.6677*T - 0.0022*T^2 + 4.6251e-7*T^3;
end specificHeatCapacity;

redeclare function extends linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
algorithm
  alpha := 0;
end linearExpansionCoefficient;
end Graphite_4;
