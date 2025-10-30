within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function rho_v
  input Modelica.Units.SI.Temperature T;
  constant Real a0 = -57.566;
  constant Real a1 = 0.18157;
  constant Real a2 = -2.2885e-4;
  constant Real a3 = 1.5614e-7;
  constant Real a4 = -5.5058e-11;
  constant Real a5 = 7.8615e-15;
    output Modelica.Units.SI.Density rho_v;
protected   Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  rho_v := exp(interm);
end rho_v;
