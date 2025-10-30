within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function gamma
  input Modelica.Units.SI.Temperature T;
  output Real gamma;
algorithm
  gamma := c_p(T)/c_v(T);
end gamma;
