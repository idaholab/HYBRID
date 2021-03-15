within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function appMolarHeatCapacity_KCl_White
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  extends PartialAppMolar_KCl_White;
  output Types.PartialMolarHeatCapacity Cp_app_mol;
protected
  String msg = "";
algorithm
  if outOfRangeMode > 0 then
    if not ((ignoreLimitInh_KCl_Tmin or T >= T_min) and T <= T_max) then
      msg := "Temperature is " + String(T - 273.15) + "degC, but must be between " + String(T_min - 273.15) + "degC and " + String(T_max - 273.15) + "degC (BrineProp.SpecificEnthalpies.appMolarHeatCapacity_KCl_White)";
      if outOfRangeMode == 1 then
        print(msg);
      elseif outOfRangeMode == 2 then
        assert(true, msg);
      end if;
    end if;
  end if;
  Cp_app_mol := (mola ^ b + c) * (k - l * (m - T) ^ (-1));
  //   print("Cp_app_mol_KCl= "+String(Cp_app_mol)+"J/kg");
end appMolarHeatCapacity_KCl_White;
