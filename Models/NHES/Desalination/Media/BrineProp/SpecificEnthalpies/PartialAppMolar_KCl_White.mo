within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
partial function PartialAppMolar_KCl_White
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  /*
                    White, D., Ryan, M., Armstrong, M.C., Gates, J. and Wood, R. (1987b) 'Heat capacities of aqueous KCl 
                    from 325 to 600 K at 17.9 MPa', The Journal of Chemical Thermodynamics, vol. 19, no. 10, oct, pp. 1023-1030, 
                    DOI: 10.1016/0021-9614(87)90012-7. 
                    */
  //  input SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input BrineProp.Types.Molality mola "n_KCl/m_H2O";
  //  output SI.SpecificHeatCapacity cp=1 "=cp_by_cpWater*cp_Water";
  //Parameters of MATLAB 2D-Fit
protected
  Real b = 0.09818;
  Real c = -1.244;
  Real k = -327.9;
  Real l = -1.31e+05;
  Real m = 628.8;
  /*  Real a= -10.63;
                      Real b= 57.96;
                      Real c= 1.789;
                      Real d= -56.53;
                      Real e= 168.9;
                      Real f= -274.6;
                      Real g= -57.32;
                      Real h= 102;
                      Real i= -179.4;

                      BrineProp.Partial_Units.Molality b_mean=1.188;
                      BrineProp.Partial_Units.Molality b_std=1.103;
                      SI.Temp_K T_mean=475.1;
                      SI.Temp_K T_std=103.5;

                      Real bn= (mola-b_mean)/b_std "normalized & centered";
                      Real Tn= (T-T_mean)/T_std "normalized & centered";*/
  //  SI.SpecificHeatCapacity cp_Water =  Modelica.Media.Water.IF97_Utilities.cp_pT(p, T);
  Modelica.Units.SI.Temperature T_min=325;
  Modelica.Units.SI.Temperature T_max=600;
end PartialAppMolar_KCl_White;
