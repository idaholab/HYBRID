within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
package Lambda_wick_d_5000_cp_1000 "Custom: lambda = 'wick' | d = 5000 | cp = 1000"
  extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy(
    mediumName="GenericSolid",
    T_min=0,
    T_max=1e6);

  redeclare function extends specificEnthalpy
    "Specific enthalpy"
  algorithm
    h := h_reference + 500*(state.T - T_reference);
  end specificEnthalpy;

  redeclare function extends density
    "Density"
  algorithm
    d := 5000;
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
  algorithm
    lambda := 10;
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  algorithm
    cp := 1000;
  end specificHeatCapacityCp;
end Lambda_wick_d_5000_cp_1000;
