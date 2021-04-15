within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
function sfg
  "Function to compute the latent entropy at a given pressure"

input Real P; //Pressure in psia
output Real sfg;

algorithm

  sfg :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.sg(
    P) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.sf(
    P);

end sfg;
