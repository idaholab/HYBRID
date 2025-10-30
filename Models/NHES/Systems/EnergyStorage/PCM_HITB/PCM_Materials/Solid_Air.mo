within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
package Solid_Air "Air needed as a solid conductor. Enthalpy is useless"

  extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy(
    mediumName="GenericSolid",
    T_min=0,
    T_max=1e6);

  redeclare function extends specificEnthalpy
    "Specific enthalpy"
  algorithm
    h := h_reference + 1130*(state.T - T_reference); //this equation is pointless
  end specificEnthalpy;

  redeclare function extends density
    "Density"
  algorithm
    d := 1.225;
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
  algorithm
    lambda := 0.055; //normal thermal conductivity, adding in an approximation for natural convection (I know it's abnormal)
    //approximation is k = h_c*A/(deltaL) =~ 0.04
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  algorithm
    cp := 1005;
  end specificHeatCapacityCp;
end Solid_Air;
