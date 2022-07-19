within NHES.Fluid.Vessels;
model Flash_Tank
  "3 equation model Flash tank with feed, condensate, steam ports, and level output"

  import Modelica.Fluid.Types.Dynamics;

replaceable package Medium = Modelica.Media.Water.StandardWater;

  Medium.ThermodynamicState liquidState "Thermodynamic state of the liquid";
  Medium.ThermodynamicState vapourState "Thermodynamic state of the vapour";
  Medium.SaturationProperties sat;
  outer Modelica.Fluid.System system "System properties";
// Initialization
  parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Real alphag_start=0.5 "Initial Void Fraction" annotation(Dialog(tab="Initialization"));
  parameter Medium.SpecificEnthalpy h_f_start=Medium.bubbleEnthalpy(Medium.setSat_p(
      p_start)) "Liquid enthalpy start value"    annotation (Dialog(tab="Initialization"));
  parameter Medium.SpecificEnthalpy h_g_start=Medium.dewEnthalpy(Medium.setSat_p(
      p_start)) "Vapour enthalpy start value"    annotation (Dialog(tab="Initialization"));

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
  annotation(Dialog(tab="Assumptions"));

  Modelica.Fluid.Interfaces.FluidPort_a feed_port(
    p(start=p_start),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}}),
        iconTransformation(extent={{-72,-10},{-52,10}})));
 Modelica.Fluid.Interfaces.FluidPort_b Condensate_port(
    p(start=p_start),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
Modelica.Fluid.Interfaces.FluidPort_b steam_port(
    p(start=p_start),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,90},{10,110}})));

  parameter Modelica.Units.SI.Volume V_drum=1;
  parameter Modelica.Units.SI.Area A_drum=15;
  Modelica.Units.SI.Height level;
  Real alphag( start=alphag_start, fixed=true);
  Medium.AbsolutePressure p(start=p_start, fixed=true);
  Medium.SpecificEnthalpy h_g( start=h_g_start, stateSelect=StateSelect.prefer)
    "Specific enthalpy of sat vapour";
  Medium.SpecificEnthalpy h_f( start=h_f_start, stateSelect=StateSelect.prefer)
    "Specific enthalpy of sat liquid";
  Modelica.Units.SI.SpecificEnthalpy h_cond(min=0);
  Modelica.Units.SI.SpecificEnthalpy h_feed(min=0);
  Modelica.Units.SI.SpecificEnthalpy h_steam(min=0);
  Modelica.Units.SI.SpecificEnthalpy h_fg;
  Modelica.Units.SI.MassFlowRate m_feed;
  Modelica.Units.SI.MassFlowRate m_cond;
  Modelica.Units.SI.MassFlowRate m_steam;
  Modelica.Units.SI.Density rho_g;
  Modelica.Units.SI.Density rho_liquid;
//  Modelica.Units.SI.Mass M_liquid;
  Modelica.Units.SI.Mass M_drum;
  Modelica.Units.SI.Energy E_drum;
//  Modelica.Units.SI.MassFraction x;
  Modelica.Blocks.Interfaces.RealOutput RelLevel(quantity="Relative Level")
    annotation (Placement(transformation(extent={{50,-10},{70,10}}),
        iconTransformation(extent={{50,-10},{70,10}})));

equation
  der(M_drum)=m_steam+m_feed+m_cond;
  //der(M_liquid)=m_feed*(1-x)+m_cond;
  der(E_drum) = m_steam*h_steam + m_cond*h_cond + m_feed*h_feed;
  h_fg=h_g-h_f;
 // x=(h_feed-h_f)/h_fg;
//  M_liquid/V_drum =(1-alphag)*rho_liquid;

  //Stae Eqs
  liquidState = Medium.setState_phX(p, h_cond);
  rho_liquid = Medium.density(liquidState);
  vapourState = Medium.setState_phX(p, h_g);
  rho_g = Medium.density(vapourState);
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  h_f = Medium.bubbleEnthalpy(sat);
  h_g = Medium.dewEnthalpy(sat);
  h_f=h_cond;


  if alphag >=0 and alphag <=1 then
    M_drum/V_drum = rho_liquid-alphag*(rho_liquid-rho_g);
    E_drum/V_drum=rho_liquid*Medium.specificInternalEnergy(liquidState)-alphag*(rho_liquid*Medium.specificInternalEnergy(liquidState)-rho_g*Medium.specificInternalEnergy(vapourState));
  else
    M_drum/V_drum = rho_liquid;
    E_drum/V_drum=rho_liquid*Medium.specificInternalEnergy(liquidState);
  end if;

 //Level
  level = (1.-alphag)*V_drum/A_drum;
  RelLevel= level/(V_drum/A_drum);

 //Connector Defintions
  feed_port.p=p;
  m_feed=feed_port.m_flow;
  feed_port.h_outflow=h_f;
  h_feed =inStream(feed_port.h_outflow);

  Condensate_port.p = p + Modelica.Constants.g_n*rho_liquid*level;
  m_cond=Condensate_port.m_flow;
  Condensate_port.h_outflow = h_cond;


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
end Flash_Tank;
