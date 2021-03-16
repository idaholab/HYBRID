within NHES.Media.Solids;
package HastelloyN "AlloyN: Material properties for Hastelloy N (R)"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="Hastelloy N",
      materialDescription="Alloy N material");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 8860 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
  lambda := 1.4642857143e-5*T^2 - 3.20821428571e-4*T + 9.766543865178583;
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := 4.614019521e-4*T^2 - 0.3402230706309*T + 488.9450478878976;
end specificHeatCapacity;
end HastelloyN;
