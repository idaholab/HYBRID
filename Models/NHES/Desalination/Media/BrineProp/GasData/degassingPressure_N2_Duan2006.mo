within NHES.Desalination.Media.BrineProp.GasData;
function degassingPressure_N2_Duan2006
  "calculates degassing pressure from concentration of dissolved gas"
  extends partial_degassingPressure_pTX;
  /*protected 
                        SI.MassFraction solu_soll=X[end-3];*/
algorithm
  //  print("degassingPressure_N2_Duan2006("+String(p)+","+String(T)+","+String(X[end-2])+")="+String(p_gas)+" (degassingPressure_N2_Duan2006)");
  p_gas := Modelica.Math.Nonlinear.solveOneNonlinearEquation(function solubility_res(solufun = function solubility_N2_pTX_Duan2006(), p = p, T = T, X = X, MM_vec = MM_vec, c_gas = X[end - 2]), 0, 600e5, 1e-8);
  assert(size(X, 1) == 9, "Wenn es nicht 9 Komponenten gibt, dann haut die Konzentrationszuordnung hier nich hin(degassingPressure_N2_Duan2006)");
  //  print("p_sat_N2("+String(X[end-2])+")="+String(p_gas)+" (degassingPressure_N2_Duan2006)");
end degassingPressure_N2_Duan2006;
