within NHES.Electrolysis.Utilities;
function integralGibbsEnergy_NASA_7Term "Compute the Gibbs energy for an ideal gas as a function of temperature"

extends Modelica.Icons.Function;
import      Modelica.Units.SI;
input SI.Temperature T "Temperature in Kelvin";
output SI.MolarEnergy GibbsE "molar Gibbs energy at temperature T";

Real GibbsE_H2O, GibbsE_O2, GibbsE_H2;

parameter Real Gibbs_A1_H2O = 2.6770389;
parameter Real Gibbs_A2_H2O = 0.0029731816;
parameter Real Gibbs_A3_H2O = -7.7376889E-07;
parameter Real Gibbs_A4_H2O = 9.4433514E-11;
parameter Real Gibbs_A5_H2O = -4.2689991E-15;
parameter Real Gibbs_A6_H2O = -29885.894;
parameter Real Gibbs_A7_H2O = 6.88255;

parameter Real Gibbs_A1_O2 = 3.66096065;
parameter Real Gibbs_A2_O2 = 0.000656365811;
parameter Real Gibbs_A3_O2 = -1.41149627E-07;
parameter Real Gibbs_A4_O2 = 2.05797935E-11;
parameter Real Gibbs_A5_O2 = -1.29913436E-15;
parameter Real Gibbs_A6_O2 = -1215.97718;
parameter Real Gibbs_A7_O2 = 3.41536279;

parameter Real Gibbs_A1_H2 = 2.93286575;
parameter Real Gibbs_A2_H2 = 0.000826608026;
parameter Real Gibbs_A3_H2 = -1.46402364E-07;
parameter Real Gibbs_A4_H2 = 1.54100414E-11;
parameter Real Gibbs_A5_H2 = -6.888048E-16;
parameter Real Gibbs_A6_H2 = -813.065581;
parameter Real Gibbs_A7_H2 = -1.02432865;

parameter Real R = 8.3144598; //Ideal Gas Constant

algorithm
  GibbsE_H2O := (Gibbs_A1_H2O*(1/4*T^2*(3-2*log(T))) - Gibbs_A2_H2O*T^3/6 - Gibbs_A3_H2O*T^4/24 - Gibbs_A4_H2O*T^5/60 - Gibbs_A5_H2O*T^6/120 + Gibbs_A6_H2O*T - Gibbs_A7_H2O*T^2/2)*R;
  GibbsE_O2 := (Gibbs_A1_O2*(1/4*T^2*(3-2*log(T))) - Gibbs_A2_O2*T^3/6 - Gibbs_A3_O2*T^4/24 - Gibbs_A4_O2*T^5/60 - Gibbs_A5_O2*T^6/120 + Gibbs_A6_O2*T - Gibbs_A7_O2*T^2/2)*R;
  GibbsE_H2 := (Gibbs_A1_H2*(1/4*T^2*(3-2*log(T))) - Gibbs_A2_H2*T^3/6 - Gibbs_A3_H2*T^4/24 - Gibbs_A4_H2*T^5/60 - Gibbs_A5_H2*T^6/120 + Gibbs_A6_H2*T - Gibbs_A7_H2*T^2/2)*R;
  GibbsE := 0.5*GibbsE_O2 + GibbsE_H2 - GibbsE_H2O;

annotation (Inline=false,smoothOrder=2);
end integralGibbsEnergy_NASA_7Term;
