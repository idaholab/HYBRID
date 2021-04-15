within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
function sfg
  "Function to compute the latent entropy at a given pressure"

input Real P; //Pressure in psia
output Real sfg;

algorithm

  sfg :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.sg(
    P) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.sf(
    P);

end sfg;
