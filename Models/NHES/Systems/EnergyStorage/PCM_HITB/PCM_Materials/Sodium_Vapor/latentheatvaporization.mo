within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_Vapor;
function latentheatvaporization
  extends Modelica.Icons.Function;
  input ThermodynamicState state "Thermodynamic state record";
  output SpecificEnthalpy hfg "Latent heat";
algorithm
  hfg := 1000*(393.37*(1-state.T/2503.7)+4398.6*(1-state.T/2503.7)^0.29302);
end latentheatvaporization;
