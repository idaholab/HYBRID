within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
function uf "function to compute saturated liquid internal energy (Btu/lbm)"
  input Real P;
  output Real uf;

protected
  parameter Real a[8]={-158.61531184,0.10213234,-5.88930771e-5,3.77381711e-8,
     -1.22429068e-11,1.65122388e-15,227.55166589,0.14666680};
algorithm

   uf:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];

end uf;
