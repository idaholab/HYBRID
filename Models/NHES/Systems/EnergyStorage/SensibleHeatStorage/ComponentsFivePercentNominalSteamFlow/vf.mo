within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
function vf "Function to compute saturated liquid specific volume"
   input Real P; //Pressure in psia
  output Real vf; //Specific Volume in ft^3/lbm

protected
  parameter Real a[8]={0.0158605,
                                1.436698e-6,-6.546245e-10,1.2621567e-12,
     -6.106028e-16,1.17416e-19,3.004294e-4,0.3809203};
algorithm
  vf:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
end vf;
