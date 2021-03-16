within NHES.Media.Solids;
package ZrNb_E125 "ZircAlloy: Thermodynamic properties for ZrNb_E125"

/*
Zirconium-niobium (2.5%) alloy type N-2.5 (E-125).

IAEA. Thermophysical Properties of Materials for Nuclear Engineering:
A Tutorial and Collection of Data. IAEA-THPH. ISBN 978-92-0-106508-7. 2008

k => pg. 158 eq. 6.22
rho => pg. 158 eq. 6.20
cp => pg 158 eq. 6.21
*/

  // assert(Tempe >= 300, "No ZrNb_E125 data below 300K",AssertionLevel.warning);
  // assert(Tempe <= 1100, "No ZrNb_E125 data above 1100K",AssertionLevel.warning);

extends NHES.Media.Interfaces.PartialAlloy(materialName="ZircAlloy",
      materialDescription="ZrNb_E125");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 6657 - 0.2861*T;
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda := 14 + 0.0115*T;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := 221 + 0.172*T - 5.87e-5*T^2;
end specificHeatCapacity;

redeclare function extends linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
algorithm
  alpha := 0;
end linearExpansionCoefficient;
end ZrNb_E125;
