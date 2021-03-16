within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function specificEnthalpy_pTX_liq_Francke_cp "enthalpy calculation DIY"
  //based on Driesner enthalpy function NaCl and pressure independent 2D-fits (T,b) for cp measurement data for KCl and CaCl2 solutions
  //TODO: Add Cp_appmol for (NaCl),MgCl and SrCl
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Modelica.Units.SI.MassFraction X[:] "mass fractions m_i/m_Sol";
  output Modelica.Units.SI.SpecificEnthalpy h;
  //  constant Real M_NaCl=Salt_Data.M_NaCl "molar mass in [kg/mol]";
  //  output Real val2=H_appmol[CaCl2];
  extends BrineProp.SaltDataDuan.defineSaltOrder;
protected
  Modelica.Units.SI.MolarInternalEnergy Delta_h_solution_NaCl=0
    "HeatOfSolution_NaCl_Sanahuja1986(T) [J/mol_NaCl]";
  //  constant SI.MolarInternalEnergy Delta_h_solution_NaCl = -3460 "[J/mol_NaCl] @313.15K Sanahuja1984 http://dx.doi.org/10.1016/0021-9614(84)90192-7";
  // SI.MolarInternalEnergy Delta_h_solution_KCl = HeatOfSolution_KCl_Sanahuja1986(T) "[J/mol_NaCl]";
  // constant SI.MolarInternalEnergy Delta_h_solution_KCl = -17000 "[J/mol_KCl] http://webserver.dmt.upm.es/~isidoro/dat1/Heat%20of%20solution%20data.htm";
  //  constant SI.MolarInternalEnergy Delta_h_solution_CaCl2 = 82900 "[J/mol_CaCl2] http://webserver.dmt.upm.es/~isidoro/dat1/Heat%20of%20solution%20data.htm";
  constant Modelica.Units.SI.MolarInternalEnergy Delta_h_solution_CaCl2=81850
    "[J/mol_CaCl2] Sinke1985 http://dx.doi.org/10.1016/0021-9614(85)90083-7";
  constant Modelica.Units.SI.MolarInternalEnergy Delta_h_solution_MgCl2=0
    "[J/mol_MgCl2]";
  constant Modelica.Units.SI.MolarInternalEnergy Delta_h_solution_SrCl2=0
    "[J/mol_SrCl]";
  /*  constant SI.MolarInternalEnergy[:] Delta_h_solution = {
                        Delta_h_solution_NaCl,
                        Delta_h_solution_KCl,
                        Delta_h_solution_CaCl2,
                        Delta_h_solution_MgCl2,
                        Delta_h_solution_SrCl2};*/
  Types.Molality b[size(X, 1)] = Utilities.massToMoleFractions(X, cat(1, MM_vec_salt, fill(-1, size(X, 1) - size(MM_vec_salt, 1))));
  //  Partial_Units.Molality b[5]=mola[1:5];
  //  SI.SpecificEnthalpy h_H2O =  Modelica.Media.Water.WaterIF97_pT.specificEnthalpy_pT(p, T);
  Modelica.Units.SI.SpecificEnthalpy h_Driesner=specificEnthalpy_pTX_Driesner(
      p,
      T,
      X[1]/(X[1] + X[end]));
  Modelica.Units.SI.MolarMass MM_vec_salt[:]=BrineProp.SaltData.MM_salt[1:5];
  BrineProp.Types.PartialMolarEnthalpy[:] H_appmol = {0, if b[KCl] > 0 then appMolarEnthalpy_KCl_White(T, b[KCl]) else 0, if b[CaCl2] > 0 then appMolarEnthalpy_CaCl2_White(T, b[CaCl2]) else 0, 0, 0};
algorithm
  h := (X[NaCl] + X[end]) * h_Driesner + X[end] * b[2:5] * H_appmol[2:5];
  //  print("MM_vec_salt      :"+PowerPlant.vector2string(MM_vec_salt));
  //  print("b                :"+PowerPlant.vector2string(b));
  //  print("int_cp_by_cpWater:"+Modelica.Math.Matrices.toString({int_cp_by_cpWater}));
  //  print("H_appmol         :"+PowerPlant.vector2string(H_appmol));
  //  print("Brine.specificEnthalpy_pTX_Francke: "+String(p*1e-5)+"bar. "+String(T)+"degC->"+String(h)+" J/kg");
end specificEnthalpy_pTX_liq_Francke_cp;
