within NHES.Fluid.HeatExchangers.Utilities.Functions;
function LMTD
  "Calculation of the log mean temperature difference for a heat exchanger"
  extends Modelica.Icons.Function;

  input SI.Temperature T_hi "Hot stream inlet temperature";
  input SI.Temperature T_ho "Hot stream outlet temperature";
  input SI.Temperature T_ci "Cold stream inlet temperature";
  input SI.Temperature T_co "Cold stream outlet temperature";
  input Boolean counterCurrent "=true then flow counter current else parallel flow";

  output SI.TemperatureDifference DT_lm "Log mean temperature difference";
  output SI.TemperatureDifference DT_1 "Temperature difference 1 of LMTD";
  output SI.TemperatureDifference DT_2 "Temperature difference 2 of LMTD";

algorithm
  if counterCurrent then
    DT_1 :=T_hi - T_co;
    DT_2 :=T_ho - T_ci;
  else
    DT_1 :=T_hi - T_ci;
    DT_2 :=T_ho - T_co;
  end if;

  DT_lm :=smooth(1, if abs(DT_1 - DT_2) <= 1e-4 then 0
                   else (DT_1 - DT_2)/log(max(0.000001,DT_1/DT_2)));

  annotation (Documentation(info="<html>
<p>The Peclet numver is defined to be the ratio of the rate of&nbsp;advection&nbsp;of a physical quantity by the flow to the rate of&nbsp;diffusion&nbsp;of the same quantity driven by an appropriate gradient.</p>
<p> In the context of species or&nbsp;mass transfer, the P&eacute;clet number is the product of the&nbsp;Reynolds number&nbsp;and the&nbsp;Schmidt number. </p>
<ul>
<li>Pe = Re*Sc</li>
</ul>
<p>In the context of the&nbsp;thermal fluids, the thermal Peclet number is equivalent to the product of the&nbsp;Reynolds number&nbsp;and the&nbsp;Prandtl number.</p>
<ul>
<li>Pe = Re*Pr</li>
</ul>
</html>"));
end LMTD;
