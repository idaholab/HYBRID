within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function sigma
  input Modelica.Units.SI.Temperature T;
  constant Real a0=5.5631;
  constant Real a1=-0.0010484;
  constant Real a2=1.1969e-6;
  constant Real a3=-1.3563e-9;
  constant Real a4=6.7582e-13;
  constant Real a5=-1.475e-16;
  output Modelica.Units.SI.SurfaceTension sigma;
protected
    Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  sigma := 0.001*exp(interm);
end sigma;
