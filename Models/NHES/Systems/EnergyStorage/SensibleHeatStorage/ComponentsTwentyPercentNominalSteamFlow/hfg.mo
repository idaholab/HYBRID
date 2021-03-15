within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function hfg "Function to compute latent heat of vaporization"
  input Real P; //Pressure in psia
  output Real hfg; //latent heat of vaporization in Btu/lbm

algorithm

  hfg :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hg(
    P) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hf(
    P);

end hfg;
