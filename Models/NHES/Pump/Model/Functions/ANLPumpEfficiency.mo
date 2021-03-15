within NHES.Pump.Model.Functions;
function ANLPumpEfficiency "Compute Pump Efficiency Based on the Curve Fitting Equation"
  input Real pi1;
  output Real anl_eta;
protected
  parameter Real c0=-0.79;
  parameter Real c1=6788.13;
  parameter Real c2=-250674.41;
  parameter Real c3=1418756.06;

algorithm
  anl_eta := (c3*pi1^3 + c2*pi1^2 + c1*pi1 + c0)/100.0;
  //100.0 is to convert from percent to decimal number
end ANLPumpEfficiency;
