within NHES.Media.Solids;
package SS304 "SS304: Stainless steel 304"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="SS3104",
      materialDescription="Stainless Steel 304");

    // Fits are taken from aksteel.com for 304 steel.

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 8030 "Constant density (kg/m3)";
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
end SS304;
