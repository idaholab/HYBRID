within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model HeatPipe_Limited_Connectable "Heat pipe that operates based on theoretical limits of operation.
  https://www.1-act.com/resources/heat-pipe-performance/#:~:text=or%20flooding%20limit.-,Heat%20Pipe%20Entrainment,shear%20liquid%20from%20the%20wick."
  //Only radial surface heat loss will be considered, no end effects are taken into account in this model
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
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[3](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true) annotation (Placement(transformation(
        extent={{17,-19},{-17,19}},
        rotation=90,
        origin={-5,-7})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick[3](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true) annotation (Placement(transformation(
        extent={{18,-18},{-18,18}},
        rotation=90,
        origin={-8,-58})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_evaporator
    annotation (Placement(transformation(extent={{-104,22},{-84,42}}),
        iconTransformation(extent={{-104,22},{-84,42}})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_condenser
    annotation (Placement(transformation(extent={{80,20},{100,40}}),
        iconTransformation(extent={{80,20},{100,40}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-4,70})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-108})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(
      use_port=true)
    annotation (Placement(transformation(extent={{-84,-84},{-64,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary1(
      use_port=true)
    annotation (Placement(transformation(extent={{78,-84},{58,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-Q_HP)
    annotation (Placement(transformation(extent={{-138,-84},{-118,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Q_HP)
    annotation (Placement(transformation(extent={{138,-84},{118,-64}})));
    Modelica.Units.SI.Temperature T_evap;
    Modelica.Units.SI.Temperature T_cond;
      parameter Modelica.Units.SI.Length R_Na = 0.0254*1.98 "Main sodium radius within heat pipe, value is inner wick radius";
  parameter Modelica.Units.SI.Length R_Wick = 0.0254*2.0 "Radius of where outer wick is.";
  parameter Modelica.Units.SI.Length R_HITB = 0.0254*2.1 "Radius of entire heat pipe apparatus that moves";
  parameter Modelica.Units.SI.Length t_PCM_pipe = 0.002 "Thickness of inner pipe of PCM container";
  parameter Modelica.Units.SI.Length R_PCM_inner = 0.0254*2.1+t_PCM_pipe+0.002 "Inner radius of PCM container";
  parameter Modelica.Units.SI.Length R_PCM = 0.295 "Outer radius of PCM container";
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.002 "Outer PCM container wall thickness";

  parameter Modelica.Units.SI.Length l_HITB = 0.5+0.3+0.2;
  parameter Modelica.Units.SI.Length l_CHX = 0.3 "Length of section where heat pipe can be heated by CHX";
  parameter Modelica.Units.SI.Length l_DHX = l_CHX "Length of section where heat pipe can be cooled by DHX";
  parameter Modelica.Units.SI.Length l_gap_CHX = 0.2 "Length of section between the CHX and the PCM";
  parameter Modelica.Units.SI.Length l_gap_DHX = 0.2 "Length of section between the DHX and the PCM";
  parameter Modelica.Units.SI.Length l_PCM =  0.6 "Length of PCM heat exchange potential";

equation
  T_evap = HITB_Wick[1].material.T;
  T_cond = HITB_Wick[3].material.T;
  m_sonic =PCM_Materials.Sodium_HPCalcs.rho_v(T_evap)*data.v_sound*A_vapor/(
    sqrt(2*(1 + PCM_Materials.Sodium_HPCalcs.gamma(T_evap))));
  permeability = 0.125*data.r_pore^2.207;
  Q_lim_sonic =m_sonic*PCM_Materials.Sodium_HPCalcs.h_fg(T_evap);
  Q_lim_entrain =A_vapor*PCM_Materials.Sodium_HPCalcs.h_fg(T_evap)*(data.sigma*
    PCM_Materials.Sodium_HPCalcs.rho_v(T_evap)/2/r_wick)^(0.5);
  k_flood =(PCM_Materials.Sodium_HPCalcs.rho_l(T_evap)/
    PCM_Materials.Sodium_HPCalcs.rho_v(T_evap))^(0.14)*(tanh((r_wick*(Modelica.Constants.g_n
    *(PCM_Materials.Sodium_HPCalcs.rho_l(T_evap) -
    PCM_Materials.Sodium_HPCalcs.rho_v(T_evap))/data.sigma))^1/4))^2;
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
  Re =((Q_HP/PCM_Materials.Sodium_HPCalcs.h_fg(T_evap))/A_vapor)*2*r_vapor/
    PCM_Materials.Sodium_HPCalcs.mu_g(T_evap);

  //Q_HP = min(Q_lim_sonic, Q_lim_entrain, Q_lim_flood, Q_lim_capillary, Q_lim_boil);

  connect(HITB_Wall[1].port_a, port_evaporator) annotation (Line(points={{-5,10},
          {-6,10},{-6,32},{-94,32}}, color={191,0,0}));
  connect(HITB_Wall[3].port_a, port_condenser) annotation (Line(points={{-5,10},
          {-2,10},{-2,30},{90,30}}, color={191,0,0}));
  connect(HITB_Wall[2].port_a, adiabatic.port)
    annotation (Line(points={{-5,10},{-4,10},{-4,60}}, color={191,0,0}));
  connect(HITB_Wick.port_a, HITB_Wall.port_b) annotation (Line(points={{-8,-40},
          {-8,-28},{-5,-28},{-5,-24}}, color={191,0,0}));
  connect(HITB_Wick[2].port_b, adiabatic1.port) annotation (Line(points={{-8,-76},
          {-8,-88},{-6,-88},{-6,-98}}, color={191,0,0}));
  connect(boundary1.Q_flow_ext, realExpression1.y)
    annotation (Line(points={{72,-74},{117,-74}}, color={0,0,127}));
  connect(boundary.Q_flow_ext, realExpression.y)
    annotation (Line(points={{-78,-74},{-117,-74}}, color={0,0,127}));
  connect(boundary1.port, HITB_Wick[3].port_b) annotation (Line(points={{58,-74},
          {16,-74},{16,-76},{-8,-76}}, color={191,0,0}));
  connect(boundary.port, HITB_Wick[1].port_b) annotation (Line(points={{-64,-74},
          {-30,-74},{-30,-76},{-8,-76}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>https://www.1-act.com/resources/heat-pipe-performance/</p>
</html>"));
end HeatPipe_Limited_Connectable;
