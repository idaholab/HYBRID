within NHES.Systems.EnergyStorage.Concrete_Solid_Media.BaseClasses;
package HeatCrete "Based on published data."
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
    d := 2318.5-0.0957522*state.T;
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity"
  algorithm
    lambda := 1.81428+0.00358237*state.T-5.19975e-6*state.T*state.T;
  end thermalConductivity;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity"
  algorithm
    cp := 830.69+1.8544*state.T;
  end specificHeatCapacityCp;
end HeatCrete;
