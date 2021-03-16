within NHES.Pump.Model.Functions;
function ANLPumpHead "function Pi2, see ANL report"
  input Real pi1;
  output Real anl_pi2;

protected
  parameter Real c0=4.6991808;
  parameter Real c1=15.343735;
  parameter Real c2=-3574.4836;
  parameter Real c3=-41965.679;

algorithm

  anl_pi2 := c3*pi1^3 + c2*pi1^2 + c1*pi1 + c0;
end ANLPumpHead;
