within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
function sfg
  "Function to compute the latent entropy at a given pressure"

input Real P; //Pressure in psia
output Real sfg;

algorithm

  sfg := NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.sg(P) -
         NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.sf(P);

end sfg;
