within NHES.Fluid.HeatExchangers.Utilities;
package Functions


function epsilon
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Temperature High_1;
  input Modelica.Units.SI.Temperature Low_1;
  input Modelica.Units.SI.Temperature High_2;
  input Modelica.Units.SI.Temperature Low_2;
  output Real eps;
protected
  Modelica.Units.SI.Temperature DELTAT_den=High_1 - Low_2;
algorithm
  if
    (DELTAT_den<=0) then
    eps :=0.8;
  else
    eps := if (High_1 - High_2)/DELTAT_den > 1 then 0.8 else (High_1 - High_2)/DELTAT_den;
  end if;
end epsilon;
end Functions;
