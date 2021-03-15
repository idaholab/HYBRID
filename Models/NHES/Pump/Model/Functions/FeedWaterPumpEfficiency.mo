within NHES.Pump.Model.Functions;
function FeedWaterPumpEfficiency "Compute Pump Efficiency"
  extends ThermoPower.Functions.PumpCharacteristics.baseEfficiency;
  import Modelica.Constants.*;
  import      Modelica.Units.SI;
  import Modelica.Units.Conversions.*;
  constant Real MINUTE2SEC = from_minute(1) "minutes to seconds";
  input SI.Diameter N60D3;
protected
  parameter Real c0=-0.79;
  parameter Real c1=6788.13;
  parameter Real c2=-250674.41;
  parameter Real c3=1418756.06;
  parameter Real eta_eps=0.00001;
  Real qND3;
  Real eta_temp;
algorithm

  qND3 := q_flow/N60D3;
  eta_temp := (c3*qND3^3 + c2*qND3^2 + c1*qND3 + c0)/100.0;
  //eta := (c3*qND3^3 + c2*qND3^2 + c1*qND3 + c0)/100.0;
  eta := if eta_temp > eta_eps then eta_temp else eta_eps;
  //100.0 is to convert from percent to decimal number
end FeedWaterPumpEfficiency;
