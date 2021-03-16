within NHES.Desalination.Media.BrineProp.GasData;
function fugacity_CH4_Duan1992 "Nullstellensuche mit EOS aus Duan1992"
  extends partial_fugacity_pTX;
protected
  Modelica.Units.SI.SpecificVolume V_neu=0.024 "Startwert";
  Modelica.Units.SI.SpecificVolume V=0;
  Real a[:] = {8.72553928E-02, -7.52599476E-01, 3.75419887E-01, 1.07291342E-02, 5.49626360E-03, -1.84772802E-02, 3.18993183E-04, 2.11079375E-04, 2.01682801E-05, -1.65606189E-05, 1.19614546E-04, -1.08087289E-04, 4.48262295E-02, 7.53970000E-01, 7.71670000E-02};
  Real alpha = a[13];
  Real beta = a[14];
  Real gamma = a[15];
  Modelica.Units.SI.Temperature T_c=190.6;
  Modelica.Units.SI.Pressure P_c=46.41e5;
  Real P_r = p / P_c;
  Real T_r = T / T_c;
  Real B = a[1] + a[2] / T_r ^ 2 + a[3] / T_r ^ 3;
  Real C = a[4] + a[5] / T_r ^ 2 + a[6] / T_r ^ 3;
  Real D = a[7] + a[8] / T_r ^ 2 + a[9] / T_r ^ 3;
  Real E = a[10] + a[11] / T_r ^ 2 + a[12] / T_r ^ 3;
  Real F = alpha / T_r ^ 3;
  Real ln_phi;
  Real Z;
  Real V_r;
  Real G;
  Integer z = 0
    "only a counter to avoid getting caught in the iteration loop";
  Real d = 0.7 " dampening factor 0=no dampening, 1=no progress";
algorithm
  /*  V := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                          function fugacity_CH4_Duan1992_res(p=p,T=T,a=a,B=B,C=C,D=D,E=E,F=F,P_c=P_c,T_c=T_c),
                          1e-6,
                          1e1,
                          1e-6);*/
  //  PowerPlant.Components.PipeStuff.print_msg(,"V_end=")
  while abs(V - V_neu) > 1e-8 loop
    V := if z < 5 then V_neu else (1 - d) * V_neu + d * V "dampened";
    V_r := V / (Modelica.Constants.R * T_c / P_c);
    G := F / (2 * gamma) * (beta + 1 - (beta + 1 + gamma / V_r ^ 2) * exp(-gamma / V_r ^ 2));
    Z := 1 + B / V_r + C / V_r ^ 2 + D / V_r ^ 4 + E / V_r ^ 5 + F / V_r ^ 2 * (beta + gamma / V_r ^ 2) * exp(-gamma / V_r ^ 2);
    V_neu := Z / p * Modelica.Constants.R * T;
    z := z + 1;
    assert(z < 1000, " Reached maximum number of iterations for CH4 fugacity calculation.(fugacity_CH4_Duan1992)");
  end while;
  //    V:=(1-d)*V_neu+d*V;
  //    d:= min(0.95,z/100);    V:= (1-d)*V_neu+d*V;
  //    print("V("+String(z)+")="+String(V_neu));
  phi := exp(Z - 1 + B / V_r + C / (2 * V_r ^ 2) + D / (4 * V_r ^ 4) + E / (5 * V_r ^ 5) + G) / Z
    "fugacity coefficient";
end fugacity_CH4_Duan1992;
