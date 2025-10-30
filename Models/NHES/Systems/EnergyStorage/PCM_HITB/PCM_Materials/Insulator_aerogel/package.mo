within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
package Insulator_aerogel "Approximate aerogel properties. Conductivity is a functional mapping of data in https://www.aerogel.com/wp-content/uploads/2021/06/Pyrogel-XTE-Datasheet-English-v4.2.pdf"

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
    d := 200.0; //They only give 12.5 lg/ft3 or 0.2 g/cm3
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
  algorithm
    lambda := 1E-3*(21.571-0.021071*state.T+0.0002179*state.T*state.T);
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  algorithm
    cp := 1800; //note that this value is pretty much just made up. It's taken from an aerogel made by Gore, but that one has a density of .37g/cc and only operates -40 to 100
  end specificHeatCapacityCp;
end Insulator_aerogel;
