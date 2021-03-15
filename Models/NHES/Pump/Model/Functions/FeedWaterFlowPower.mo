within NHES.Pump.Model.Functions;
function FeedWaterFlowPower "Compute Pump Shaft Power"
  extends ThermoPower.Functions.PumpCharacteristics.basePower;
  import      Modelica.Units.SI;
  import Modelica.Units.Conversions.*;

  constant Real MINUTE2SEC = from_minute(1) "minutes to seconds";
  input Real coeff;
  input Real N60D3;
protected
  parameter Real c1=4.4414;
  parameter Real c2=57.628;
  parameter Real c3=-5973.8;

  Real qND3;

algorithm

  qND3 :=q_flow/N60D3;
  //consumption := coeff*(c3*qND3^3+c2*qND3^2+c1*qND3);
  consumption := ANLPumpHead(qND3)*coeff*qND3;
  //See ANL report, Eq.35, pi3=pi1*pi2
end FeedWaterFlowPower;
