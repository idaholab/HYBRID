within NHES.Fluid.Vessels;
model Steam_Drum "3 equation model based steam drum"

  import Modelica.Fluid.Types.Dynamics;

replaceable package Medium = Modelica.Media.Water.StandardWater;

  Medium.ThermodynamicState liquidState "Thermodynamic state of the liquid";
  Medium.ThermodynamicState vapourState "Thermodynamic state of the vapour";
  Medium.SaturationProperties sat;
  outer Modelica.Fluid.System system "System properties";
// Initialization
  parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
    annotation (Dialog(tab="Initialization"));

  parameter Modelica.Units.SI.MassFlowRate m_feed_st "Initial feed mass flow rate"
    annotation (Dialog(tab="Initialization"));
      parameter Modelica.Units.SI.MassFlowRate m_steam_st "Initial feed mass flow rate"
    annotation (Dialog(tab="Initialization"));
      parameter Modelica.Units.SI.MassFlowRate m_riser_st "Initial feed mass flow rate"
    annotation (Dialog(tab="Initialization"));
      parameter Modelica.Units.SI.SpecificEnthalpy h_downcomer_st "Initial liquid enthaply"
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
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b riser_port(
    p(start=p_start),
    redeclare package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));
 Modelica.Fluid.Interfaces.FluidPort_b downcomer_port(
    p(start=p_start),
    redeclare package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}}),
        iconTransformation(extent={{-50,-110},{-30,-90}})));
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
  Modelica.Units.SI.SpecificEnthalpy h_riser(min=0);
  Modelica.Units.SI.SpecificEnthalpy h_downcomer(start= h_downcomer_st);
  Modelica.Units.SI.SpecificEnthalpy h_feed;
  Modelica.Units.SI.SpecificEnthalpy h_steam(start=h_g_start);
  Modelica.Units.SI.SpecificEnthalpy h_fg;
  Modelica.Units.SI.MassFlowRate m_feed(start=m_feed_st);
  Modelica.Units.SI.MassFlowRate m_riser(start=m_riser_st);
  Modelica.Units.SI.MassFlowRate m_steam(start=m_steam_st);
  Modelica.Units.SI.MassFlowRate m_downcomer(start=m_steam-m_feed-m_riser);
  Modelica.Units.SI.Density rho_g;
  Modelica.Units.SI.Density rho_liquid;
  Modelica.Units.SI.Mass M_liquid;
  Modelica.Units.SI.Mass M_drum;
  Modelica.Units.SI.Energy E_drum;
  Modelica.Units.SI.PerUnit x;
  Modelica.Blocks.Interfaces.RealOutput RelLevel(quantity="Relative Level")
    annotation (Placement(transformation(extent={{92,-10},{112,10}}),
        iconTransformation(extent={{92,-10},{112,10}})));

equation
  der(M_drum)=m_riser+m_steam+m_feed+m_downcomer;
  der(M_liquid)=m_feed+m_riser*(1-x)+m_downcomer;
  der(E_drum) = m_riser*h_riser + m_steam*h_steam + m_downcomer*h_downcomer + m_feed*h_feed;

  M_liquid/V_drum =(1-alphag)*rho_liquid;

  //Stae Eqs
  liquidState = Medium.setState_phX(p, h_downcomer);
  rho_liquid = Medium.density(liquidState);
  vapourState = Medium.setState_phX(p, h_g);
  rho_g = Medium.density(vapourState);
  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  h_f = Medium.bubbleEnthalpy(sat);
  h_g = Medium.dewEnthalpy(sat);
  h_fg=h_g-h_f;
  x=(h_riser-h_f)/h_fg;

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
  feed_port.p = p;
  m_feed=feed_port.m_flow;
  feed_port.h_outflow=h_f;
  h_feed =inStream(feed_port.h_outflow);

  downcomer_port.p = p+Modelica.Constants.g_n *rho_liquid*level;
  m_downcomer=downcomer_port.m_flow;
  downcomer_port.h_outflow=h_downcomer;

  riser_port.p = p;
  m_riser=riser_port.m_flow;
  riser_port.h_outflow = h_f;
  h_riser = inStream(riser_port.h_outflow);

  steam_port.p = p;
  m_steam=steam_port.m_flow;
  steam_port.h_outflow = h_g;
  h_steam=h_g;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-90,-90},{90,90}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-88,-88},{88,88}},
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
          points={{-100,10},{-90,10},{-88,18}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-100,-10},{-90,-10},{-88,-18}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-30,-102},{-26,-88},{-18,-88}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-48,-94},{-42,-84},{-44,-78}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-88,-88},{88,88}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          closure=EllipseClosure.Chord,
          startAngle=10,
          endAngle=170),
        Line(
          points={{30,-102},{26,-88},{18,-88}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{48,-94},{42,-84},{44,-78}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Text(
          extent={{-98,134},{104,116}},
          textColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Steam_Drum;
