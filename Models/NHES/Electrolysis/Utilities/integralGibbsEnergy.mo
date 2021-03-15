within NHES.Electrolysis.Utilities;
function integralGibbsEnergy
  "Compute the integral form of Gibbs energy for an ideal gas as a function of temperature"

extends Modelica.Icons.Function;
import      Modelica.Units.SI;
input SI.Temperature T "Temperature in Kelvin";
output Electrolysis.Types.GibbsIntegral IntegralGibbsE
    "Molar Gibbs energy at temperature T";
parameter Real Gibbs_A1 = 238241 "Gibbs constant for an ideal gas [J/mol]";
parameter Real Gibbs_A2 = 39.9522 "Gibbs constant for an ideal gas [J/mol.K]";
parameter Real Gibbs_A3 = 0.00331866
    "Gibbs constant for an ideal gas [J/mol.K^2]";
parameter Real Gibbs_A4 = -0.0000000353216
    "Gibbs constant for an ideal gas [J/mol.K^3]";
parameter Real Gibbs_A5 = -12.8498 "Gibbs constant for an ideal gas [J/mol.K]";

algorithm
IntegralGibbsE := Gibbs_A1*T + Gibbs_A2/2*T^2 + Gibbs_A3/3*T^3 + Gibbs_A4/4*T^4 + (Gibbs_A5/2)*T^2*(log(T)-1/2);
  annotation (Inline=false,smoothOrder=2);
end integralGibbsEnergy;
