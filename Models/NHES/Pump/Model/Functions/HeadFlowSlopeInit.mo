within NHES.Pump.Model.Functions;
function HeadFlowSlopeInit "Calculate head at init.init derivative of flow characteristic w.r.t. volume flow"
  extends ThermoPower.Functions.PumpCharacteristics.baseFlow;
  import Modelica.Constants.*;
  import Modelica.Units.Conversions.*;
  constant Real MINUTE2SEC = from_minute(1) "minutes to seconds";
  import      Modelica.Units.SI;
  input Real ND0;
  input Real NDq0;
protected
  parameter Real c0=4.6991808;
  parameter Real c1=15.343735;
  parameter Real c2=-3574.4836;
  parameter Real c3=-41965.679;
  Real qND3;

algorithm
  qND3 := q_flow/ND0;
  head := NDq0*(c3*qND3^3 + c2*qND3^2 + c1*qND3 + c0);
end HeadFlowSlopeInit;
