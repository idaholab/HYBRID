within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function sfg
  "Function to compute the latent entropy at a given pressure"

input Real P; //Pressure in psia
output Real sfg;

algorithm

  sfg :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.sg(
    P) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.sf(
    P);

end sfg;
