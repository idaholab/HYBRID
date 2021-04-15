within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
function hfg "Function to compute latent heat of vaporization"
  input Real P; //Pressure in psia
  output Real hfg; //latent heat of vaporization in Btu/lbm

algorithm

  hfg :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hg(
    P) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hf(
    P);

end hfg;
