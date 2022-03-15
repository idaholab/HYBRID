within NHES.Fluid.HeatExchangers.Utilities.Functions;
function quality
  "Calculates [0,1] quality given inputs of current enthalpy, hf, and hg"
  input Modelica.Units.SI.SpecificEnthalpy h;
  input Modelica.Units.SI.SpecificEnthalpy hf;
  input Modelica.Units.SI.SpecificEnthalpy hg;
  output Real quality;
algorithm
  if h<=hf then
    quality :=0;
  elseif
    h>= hg then
    quality :=1.0;
  else
    quality :=(h - hf)/(hg - hf);
  end if;
  annotation (Documentation(info="<html>
<p>Function to calculate static quality. </p>
</html>"));
end quality;
