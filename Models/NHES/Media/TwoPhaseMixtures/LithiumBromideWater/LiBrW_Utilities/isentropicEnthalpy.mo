within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function isentropicEnthalpy
  "Isentropic specific enthalpy from p,s,X (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)"
  extends Modelica.Icons.Function;
  input Pressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction X[:] "Mass fraction";
  input Integer phase=0
    "2 for two-phase, 1 for one-phase, 0 if not known";
  input Integer region=0
    "If 0, region is unknown, otherwise known and this input";
  output SpecificEnthalpy h "Specific enthalpy";
algorithm
  h := isentropicEnthalpy_props_psX(
          p,
          s,
          X,
          lithiumBromideWaterBaseProp_psX(
            p,
            s,
            X,
            phase,
            region));
  annotation (Inline=true);
end isentropicEnthalpy;
