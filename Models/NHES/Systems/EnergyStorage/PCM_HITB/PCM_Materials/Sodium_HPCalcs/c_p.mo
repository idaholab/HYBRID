within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Sodium_HPCalcs;
function c_p
  input Modelica.Units.SI.Temperature T;
  constant Real a0=-57.346;
  constant Real a1=0.18129;
  constant Real a2=-2.2487e-4;
  constant Real a3=1.5164e-7;
  constant Real a4=-5.2957e-11;
  constant Real a5=7.5006e-15;
  output Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure c_p;
protected
    Real interm;

algorithm
  interm := a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4 + a5*T^5;
  c_p := 1000*exp(interm);
end c_p;
