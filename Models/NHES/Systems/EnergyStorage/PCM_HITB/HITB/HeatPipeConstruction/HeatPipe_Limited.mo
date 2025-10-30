within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model HeatPipe_Limited "Heat pipe that operates based on theoretical limits of operation.
  https://www.1-act.com/resources/heat-pipe-performance/#:~:text=or%20flooding%20limit.-,Heat%20Pipe%20Entrainment,shear%20liquid%20from%20the%20wick."

  Modelica.Units.SI.Power Q_HP;
  Modelica.Units.SI.Power Q_lim_sonic;
  Modelica.Units.SI.Power Q_lim_entrain;
  Modelica.Units.SI.Power Q_lim_flood;
  Modelica.Units.SI.Power Q_lim_capillary;
  Modelica.Units.SI.Power Q_lim_boil;
  Modelica.Units.SI.Power Q_HP_int1;
  Modelica.Units.SI.Power Q_HP_int2;
  Modelica.Units.SI.Power Q_HP_int3;
//  Modelica.Units.SI.Power Q_HP_int4;

  parameter Modelica.Units.SI.Length r_vapor = 1.61*25.4/1000-0.45e-3;
  parameter Modelica.Units.SI.Length r_wick = 1.61*25.4/1000;
  Modelica.Units.SI.Area A_vapor = Modelica.Constants.pi*r_vapor*r_vapor;
  Modelica.Units.SI.Area A_wick = Modelica.Constants.pi*(r_wick*r_wick-r_vapor*r_vapor);
  Modelica.Units.SI.MassFlowRate m_sonic;
  Real k_flood;
  Modelica.Units.SI.Length L_evap = 0.33;
  Modelica.Units.SI.Length L_eff = 0.5+L_evap;
  Modelica.Units.SI.Temperature T_vapor = 700;
  Modelica.Units.SI.Pressure P_cap=60000;
  Modelica.Units.SI.Pressure dP_vap;
  Modelica.Units.SI.MassFlowRate m_lim_cap;
  Modelica.Units.SI.Area permeability;
  Real Re;

  Data_HITB_LimitBased data(
    rho_l(displayUnit="kg/m3"),
    rho_v(displayUnit="kg/m3"),
    cp=1250,
    cv=250,
    sigma=0.152,
    P_capillary(displayUnit="Pa") = 400)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  m_sonic = data.rho_v*data.v_sound*A_vapor/(sqrt(2*(1+data.gamma)));
  permeability = 0.125*data.r_pore^2.207;
  Q_lim_sonic = m_sonic*data.hfg;
  Q_lim_entrain = A_vapor*data.hfg*(data.sigma*data.rho_v/2/r_wick)^(0.5);
  k_flood = (data.rho_l/data.rho_v)^(0.14)*(tanh((r_wick*(Modelica.Constants.g_n*(data.rho_l-data.rho_v)/data.sigma)) ^1/4))^2;
  Q_lim_flood = k_flood*A_vapor*(data.hfg*(Modelica.Constants.g_n*data.sigma*(data.rho_l-data.rho_v))^(1/4)/((data.rho_l^(-1/4)+data.rho_v^(-1/4))^2));
 // dP_vap = 64/m_lim_cap*L_eff/(2*r_vapor)*data.rho_v/2*(m_lim_cap/data.rho_v/A_vapor)^2;
  //dP_vap = 128/Modelica.Constants.pi*data.mu_g*m_lim_cap/data.rho_v/((2*r_vapor)^4)*L_eff;
  dP_vap = 2*data.sigma/data.r_pore;
  //m_lim_cap = (data.rho_l*data.wick_perm*A_wick/data.mu_l/L_eff)*dP_vap;
  m_lim_cap = (data.rho_l*permeability*A_wick/data.mu_l/L_eff)*dP_vap;
 // dP_vap = 0.1;
 // m_lim_cap = (data.rho_l*data.wick_perm*A_wick/data.mu_l/L_eff)*128/Modelica.Constants.pi*data.mu_g/data.rho_v/((2*r_vapor)^4)*L_eff;
  Q_lim_capillary = data.hfg*m_lim_cap;
  Q_lim_boil = (2*Modelica.Constants.pi*L_evap*data.k_eff*T_vapor)/(data.hfg*data.rho_v*ln(r_wick/r_vapor))*(2*data.sigma/data.r_nucleate-data.P_capillary);

  Q_HP_int1 = min(Q_lim_sonic,Q_lim_entrain);
  Q_HP_int2 = min(Q_lim_capillary,Q_lim_flood);
  Q_HP_int3 = min(Q_HP_int1, Q_lim_boil);
  Q_HP = min(Q_HP_int2, Q_HP_int3);
  Re = ((Q_HP/data.hfg)/A_vapor)*2*r_vapor/data.mu_g;

  //Q_HP = min(Q_lim_sonic, Q_lim_entrain, Q_lim_flood, Q_lim_capillary, Q_lim_boil);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>https://www.1-act.com/resources/heat-pipe-performance/</p>
</html>"));
end HeatPipe_Limited;
