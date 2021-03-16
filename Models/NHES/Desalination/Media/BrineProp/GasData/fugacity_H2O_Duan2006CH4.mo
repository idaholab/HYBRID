within NHES.Desalination.Media.BrineProp.GasData;
function fugacity_H2O_Duan2006CH4
  "Calculation of fugacity coefficient according to Duan ZH, Mao SD. (2006)"
  /*A thermodynamic model for calculating methane solubility, density and gas phase composition of methane-bearing aqueous fluids from 273 to 523 K and from 1 to 2000 bar. Geochimica et Cosmochimica Acta, 70 (13): 3369-3386.
                     */
  extends partial_fugacity_pTX;
protected
  Real[:] a = {-1.42006707E-02, 1.08369910E-02, -1.59213160E-06, -1.10804676E-05, -3.14287155E+00, 1.06338095E-03};
algorithm
  phi := exp(a[1] + a[2] * p_bar + a[3] * p_bar ^ 2 + a[4] * p_bar * T + a[5] * p_bar / T + a[6] * p_bar ^ 2 / T) "equ. 6";
end fugacity_H2O_Duan2006CH4;
