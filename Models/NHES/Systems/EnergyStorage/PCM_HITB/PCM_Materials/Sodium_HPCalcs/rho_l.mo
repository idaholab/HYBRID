within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function rho_l
  input Modelica.Units.SI.Temperature T;
  constant Real a0 = 6.9583;
  constant Real a1 = -3.9865e-4;
  constant Real a2 = 2.689e-7;
  constant Real a3 = -2.5843e-10;
  constant Real a4 = 1.0321e-13;
  constant Real a5 = -1.6518e-17;
    output Modelica.Units.SI.Density rho_l;
protected   Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  rho_l := exp(interm);
end rho_l;
