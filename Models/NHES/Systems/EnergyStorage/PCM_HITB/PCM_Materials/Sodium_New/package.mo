within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
package Sodium_New "Liquid Sodium: thermal properties of liquid sodium with thermal conductivity multiplier"
  extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy(
    mediumName="Na_liquid",
    T_min=Modelica.Units.Conversions.from_degC(0),
    T_max=Modelica.Units.Conversions.from_degC(1500));
  constant Real k_eff_mult annotation(Dialog(tab = "General"));

  redeclare function extends specificEnthalpy
    "Specific enthalpy"
  algorithm
    h := h_reference + 1251*(state.T - T_reference);
  end specificEnthalpy;

  redeclare function extends density
    "Density"
  algorithm
    d := 791;
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
   // input k_eff_mult;
  algorithm
    lambda := k_eff_mult*(124.67 - 0.11381*state.T + 0.000055226*state.T^2-1.1842E-8*state.T^3);
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  algorithm
    cp := 1251;
  end specificHeatCapacityCp;
end Sodium_New;
