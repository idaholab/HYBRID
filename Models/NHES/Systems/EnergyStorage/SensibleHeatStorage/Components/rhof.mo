within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
function rhof
  "Function to Compute the density of a saturated liqud (water)."

  input Real P;  //Pressure in psia
  output Real rhof; //density in lbm/ft^3
algorithm

  rhof := 1./NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.vf(P);

end rhof;
