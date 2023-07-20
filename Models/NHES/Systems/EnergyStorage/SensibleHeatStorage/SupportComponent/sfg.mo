within NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent;
function sfg
  "Function to compute the latent entropy at a given pressure"

input Real P; //Pressure in psia
output Real sfg;

algorithm

  sfg := NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.sg(P)
     - NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.sf(P);

end sfg;
