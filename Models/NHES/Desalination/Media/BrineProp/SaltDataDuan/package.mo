within NHES.Desalination.Media.BrineProp;
package SaltDataDuan "Coefficients used in Duan density calculation"
  extends BrineProp.SaltData;

  redeclare record extends SaltConstants
      String name;
      //DENSITY
      Real C[23];
      //    SI.MolarMass M_salt "Molar Mass in kg/mol";
      Real m_r "reference molality";
      Integer z_plus "cation charge +";
      Integer z_minus "anion charge -";
      Integer v_plus "moles of cations per mol salt";
      Integer v_minus "moles of anions per mol salt";
      Real mola_max_rho
      "maximum molality for which density function is valid";
  Modelica.Units.SI.Temperature T_min_rho;
  Modelica.Units.SI.Temperature T_max_rho;
  Modelica.Units.SI.Pressure p_min_rho;
  Modelica.Units.SI.Pressure p_max_rho;
      //VISCOSITY
      Real[3] a = fill(0, 3);
      Real[3] b = fill(0, 3);
      Real[2] c = fill(0, 2);
      Real Zh_A = 0 "Zhang viscosity coefficients";
      Real Zh_B = 0;
      Real Zh_D = 0;
      Real Zh_E = 0;
      Real Zh_F = 0;
      Real mola_max_eta
      "maximum molality for which viscosity function is valid";
    annotation(Documentation(info = "<html></html>"));
  end SaltConstants;
  constant SaltConstants[:] saltConstants = {SaltConstants(name = "NaCl", M_salt = M_NaCl, m_r = 6, z_plus = 1, z_minus = -1, v_plus = 1, v_minus = 1, C = {1.06607098E+3, -8.39622456E-3, 5.35429127E-4, 7.55373789E-7, -4.19512335E-1, 1.45082899E-3, -3.47807732E-6, 0, 1.10913788E-2, 1.14498252E-3, -5.51181270E-6, 7.05483955E-9, -5.05734723E-2, -1.32747828E-4, 4.77261581E-6, -1.76888377E-8, 0, 6.40541237E-4, 3.07698827E-4, -1.64042763E-4, 7.06784935E-7, -6.50338372E-10, -4.50906014E-4}, mola_max_rho = 6, T_min_rho = 273, T_max_rho = 573, p_min_rho = 0.1e6, p_max_rho = 100e6, a = {-0.21319213, +0.13651589E-2, -0.12191756E-5}, b = {+0.69161945E-1, -0.27292263E-3, +0.20852448E-6}, c = {-0.25988855E-2, +0.77989227E-5}, Zh_A = 0.0061, Zh_B = 0.0799, Zh_D = 0.01040, Zh_E = 7.56, mola_max_eta = 6), SaltConstants(name = "KCl", M_salt = M_KCl, m_r = 6, z_plus = 1, z_minus = -1, v_plus = 1, v_minus = 1, C = {2.90812061E+2, 6.54111195, -1.61831978E-2, 1.46290384E-5, 1.41397987E+1, -1.07266230E-1, 2.64506021E-4, -2.19189708E-7, 3.02182158E-2, -2.15621394E-3, 9.24163206E-6, -1.10089434E-8, 2.87018859E-2, -6.73119697E-4, 1.68332473E-4, -7.99645640E-7, 1.11881560E-9, -6.59292385E-3, -2.02369103E-3, -1.70609099E-4, 1.00510108E-6, -1.86624642E-9, 1.91919166E-2}, mola_max_rho = 4.5, T_min_rho = 273, T_max_rho = 543, p_min_rho = 0.1e6, p_max_rho = 50e6, a = {-0.42122934, +0.18286059E-2, -0.13603098E-5}, b = {+0.11380205E-1, +0.47541391E-5, -0.99280575E-7}, c = {0, 0}, Zh_A = 0.0051, Zh_B = -0.0152, Zh_D = 0.00725, Zh_E = 0.80, mola_max_eta = 4.5), SaltConstants(name = "CaCl2", M_salt = M_CaCl2, m_r = 5, z_plus = 2, z_minus = -1, v_plus = 1, v_minus = 2, C = {1.12080057E3, -2.61669538E-1, 1.52042960E-3, -6.89131095E-7, -5.11802652E-1, 2.22234857E-3, -5.66464544E-6, 2.92950266E-9, 2.43934633E-2, -1.42746873E-3, 7.35840529E-6, -9.43615480E-9, -5.18606814E-2, -6.16536928E-5, -1.04523561E-5, 4.52637296E-8, -1.05076158E-10, 2.31544709E-3, -1.09663211E-3, 1.90836111E-4, -9.25997994E-7, 1.54388261E-9, -1.29354832E-2}, mola_max_rho = 6, T_min_rho = 273, T_max_rho = 523, p_min_rho = 0.1e6, p_max_rho = 60e6, Zh_A = 0.0157, Zh_B = 0.271, Zh_D = 0.04712, Zh_E = 94, Zh_F = 3, mola_max_eta = 3), SaltConstants(name = "MgCl2", M_salt = M_MgCl2, m_r = 2, z_plus = 2, z_minus = -1, v_plus = 1, v_minus = 2, C = {1.18880927E+3, -1.43194546, 3.87973220E-3, -2.20330377E-6, 6.38745038, -5.51728055E-2, 1.50231562E-4, -1.35757912E-7, 8.43627549E-3, 5.25365072E-3, -1.87204100E-5, 4.20263897E-8, -1.18062548, 6.07424747E-4, -1.20268210E-4, 5.23784551E-7, -8.23940319E-10, 9.75167613E-3, -4.92959181E-4, -2.73642775E-4, 5.42602386E-7, -1.95602825E-9, 1.00921935E-1}, mola_max_rho = 3, T_min_rho = 273, T_max_rho = 543, p_min_rho = 0.1e6, p_max_rho = 40e6, mola_max_eta = 0), SaltConstants(name = "SrCl2", M_salt = M_SrCl2, m_r = 2, z_plus = 2, z_minus = -1, v_plus = 1, v_minus = 2, C = {1.11894213E+3, -7.37321458E-1, 1.77908655E-3, 0, 0, 0, 0, 0, 2.21225680E-2, 6.62517291E-4, -2.37296050E-6, 0, 0, 0, 0, 0, 0, 0, -4.21300430E-3, 0, 9.46738388E-8, 0, 0}, mola_max_rho = 2, T_min_rho = 298, T_max_rho = 473, p_min_rho = 0.1e6, p_max_rho = 2e6, mola_max_eta = 0)};

end SaltDataDuan;
