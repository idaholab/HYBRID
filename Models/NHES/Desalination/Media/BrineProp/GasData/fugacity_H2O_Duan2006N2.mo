within NHES.Desalination.Media.BrineProp.GasData;
function fugacity_H2O_Duan2006N2 "Calculation of fugacity coefficient according to (Mao&Duan 2006 'A thermodynamic model for calculating nitrogen solubility, gasphase
                composition and density of the N2?H2O?NaCl system')"
  extends partial_fugacity_pTX;
protected
  Real[:] a = {1.86357885E-03, 1.17332094E-02, 7.82682497E-07, -1.15662779E-05, -3.13619739, -1.29464029E-03};
algorithm
  phi := exp(a[1] + a[2] * p_bar + a[3] * p_bar ^ 2 + a[4] * p_bar * T + a[5] * p_bar / T + a[6] * p_bar ^ 2 / T) "equ. 5";
end fugacity_H2O_Duan2006N2;
