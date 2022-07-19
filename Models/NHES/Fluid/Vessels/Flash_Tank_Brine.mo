within NHES.Fluid.Vessels;
model Flash_Tank_Brine
  "3 equation model Flash tank with feed, condensate, steam ports, and level output"

  import Modelica.Fluid.Types.Dynamics;

replaceable package Medium = Modelica.Media.Water.StandardWater;
replaceable package Brine = NHES.Media.SeaWater;
  Brine.ThermodynamicState liquidState "Thermodynamic state of the liquid Brine";
  Medium.ThermodynamicState vapourState "Thermodynamic state of the vapour";

  outer Modelica.Fluid.System system "System properties";
// Initialization
  parameter Modelica.Units.SI.Pressure p_start=1e5 "Initial pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Real alphag_start=0.5 "Initial Void Fraction" annotation(Dialog(tab="Initialization"));

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
  annotation(Dialog(tab="Assumptions"));

  Modelica.Fluid.Interfaces.FluidPort_a feed_port(
    p(start=p_start),
    redeclare package Medium = Brine,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}}),
        iconTransformation(extent={{-72,-10},{-52,10}})));
 Modelica.Fluid.Interfaces.FluidPort_b Condensate_port(
    p(start=p_start),
    redeclare package Medium = Brine,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
Modelica.Fluid.Interfaces.FluidPort_b steam_port(
    p(start=p_start),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,90},{10,110}})));
  parameter Modelica.Units.SI.Temperature T_st=300 "init temp";
  parameter Modelica.Units.SI.Volume V_drum=1;
  parameter Modelica.Units.SI.Area A_drum=15;
  Modelica.Units.SI.Height level(min=0);
  Real alphag( start=alphag_start, fixed=true);
  Medium.AbsolutePressure p(start=p_start, fixed=true);
  Medium.SpecificEnthalpy h_g(min=0)
    "Specific enthalpy of sat vapour";
  Modelica.Units.SI.SpecificEnthalpy h_cond(min=0);
  Modelica.Units.SI.SpecificEnthalpy h_feed(min=0);
  Modelica.Units.SI.SpecificEnthalpy h_steam(min=0);
  Modelica.Units.SI.MassFlowRate m_feed;
  Modelica.Units.SI.MassFlowRate m_cond;
  Modelica.Units.SI.MassFlowRate m_steam;
  Modelica.Units.SI.Density rho_g(min=0);
  Modelica.Units.SI.Density rho_liquid(min=0);
  Modelica.Units.SI.Mass M_drum(min=0);
  Modelica.Units.SI.Energy E_drum(min=0);
  Modelica.Units.SI.Mass Sa(min=0);
  Modelica.Units.SI.SpecificInternalEnergy u_g(min=0);
  Modelica.Units.SI.SpecificInternalEnergy u_b(min=0);
  Modelica.Units.SI.MassFraction [2] Xin;
  Modelica.Units.SI.MassFraction [2] Xo;
  Modelica.Units.SI.MassFraction Cs_in(min=0);
  Modelica.Units.SI.MassFraction Cs_out(start=Cs_in,min=0, fixed=true);
  Modelica.Units.SI.Temperature T(start=T_st);
  Modelica.Units.SI.SpecificEnergy chemp;
  Modelica.Units.SI.SpecificGibbsFreeEnergy gW;
  Modelica.Blocks.Interfaces.RealOutput RelLevel(quantity="Relative Level")
    annotation (Placement(transformation(extent={{50,-10},{70,10}}),
        iconTransformation(extent={{50,-10},{70,10}})));

equation
  der(M_drum)=m_steam+m_feed+m_cond;
  der(E_drum) = m_steam*h_steam + m_cond*h_cond + m_feed*h_feed;
  der(Sa)=m_feed*Cs_in+m_cond*Cs_out;

  Xin[2]=Cs_in;
  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;

  //Stae Eqs
  liquidState = Brine.setState_pTX(p, T, Xo);
  rho_liquid = Brine.density(liquidState);
  h_cond = Brine.specificEnthalpy(liquidState);
  u_b=Brine.specificInternalEnergy(liquidState);
  chemp=Brine.mu_pTX(p,T,Xo);

  vapourState = Medium.setState_pT(p, T);
  rho_g = Medium.density(vapourState);
  h_steam=Medium.specificEnthalpy(vapourState);
  gW=Medium.specificGibbsEnergy(vapourState);
  u_g= Medium.specificInternalEnergy(vapourState);

  gW=chemp;
  Sa=Cs_out*V_drum*(1-alphag)*rho_liquid;
  if alphag >=0 and alphag <=1 then
    M_drum/V_drum = rho_liquid-alphag*(rho_liquid-rho_g);
    E_drum/V_drum=rho_liquid*u_b-alphag*(rho_liquid*u_b-rho_g*u_g);
  else
    M_drum/V_drum = rho_liquid;
    E_drum/V_drum=rho_liquid*u_b;
  end if;

 //Level
  level = (1.-alphag)*V_drum/A_drum;
  RelLevel= level/(V_drum/A_drum);

 //Connector Defintions
  feed_port.p=p;
  m_feed=feed_port.m_flow;
  feed_port.h_outflow=h_cond;
  h_feed =inStream(feed_port.h_outflow);
  Xin=inStream(feed_port.Xi_outflow);
  feed_port.Xi_outflow=inStream(Condensate_port.Xi_outflow);

  Condensate_port.p = p + Modelica.Constants.g_n*rho_liquid*level;
  m_cond=Condensate_port.m_flow;
  Condensate_port.h_outflow = h_cond;
  Condensate_port.Xi_outflow=Xo;

  steam_port.p = p;
  m_steam=steam_port.m_flow;
  steam_port.h_outflow = h_g;
  h_steam=h_g;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-50,-90},{50,10}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,-90},{50,10}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-108,2}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-10,100},{-10,92},{-10,90},{-18,88}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{10,100},{10,92},{10,90},{18,88}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-62,10},{-52,10},{-50,18}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-62,-10},{-52,-10},{-50,-18}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Text(
          extent={{-98,134},{104,116}},
          textColor={28,108,200},
          textString="%name"),
        Ellipse(
          extent={{-50,-10},{50,90}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,-10},{50,90}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-4,6},{-4,-2},{-4,-4},{4,-6}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          origin={-14,-94},
          rotation=180),
        Line(
          points={{4,6},{4,-2},{4,-4},{-4,-6}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          origin={14,-94},
          rotation=180),
        Rectangle(
          extent={{-50,-40},{50,40}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-50,0},{50,40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-48,34},{48,42}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-48,-44},{48,-36}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1)}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Flash_Tank_Brine;
