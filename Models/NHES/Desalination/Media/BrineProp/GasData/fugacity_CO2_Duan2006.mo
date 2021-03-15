within NHES.Desalination.Media.BrineProp.GasData;
function fugacity_CO2_Duan2006
  "Calculation of fugacity coefficient according to (Duan 2006)"
  //doi:10.1016/j.marchem.2005.09.001
  extends partial_fugacity_pTX;
  /*  input SI.Pressure p;
                      input SI.Temp_K T;
                      output Real phi;*/
protected
  Types.Pressure_bar P_1;
  Real c[15];
algorithm
  if outOfRangeMode == 1 then
    if T < 273 or T > 573 then
      print("T=" + String(T) + "K, but CO2 solubility calculation is only valid for temperatures between 0 and 260degC (Partial_Gas_Data.fugacity_CO2_Duan2006)");
    end if;
    if p < 0 or p > 2000e5 then
      print("p=" + String(p / 1e5) + " bar, but CO2 fugacity calculation only valid for pressures between 0 and 2000 bar (Partial_Gas_Data.fugacity_CO2_Duan2006)");
    end if;
  elseif outOfRangeMode == 2 then
    assert(T > 273 and T < 573, "T=" + String(T - 273.15) + "degC out of range(0...300degC) for CO2 fugacity calculation (fugacity_CO2_Duan2006)");
    assert(p < 2000e5, "p=" + String(p / 1e5) + " bar out of range for CO2 fugacity calculation (fugacity_CO2_Duan2006)");
  end if;
  if T < 305 then
    P_1 :=Modelica.Units.Conversions.to_bar(p_sat_CO2(T));
  elseif T < 405 then
    P_1 := 75 + (T - 305) * 1.25;
  else
    P_1 := 200;
  end if;
  if p_bar < P_1 then
    c[:] := {1.0, 4.7586835E-3, -3.3569963E-6, 0, -1.3179396, -3.8389101E-6, 0, 2.2815104E-3, 0, 0, 0, 0, 0, 0, 0};
  elseif T > 435 then
    c[:] := {-1.5693490E-1, 4.4621407E-4, -9.1080591E-7, 0, 0, 1.0647399E-7, 2.4273357E-10, 0, 3.5874255E-1, 6.3319710E-5, -249.89661, 0, 0, 888.76800, -6.6348003E-7};
  elseif p_bar < 1000 then
    if T < 340 then
      c[:] := {-7.1734882E-1, 1.5985379E-4, -4.9286471E-7, 0, 0, -2.7855285E-7, 1.1877015E-9, 0, 0, 0, 0, -96.539512, 4.4774938E-1, 101.81078, 5.3783879E-6};
    else
      c[:] := {5.0383896, -4.4257744E-3, 0, 1.9572733, 0, 2.4223436E-6, 0, -9.3796135E-4, -1.5026030, 3.0272240E-3, -31.377342, -12.847063, 0, 0, -1.5056648E-5};
    end if;
  else
    if T < 340 then
      c[:] := {-6.5129019E-2, -2.1429977E-4, -1.1444930E-6, 0.0, 0.0, -1.1558081E-7, 1.1952370E-9, 0.0, 0.0, 0.0, 0.0, -221.34306, 0.0, 71.820393, 6.6089246E-6};
    else
      c[:] := {-16.063152, -2.7057990E-3, 0, 1.4119239E-1, 0, 8.1132965E-7, 0, -1.1453082E-4, 2.3895671, 5.0527457E-4, -17.763460, 985.92232, 0, 0, -5.4965256E-7};
    end if;
  end if;
  //1 273<T<573 and p_bar<P_1
  //6 T>435 and p_bar>P_1
  //P_1<p_bar<1000 and 273<T<435
  //2 273<T<340 and P_1<p_bar<1000
  //T>340
  //4 340<T<435 and P_1<p_bar<1000
  //p_bar>1000 bar and 273<T<435
  //3 273<T<340 and p_bar>1000
  //T>340"
  //5 340<T<435 and p_bar>1000
  //Region 6 omitted
  phi := c[1] + (c[2] + c[3] * T + c[4] / T + c[5] / (T - 150)) * p_bar + (c[6] + c[7] * T + c[8] / T) * p_bar ^ 2 + (c[9] + c[10] * T + c[11] / T) * log(p_bar) + (c[12] + c[13] * T) / p_bar + c[14] / T + c[15] * T ^ 2;
  //   print("P1="+String(P_1));
end fugacity_CO2_Duan2006;
