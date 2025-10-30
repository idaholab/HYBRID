within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
record Data_HITB_LimitBased
  "Data package required for HITB limit based modeling. Note that this will allow for constant property definitions. This is a version 01 concept. Nominal conditions are Sodium."
 parameter Modelica.Units.SI.Velocity v_sound = 2520;
 parameter Modelica.Units.SI.Density rho_l = 850;
 parameter Modelica.Units.SI.Density rho_v = 0.001;
 parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cp = 250;
 parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantVolume cv = 150;
 parameter Real gamma = cp/cv annotation(Dialog(enable = false));
 parameter Modelica.Units.SI.SpecificEnthalpy hfg = 4200e3;
 parameter Modelica.Units.SI.SurfaceTension sigma = 0.14;
 parameter Modelica.Units.SI.Length r_nucleate = 2.5e-7;
 parameter Modelica.Units.SI.Length r_pore = 50e-4;
 parameter Modelica.Units.SI.Pressure P_capillary = 50000;
 parameter Modelica.Units.SI.ThermalConductivity k_wick = 15;
 parameter Modelica.Units.SI.ThermalConductivity k_medium = 65;
 parameter Modelica.Units.SI.ThermalConductivity k_eff = k_wick*k_medium/(k_wick+k_medium) annotation(Dialog(enable = false));
 parameter Modelica.Units.SI.Area wick_perm = 1e-3;
 parameter Modelica.Units.SI.DynamicViscosity mu_l = 2.2e-4;
 parameter Modelica.Units.SI.DynamicViscosity mu_g = 1700e-8;

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Data_HITB_LimitBased;
