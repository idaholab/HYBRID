within NHES.Desalination.Media.BrineProp.GasData;
function fugacity_N2_Duan2006 "Zero search with EOS from Duan2006"
  //doi:10.1016/j.?uid.2006.07.020
  //Shide Mao, Zhenhao Duan:A thermodynamic model for calculating nitrogen solubility, gas phase composition and density of the N2?H2O?NaCl system
  extends partial_fugacity_pTX;
protected
  Modelica.Units.SI.SpecificVolume V_neu=0.024 "Startwert";
  Modelica.Units.SI.SpecificVolume V=0;
  Real a[:] = {3.75504388E-02, -1.08730273E+04, 1.10964861E+06, 5.41589372E-04, 1.12094559E+02, -5.92191393E+03, 4.37200027E-06, 4.95790731E-01, -1.64902948E+02, -7.07442825E-08, 9.65727297E-03, 4.87945175E-01, 1.62257402E+04, 8.99000000E-03};
  //  Real beta= a[14];
  //  Real gamma = a[15];
  Real sigma = 3.63;
  Modelica.Units.SI.Temperature epsilon=101;
  Real T_m = 154 * T / epsilon;
  Real B = a[1] + a[2] / T_m ^ 2 + a[3] / T_m ^ 3;
  Real C = a[4] + a[5] / T_m ^ 2 + a[6] / T_m ^ 3;
  Real D = a[7] + a[8] / T_m ^ 2 + a[9] / T_m ^ 3;
  Real E = a[10] + a[11] / T_m ^ 2 + a[12] / T_m ^ 3;
  Real F = a[13] / T_m ^ 3;
  Real P_m = 3.0626 * sigma ^ 3 * p_bar / epsilon;
  Real G;
  Real ln_phi;
  Real Z;
  Real V_m;
  Integer z = 0
    "only a counter to avoid getting caught in the iteration loop";
  Real d = 0.7 "dampening factor 0=no dampening, 1=no progress";
algorithm
  /*  V := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                          function fugacity_N2_Duan2006_res(p=p,T=T,a=a,B=B,C=C,D=D,E=E,F=F),
                          1e-6,
                          Modelica.Constants.R*T/p,
                          1e-6);*/
  //iterative solution
  while abs(V - V_neu) > 1e-8 loop
    V := if z < 5 then V_neu else (1 - d) * V_neu + d * V;
    V_m := V * 1e6 / (1e3 * (sigma / 3.691) ^ 3);
    Z := 1 + B / V_m + C / V_m ^ 2 + D / V_m ^ 4 + E / V_m ^ 5 + F / V_m ^ 2 * (1 + a[14] / V_m ^ 2) * exp(-a[14] / V_m ^ 2);
    V_neu := Z / p * Modelica.Constants.R * T;
    z := z + 1;
    assert(z < 1000, " Reached maximum number of iterations for fugacity calculation.(fugacity_N2_Duan2006)");
  end while;
  //    V:=V_neu;
  //    print("V("+String(z)+")="+String(V_neu));
  V_m := 1e3 * V / (sigma / 3.691) ^ 3 "m^3/mol -> dm^3/mol";
  //  V_m := V/(Modelica.Constants.R*T_c/P_c);
  //  Z := 1 + B/V_m + C/V_m^2 + D/V_m^4 + E/V_m^5 + F/V_m^2*(1 + a[14]/V_m^2)*exp(-a[14]/V_m^2);
  Z := 1 + (a[1] + a[2] / T_m ^ 2 + a[3] / T_m ^ 3) / V_m + (a[4] + a[5] / T_m ^ 2 + a[6] / T_m ^ 3) / V_m ^ 2 + (a[7] + a[8] / T_m ^ 2 + a[9] / T_m ^ 3) / V_m ^ 4 + (a[10] + a[11] / T_m ^ 2 + a[12] / T_m ^ 3) / V_m ^ 5 + a[13] / T_m ^ 3 / V_m ^ 2 * (1 + a[14] / V_m ^ 2) * exp(-a[14] / V_m ^ 2);
  /*  ln_phi := Z-1-log(Z) + B/V_r + C/(2*V_r^2) + D/(4*V_r^4) + E/(5*V_r^5) + G;
                      phi := exp(ln_phi) "fugacity coefficient";*/
  G := a[13] / T_m ^ 3 / (2 * a[14]) * (2 - (2 + a[14] / V_m ^ 2) * exp(-a[14] / V_m ^ 2));
  phi := exp(Z - 1 + B / V_m + C / (2 * V_m ^ 2) + D / (4 * V_m ^ 4) + E / (5 * V_m ^ 5) + G) / Z
    "fugacity coefficient";
  /*  phi:=exp(Z-1 + (a[1]+a[2]/T_m^2+a[3]/T_m^3)/V_m 
                             + (a[4]+a[5]/T_m^2+a[6]/T_m^3)/(2*V_m^2)
                             + (a[7]+a[8]/T_m^2+a[9]/T_m^3)/(4*V_m^4)
                             + (a[10]+a[11]/T_m^2+a[12]/T_m^3)/(5*V_m^5)
                             + a[13]/(2*T_m^3*a[14])*(2-(2-a[14]/V_m^2)*exp(-a[14]/V_m^2)))/Z;*/
  //  print("z="+String(z));
  //  print("V="+String(V));
  //  PowerPlant.Components.PipeStuff.print_msg(phi,"phi_N2=");
end fugacity_N2_Duan2006;
