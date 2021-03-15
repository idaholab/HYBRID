within NHES.Electrolysis.Utilities;
function cathodeExCurrentDensity
  "Compute the electrode current density for the cathode"
extends Modelica.Icons.Function;
import      Modelica.Units.SI;
input SI.Temperature T "solid structure temperature [K]";
output Electrolysis.Types.CurrentDensity_cm2 j0
    "Cathode exchange current density [A/cm2]";
constant Real Rg(final unit="J/(mol.K)") = Modelica.Constants.R
    "Molar gas constant";
constant Real Fa=Modelica.Constants.F "Faraday constant [C/mol] or [J/(V.mol)]";
algorithm
  j0 := Rg*T/(2*Fa)*654*1e9*exp(-140*1e3/(Rg*T))/10000;
   annotation (Inline=true,smoothOrder=2);
end cathodeExCurrentDensity;
