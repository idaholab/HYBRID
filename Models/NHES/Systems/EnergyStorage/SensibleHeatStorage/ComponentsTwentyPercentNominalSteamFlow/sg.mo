within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function sg "Function to computer saturated vapor entropy"

  input Real P;
  output Real sg;

  parameter Real a[8]={4.9191672,1.58394e-4,-2.7692662e-7,2.001747e-10,
     -6.8316294e-14,8.5122981e-18,-2.934533,0.02760756};

algorithm
  sg:=a[1]+a[2]*P+a[3]*P^2+a[4]*P^3+a[5]*P^4 +a[6]*P^5+a[7]*P^a[8];

end sg;
