within NHES.Pump.Model.Functions;
function FeedWaterFlowHead
  extends ThermoPower.Functions.PumpCharacteristics.baseFlow;
  import Modelica.Constants.*;
  import Modelica.Units.Conversions.*;

  constant Real MINUTE2SEC = from_minute(1) "minutes to seconds";
  //g_n gravitation
  //input Real qND3 "Q/ND**3";
  import      Modelica.Units.SI;
  //input Integer NStage "Number of Stages";
  input Real coeff;
  input Real N60D3;
  //input SI.Conversions.NonSIunits.AngularVelocity_rpm N;
  //input SI.Diameter D;
protected
  parameter Real c0=4.6991808;
  parameter Real c1=15.343735;
  parameter Real c2=-3574.4836;
  parameter Real c3=-41965.679;
  //Real N60=N/MINUTE2SEC "convert rpm to 1/second";
  Real qND3;
  //Real ND;
algorithm

  qND3 := q_flow/N60D3;
  head := coeff*(c3*qND3^3 + c2*qND3^2 + c1*qND3 + c0);
end FeedWaterFlowHead;
