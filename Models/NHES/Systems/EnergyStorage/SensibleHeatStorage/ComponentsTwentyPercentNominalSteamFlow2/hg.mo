within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
function hg "Function to compute saturated vapor enthalpy"
  input Real P; //Pressure in psia
  output Real hg; //enthalpy in Btu/lbm

protected
  parameter Real a[8]={982.80863,-0.0693143,
                                           1.042881e-5,-1.091194e-8,
     4.079445e-12,-8.0123869e-16,123.10181,0.1172116};
algorithm

hg:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
annotation(derivative=dhg);
end hg;
