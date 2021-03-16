within NHES.Media.Solids;
package UO2 "UO2: Thermodynamic properties for unirradiated uranium dioxide"

/*
UO2 Thermal conductivity, density, and heat capacity

ORNL. Thermophysical Properties of MOX and UO2 Fuels Including the
Effects of Irradiaiton. ORNL/TM-2000/351. 1996.

k => pg 25 eq. 6.2
rho => pg 9-10 eq. N/A
cp => pg 18 eq 4.2
*/
 // assert(Tempe>273, "Fuel element temperature must be > 273K", AssertionLevel.warning);
 // assert(Tempe<3120, "Fuel element has melted (T>3120)",AssertionLevel.warning);

extends NHES.Media.Interfaces.PartialAlloy(materialName="UO2",
      materialDescription="Uranium Dioxide");

redeclare function extends density "Density as a function of temperature"
protected
  Density rho_273 = 10970 "Density of 100% UO2";
  Real rho_CMfac = 0.95 "Density correction factor for commercial fuel density";
algorithm
if T <923 then
  rho := rho_CMfac*rho_273*(9.9734e-1 + 9.802e-6*T - 2.705e-10*T^2
                             + 4.391e-13*T^3)^(-3);
else
  rho := rho_CMfac*rho_273*(9.9672e-1 + 1.179e-5*T - 2.429e-9*T^2
                              + 1.219e-12*T^3)^(-3);
end if;
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
algorithm
   lambda := 115.8/(7.5408 + 17.692*(T/1000) + 3.6142*(T/1000)^2)
         + 7410.5*(T/1000)^(-5/2)*exp(-16.35/(T/1000));
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
protected
  Real c1(unit="J/(kg.K)") = 302.27;
  Real c2(unit="J/(kg.K2)") = 8.463e-3;
  Real c3(unit="J/kg") = 8.741e7;
  Real theta(unit="K") = 548.68;
  Real Ea(unit="K") = 18531.7;
algorithm
  cp := c1*(theta/T)^2*exp(theta/T)/(exp(theta/T)-1)^2
       + 2*c2*T + c3*Ea*exp(-Ea/T)/T^2;
end specificHeatCapacity;

redeclare function extends linearExpansionCoefficient
  "Linear expansion coefficient as a function of temperature"
algorithm
  alpha := 0;
end linearExpansionCoefficient;
end UO2;
