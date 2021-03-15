within NHES.Electrolysis.Utilities;
function GibbsEnergy
  "Compute the Gibbs energy for an ideal gas as a function of temperature"

extends Modelica.Icons.Function;
import      Modelica.Units.SI;
input SI.Temperature T "Temperature in Kelvin";
output SI.MolarEnergy GibbsE "molar Gibbs energy at temperature T";
parameter Real Gibbs_A1 = 238241 "Gibbs constant for an ideal gas [J/mol]";
parameter Real Gibbs_A2 = 39.9522 "Gibbs constant for an ideal gas [J/mol.K]";
parameter Real Gibbs_A3 = 0.00331866
    "Gibbs constant for an ideal gas [J/mol.K^2]";
parameter Real Gibbs_A4 = -0.0000000353216
    "Gibbs constant for an ideal gas [J/mol.K^3]";
parameter Real Gibbs_A5 = -12.8498 "Gibbs constant for an ideal gas [J/mol.K]";

algorithm
  GibbsE := Gibbs_A1 + Gibbs_A2*T + Gibbs_A3*T^2 + Gibbs_A4*T^3 + Gibbs_A5*T*log(T);
annotation (Inline=false,smoothOrder=2);
end GibbsEnergy;
