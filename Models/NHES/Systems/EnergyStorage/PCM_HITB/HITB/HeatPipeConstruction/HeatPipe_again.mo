within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model HeatPipe_again

replaceable package Medium = PCM_Materials.Sodium_HPCalcs;

Modelica.Units.SI.Mass m_evap;
Modelica.Units.SI.Mass m_conden;
Modelica.Units.SI.Mass m_core_evap;
Modelica.Units.SI.Mass m_core_cond;

Modelica.Units.SI.MassFlowRate m_cap;
Modelica.Units.SI.MassFlowRate m_boil;
Modelica.Units.SI.MassFlowRate m_transfer;
Modelica.Units.SI.MassFlowRate m_cond;

constant Real R(unit = "kg/(s.Pa)") = 1e-2;
constant Real R_sodium(unit = "Pa.m3/(K.kg)") = 1e-2;

Modelica.Units.SI.Temperature T_evap;
Modelica.Units.SI.Temperature T_cond;

Modelica.Units.SI.Pressure P_evap;
Modelica.Units.SI.Pressure P_cond;

//Modelica.Units.SI.SpecificEnthalpy h_evap;
//Modelica.Units.SI.SpecificEnthalpy h_conden;

parameter Modelica.Units.SI.Length length_PCM = 1.0;
parameter Modelica.Units.SI.Length d_core = 0.0254;
parameter Modelica.Units.SI.Volume V_core = length_PCM*d_core^2*Modelica.Constants.pi/4;
parameter Modelica.Units.SI.Temperature T_init = 400+273.15;

input Modelica.Units.SI.Power Q_evap = 1e3;
input Modelica.Units.SI.Power Q_cond = 1e3;

parameter Modelica.Units.SI.SpecificEnthalpy h_liq = 1e3;
parameter Modelica.Units.SI.SpecificEnthalpy h_vap = h_liq + 2e3;

initial equation
  T_evap = T_init;
  T_cond = T_init;
equation

  der(m_evap) = m_cap - m_boil;
  m_evap*Medium.c_p(T_evap)*der(T_evap) = m_cap*h_liq - m_boil*h_vap + Q_evap;
  R_sodium*T_evap*m_core_evap = Medium.P_vap(T_evap)*V_core/3;
  der(m_core_evap) = m_boil - m_transfer;

  m_transfer = R*(P_evap - P_cond);

  R_sodium*T_cond*m_core_cond = Medium.P_vap(T_cond)*V_core/3;
  der(m_core_cond) = m_transfer - m_cond;
  der(m_conden) = m_cond - m_cap;
  m_conden*Medium.c_p(T_cond)*der(T_cond) = m_cond*h_vap - m_cap*h_liq - Q_cond;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPipe_again;
