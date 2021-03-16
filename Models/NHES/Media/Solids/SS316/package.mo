within NHES.Media.Solids;
package SS316 "SS316: Stainless steel 316"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="SS316",
      materialDescription="Stainless Steel 316");

    // Fits are taken from aksteel.com for 316 steel.

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 7990 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda := 11.34905 + 0.013*T;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := 500;
end specificHeatCapacity;
end SS316;
