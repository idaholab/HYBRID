within NHES.Desalination.Media.BrineProp.GasData;
function degassingPressure_CO2_Duan2006
  "calculates degassing pressure from concentration of dissolved gas"
  extends partial_degassingPressure_pTX;
algorithm
  p_gas := Modelica.Math.Nonlinear.solveOneNonlinearEquation(function solubility_res(solufun = function solubility_CO2_pTX_Duan2006(), p = p, T = T, X = X, MM_vec = MM_vec, c_gas = X[end - 3]), 0, 1990e5, 1e-8);
end degassingPressure_CO2_Duan2006;
