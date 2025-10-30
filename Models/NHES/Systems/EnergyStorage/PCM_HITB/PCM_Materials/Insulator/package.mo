within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
package Insulator "Thermal material matching ASB-2600 from Zircar Ceramics: https://zircarceramics.com/wp-content/uploads/2017/01/ASB.pdf"
  extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy(
    mediumName="GenericSolid",
    T_min=0,
    T_max=1e6);

  redeclare function extends specificEnthalpy
    "Specific enthalpy"
  algorithm
    h := h_reference + 1130*(state.T - T_reference);
  end specificEnthalpy;

  redeclare function extends density
    "Density"
  algorithm
    d := 128.15;
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
  algorithm
    lambda := 1.6305E-7*state.T*state.T - 2.5218E-5*state.T+0.018617;
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  algorithm
    cp := 1130;
  end specificHeatCapacityCp;
end Insulator;
