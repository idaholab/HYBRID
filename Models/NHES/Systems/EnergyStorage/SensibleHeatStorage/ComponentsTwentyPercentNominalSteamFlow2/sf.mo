within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
function sf "Function to calculate Saturated Vapor Entropy"

  input Real P;
  output Real sf;

  parameter Real a[8]={-0.5864158,8.7429585e-5,-6.0398601e-8,4.022512e-11,
     -1.3327989e-14,1.8065282e-18,0.71821152,0.08297097};

algorithm
  sf:=a[1]+a[2]*P+a[3]*P^2+a[4]*P^3+a[5]*P^4 +a[6]*P^5+a[7]*P^a[8];

end sf;
