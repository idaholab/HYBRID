within NHES.Electrolysis.Utilities;
function anodeExCurrentDensity
  "Compute the electrode current density for the anode"
extends Modelica.Icons.Function;
import      Modelica.Units.SI;
input SI.Temperature T "solid structure temperature [K]";
output Electrolysis.Types.CurrentDensity_cm2 j0
    "Anode exchange current density [A/cm2]";
constant Real Rg(final unit="J/(mol.K)") = Modelica.Constants.R
    "Molar gas constant";
constant Real Fa=Modelica.Constants.F "Faraday constant [C/mol] or [J/(V.mol)]";
algorithm
  j0 := Rg*T/(2*Fa)*235*1e9*exp(-137*1e3/(Rg*T))/10000;
  annotation (Inline=true,smoothOrder=2);
end anodeExCurrentDensity;
