within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
encapsulated partial function PartialScalarfunctionforho_IHX
  "Interface for a function with one input and one output Real signal"
  import Modelica;
  extends Modelica.Icons.Function;
  input Real u "Independent variable";

//Additionally Passed variables
  input Real P_IHX; //Pressure in the IHX (pisa)
  input Real ktube; // tube thermal conductivity
  input Real ro_IHX; //tube inner radius
  input Real ri_IHX; //tube outer radius
  input Real hi; // heat transfer coefficient for inside the tubes
  input Real Tc1; // temperature entering the tubes
  input Real Tc2; // temperature at exit of intermediate heat exchanger
  input Real dihx; // diameter of IHX tube
  //End additionally passed values
  output Real y "Dependent variable y=f(u)";
    annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function with
one input and one output Real signal. The scalar functions
of <a href=\"modelica://Modelica.Math.Nonlinear\">Modelica.Math.Nonlinear</a>
are derived from this base type by inheritance.
This allows to use these functions directly as function arguments
to a function, see, .e.g.,
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>

</html>"));

end PartialScalarfunctionforho_IHX;
