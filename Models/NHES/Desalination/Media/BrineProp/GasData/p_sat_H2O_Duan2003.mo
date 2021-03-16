within NHES.Desalination.Media.BrineProp.GasData;
function p_sat_H2O_Duan2003
  "calculates saturation pressure of water, with the equation given in Duan2003"
  /*An improved model calculating CO2 solubility in pure water and aqueous NaCl solutions from 273 to 533 K and from 0 to 2000 bar"*/
  input Modelica.Units.SI.Temperature T;
  output Modelica.Units.SI.Pressure p_sat;
protected
  Real[:] c = {-38.640844, 5.894842, 59.876516, 26.654627, 10.637097};
  Modelica.Units.SI.Pressure P_c=220.85e5;
  Modelica.Units.SI.Temperature T_c=647.29;
  Real t = (T - T_c) / T_c;
algorithm
  //  assert(T<305,"Temperature above critical Temperature (304.1 K)");
  p_sat := P_c * T / T_c * (1 + c[1] * (-t) ^ 1.9 + c[2] * t + c[3] * t ^ 2 + c[4] * t ^ 3 + c[5] * t ^ 4);
end p_sat_H2O_Duan2003;
