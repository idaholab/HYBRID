within NHES.Desalination.Utilities;
function semiLinearSmooth
  "<html>A smooth version of semiLinear() based on P&eacute;clet number</html>"
  extends Modelica.Icons.Function;
  input SI.MassFlowRate w
    "Mass flow rate (positive when flowing from in to out)";
  input SI.SpecificEnthalpy h_in "Specific enthalpy at the inlet";
  input SI.SpecificEnthalpy h_out "Specific enthalpy at the outlet";
  input SI.MassFlowRate wblend = 1e-2
    "Mass flow rate at which the blending starts -- d*alpha*L";
  output SI.EnthalpyFlowRate Hdot "Enthalpy flow rate";
algorithm
  //Hdot := w*(h_in + (h_out - h_in)/(1 + exp(w/(2*wblend))))
  Hdot := semiLinear(w, h_in, h_out);
  annotation(inline = true);
end semiLinearSmooth;
