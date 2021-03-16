within NHES.Desalination.Utilities;
function diffusionCoefficient_TC
  // Calculate solute diffusion coefficient
  input Modelica.Units.SI.Temperature T "Absolute temperature";
  input Modelica.Units.SI.MassConcentration C "NaCl mass concentration";
  output Modelica.Units.SI.DiffusionCoefficient D
    "Solute diffusion coefficient [m2/s]";
algorithm
  D := exp(0.1546 * 0.001 * C - 2513 / T) * 6.725 * 0.000001;
end diffusionCoefficient_TC;
