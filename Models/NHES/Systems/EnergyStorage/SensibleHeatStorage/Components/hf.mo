within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
function hf "Function to Calculate saturated liquid enthalpy"
  input Real P; //Pressure in psia
  output Real hf; // Enthalpy in Btu/lbm

protected
  parameter Real a[8]={-158.951133,0.1064128,
                                            -5.990278e-5,3.9394998e-8,
     -1.3013275e-11,1.7895135e-15,227.89663,0.1464544};
algorithm
  hf:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
end hf;
