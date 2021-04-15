within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
function Tsat "Function to compute saturation temperature"
  input Real P;//Pressure in psia
  output Real Tsat; //Saturation temperature in F

protected
  parameter Real a[8]={-127.45099,0.0736883,-5.127918e-5,2.941807e-8,
     -8.968781e-12,1.066619e-15,228.4795,0.1463839};
algorithm
  Tsat:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
end Tsat;
