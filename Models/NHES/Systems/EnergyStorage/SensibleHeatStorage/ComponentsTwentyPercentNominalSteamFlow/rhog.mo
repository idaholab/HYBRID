within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function rhog "Function to Compute the density of a saturated vapor"
  input Real P;  //Pressure in psia
  output Real rhog; //density in lbm/ft^3
algorithm

  rhog := 1./
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.vg(
    P);
end rhog;
