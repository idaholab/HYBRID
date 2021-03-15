within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function appMolarEnthalpy_CaCl2_White
  //2D-fit Reproduction of measurements of heat capacity of CaCl2 solution
  extends PartialAppMolar_CaCl2_White;
  output Types.PartialMolarEnthalpy H_app_mol;
protected
  constant Modelica.Units.SI.MolarInternalEnergy Delta_h_solution_CaCl2=81850
    "[J/mol_CaCl2] @ 298.15K Sinke1985 http://dx.doi.org/10.1016/0021-9614(85)90083-7";
  Modelica.Units.SI.Temperature T0=298.15
    "Temperature at which HeatOfSolution is taken";
  String msg = "";
algorithm
  if outOfRangeMode > 0 then
    if not ((ignoreLimitInh_CaCl2_Tmin or T >= T_min) and T <= T_max) then
      msg := "Temperature is " + String(T - 273.15) + "degC, but must be between " + String(T_min - 273.15) + "degC and " + String(T_max - 273.15) + "degC (BrineProp.SpecificEnthalpies.appMolarEnthalpy_CaCl2_White)";
      if outOfRangeMode == 1 then
        print(msg);
      elseif outOfRangeMode == 2 then
        assert(true, msg);
      end if;
    end if;
  end if;
  //  H_app_mol := Delta_h_solution_CaCl2 + (a + b*bn + c*Tn/2 + d*bn^2 + e*bn*Tn/2 + f*Tn^2/3 + g*bn^2*Tn/2 + h*bn*Tn^2/3 + i*Tn^3/4)*T_std*Tn;
  //  H_app_mol:= Delta_h_solution_CaCl2 + (mola.^b+c).*(k*T+l*log(m-T));
  H_app_mol := Delta_h_solution_CaCl2 + (mola ^ b + c) * (k * (T - T0) + l * log((m - T) / (m - T0)));
end appMolarEnthalpy_CaCl2_White;
