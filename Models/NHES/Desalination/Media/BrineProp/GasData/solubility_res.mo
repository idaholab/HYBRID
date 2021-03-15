within NHES.Desalination.Media.BrineProp.GasData;
function solubility_res
  extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Modelica.Units.SI.MassFraction X[:] "mass fractions m_x/m_Sol";
  input Modelica.Units.SI.MolarMass MM_vec[:] "molar masses of components";
  /**/
  input partial_solubility_pTX solufun;
  //  input Modelica.Icons.Function solufun;
  input Modelica.Units.SI.MassFraction c_gas;
  //  input SI.Pressure p_gas=u;
protected
  Modelica.Units.SI.MassFraction solu;
algorithm
  y := c_gas - solufun(p = p, T = T, X = X, MM_vec = MM_vec, p_gas = u)
    "*X[end]";
  //    print("T="+String(T-273.16)+"degC");
end solubility_res;
