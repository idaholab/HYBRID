within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function mu_l
  input Modelica.Units.SI.Temperature T;
  constant Real a0=4.1428;
  constant Real a1=-9.2518e-3;
  constant Real a2=1.057e-5;
  constant Real a3=-6.9077e-9;
  constant Real a4=2.3709e-12;
  constant Real a5=-3.3213e-16;
  output Modelica.Units.SI.DynamicViscosity mu_l;
protected
  Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  mu_l := 0.0001*exp(interm);
end mu_l;
