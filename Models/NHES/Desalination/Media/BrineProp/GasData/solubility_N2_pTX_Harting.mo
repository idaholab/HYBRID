within NHES.Desalination.Media.BrineProp.GasData;
function solubility_N2_pTX_Harting "..."
  //from Harting1981, considering only NaCl
  extends partial_solubility_pTX;
  /*  input SI.Pressure p;
                      input SI.Temp_K T;
                      input SI.MassFraction X[:] "mass fractions m_x/m_H2O";
                      input SI.MolarMass MM[:] "molar masses of components";
                      output SI.MassFraction c_gas "gas concentration in kg_gas/kg_H2O";
                    */
protected
  Types.Molality molalities[size(X, 1)] = Utilities.massToMoleFractions(X, MM_vec);
  Modelica.Units.NonSI.Temperature_degC T_C=Modelica.Units.Conversions.to_degC(
      T);
  Real L_0 = 0.252 "N2 solubility in H2O at 25 atm, 75degC";
  Real L_rel_p "pressure influence";
  Real L_rel_c "salinity influence";
  Real L_rel_T "Temperature influence";
  //  Real c = X[1]/Salt_Data.M_NaCl/X[end];
  Real c = sum(molalities[1:2]) + sum(molalities[3:5]) * 1.8;
  Real p_atm = p_gas / 101325;
algorithm
  // print("mola_N2("+String(p_gas)+","+String(T-273.16)+") (solubility_N2_pTX_Duan2006)");
  //  assert(273<=T and T<=400, "T="+String(T)+" K, but N2 solubility calculation is only valid for temperatures between 0 and 127degC");
  if 273 > T or T > 400 then
    print("T=" + String(T) + " K, but N2 solubility calculation is only valid for temperatures between 0 and 127degC (Partial_Gas_Data.solubility_N2_pTX_Duan2006())");
  end if;
  /**/
  assert(p >= 1e5 and p <= 600e5, "p=" + String(p / 1e5) + " bar, but N2 solubility calculation only valid for pressures between 1 and 600 bar");
  //  assert(molalities[NaCl]<6, "mola[NaCl]="+String(molalities[NaCl])+" mol/kg, but N2 solubility calculation only valid for salinities up to 6 mol/kg");
  if molalities[1] > 6 then
    print("mola[NaCl]=" + String(molalities[1]) + " mol/kg, but N2 solubility calculation only valid for salinities up to 6 mol/kg");
  end if;
  //page 19
  L_rel_p := (0.2569 * p_atm - 2.471e-4 * p_atm ^ 2 + 1.617e-7 * p_atm ^ 3) / 100 * 15.9474650632155 "N2";
  L_rel_c := exp((-0.315 * c) + 0.01452 * c ^ 2) "S. 15";
  L_rel_T := (-0.0000003493 * (T_C - 75) ^ 3) + 0.0001054 * (T_C - 75) ^ 2 - 0.000293 * (T_C - 75) + 1.01
    "fitted with Excel";
  solu := L_0 * L_rel_p * L_rel_c * L_rel_T "l/kg_H2O";
  X_gas := solu / 22.4 * M_N2 * X[end];
  //      print("mola_N2("+String(p_gas)+"Pa,"+String(T-273.16)+"degC,"+String(molalities[1])+")="+String(solu)+" (solubility_N2_pTX_Harting)");
  //    print("mola_N2("+String(p_gas)+","+String(T-273.16)+")="+String(c_gas)+"->k="+String(c_gas/max(1,p_gas))+" (solubility_N2_pTX_Duan2006)");
end solubility_N2_pTX_Harting;
