within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function c_v
  input Modelica.Units.SI.Temperature T;
  constant Real a0=8.2271;
  constant Real a1=0.0011085;
  constant Real a2=-2.1757e-6;
  constant Real a3=1.6631e-9;
  constant Real a4=-6.0973e-13;
  constant Real a5=8.7109e-17;
  output Modelica.Units.SI.SpecificHeatCapacityAtConstantVolume c_v;
protected
    Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  c_v := 1000*exp(interm);
end c_v;
