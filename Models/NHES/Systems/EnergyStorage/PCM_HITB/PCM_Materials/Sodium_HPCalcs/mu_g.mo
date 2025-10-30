within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function mu_g
  input Modelica.Units.SI.Temperature T;
  constant Real a0=6.4857;
  constant Real a1=1.6476e-3;
  constant Real a2=-6.37865e-7;
  constant Real a3=3.8144e-10;
  constant Real a4=-2.338e-13;
  constant Real a5=5.4972e-17;
  output Modelica.Units.SI.DynamicViscosity mu_g;
protected
  Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  mu_g := 1e-8*exp(interm);
end mu_g;
