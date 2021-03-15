within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
partial function PartialAppMolar_CaCl2_White
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  /*
                    White, D., Doberstein, A., Gates, J., Tillett, D. and Wood, R. (1987a) 'Heat capacity of aqueous CaCl2 
                    from 306 to 603 K at 17.5 MPa', The Journal of Chemical Thermodynamics, vol. 19, no. 3, mar, pp. 251-259, 
                    DOI: 10.1016/0021-9614(87)90132-7. 
                    */
  input Modelica.Units.SI.Temperature T;
  input BrineProp.Types.Molality mola "n_KCl/m_H2O";
  //  output SI.SpecificHeatCapacity cp=1 "=cp_by_cpWater*cp_Water";
  //Parameters of MATLAB 2D-Fit
protected
  Real b = -0.001977;
  Real c = -0.9958;
  Real k = 1373;
  Real l = 6.736e+06;
  Real m = 628;
  Modelica.Units.SI.Temperature T_min=306;
  Modelica.Units.SI.Temperature T_max=603;
end PartialAppMolar_CaCl2_White;
