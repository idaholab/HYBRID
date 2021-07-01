within NHES.Media.Common.NASAGlenn.NASA_Utilities;
function T_h
  extends Modelica.Icons.Function;
  input SpecificEnthalpy h;
  input Common.SingleSpeciesData ssd;
  output Temperature T;
protected
  function f_nonlinear "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
    extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
    input SpecificEnthalpy h "Specific enthalpy";
    input Common.SingleSpeciesData ssd;
  algorithm
    y := h_T(T=u, ssd=ssd) - h;
  end f_nonlinear;
algorithm
  T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
    function f_nonlinear(h=h, ssd=ssd), 270, 1000);
      Modelica.Utilities.Streams.print(String(T));
end T_h;
