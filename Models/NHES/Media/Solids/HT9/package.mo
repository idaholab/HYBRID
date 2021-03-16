within NHES.Media.Solids;
package HT9 "HT9: Material properties for HT9 a series 400 type stainless steel"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="HT9",
      materialDescription="HT9 is similar to a type 400 stainless steel");

    // Fits are taken from aksteel.com for 400 steel. This is close.

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 7470 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda := 17.622 + 2.428e-2*T - 1.696e-5*T^2;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := 460;
end specificHeatCapacity;
end HT9;
