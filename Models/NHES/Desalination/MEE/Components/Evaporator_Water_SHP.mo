within NHES.Desalination.MEE.Components;
model Evaporator_Water_SHP
  "Evaporator for desalinaition, this model has a single heat port and assumes Brine=Water;"

  import Modelica.Fluid.Types.Dynamics;

replaceable package MediumW = Modelica.Media.Water.StandardWater;

  MediumW.ThermodynamicState liquidState "Thermodynamic state of the liquid";
  MediumW.ThermodynamicState vapourState "Thermodynamic state of the vapour";
  MediumW.ThermodynamicState MixState "Thermodynamic state of brine mix";
  MediumW.SaturationProperties sat;
  outer Modelica.Fluid.System system "System properties";
// Initialization
  parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
    annotation (Dialog(tab="Initialization"));

  parameter Modelica.Units.SI.Mass S_start=40 "Initial Salt Mass"
    annotation (Dialog(tab="Initialization"));
  parameter Real RelLevel_start=0.5 "Initial Level" annotation(Dialog(tab="Initialization"));
  parameter MediumW.SpecificEnthalpy h_f_start=MediumW.bubbleEnthalpy(MediumW.setSat_p(
      p_start)) "Liquid enthalpy start value"    annotation (Dialog(tab="Initialization"));
  parameter MediumW.SpecificEnthalpy h_g_start=MediumW.dewEnthalpy(MediumW.setSat_p(
      p_start)) "Vapour enthalpy start value"    annotation (Dialog(tab="Initialization"));

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
  annotation(Dialog(tab="Assumptions"));

  Modelica.Fluid.Interfaces.FluidPort_a Brine_Inlet_port(
    p(start=p_start),
    redeclare package Medium = MediumW,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

 Modelica.Fluid.Interfaces.FluidPort_b Brine_Outlet_port(
    p(start=p_start),
    redeclare package Medium = MediumW,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));

Modelica.Fluid.Interfaces.FluidPort_b steam_port(
    p(start=p_start),
    redeclare package Medium = MediumW,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,90},{10,110}})));

 Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  parameter Modelica.Units.SI.Volume V;
  parameter Modelica.Units.SI.Area A;
  Modelica.Units.SI.Height level;

  Real alphag;
  MediumW.AbsolutePressure p(start=p_start);
  MediumW.SpecificEnthalpy h_g( start=h_g_start, stateSelect=StateSelect.prefer)
    "Specific enthalpy of sat vapour";
  MediumW.SpecificEnthalpy h_f( start=h_f_start, stateSelect=StateSelect.prefer)
    "Specific enthalpy of sat vapour";
  Modelica.Units.SI.SpecificEnthalpy h_b_in;
  Modelica.Units.SI.SpecificEnthalpy h_b_out;
  Modelica.Units.SI.SpecificEnthalpy h_steam;
  Modelica.Units.SI.MassFlowRate m_T;
  Modelica.Units.SI.MassFlowRate m_b_in;
  Modelica.Units.SI.MassFlowRate m_b_out;
  Modelica.Units.SI.MassFlowRate m_steam;
  Modelica.Units.SI.Density rho_g;
  Modelica.Units.SI.Density rho_b;
  Modelica.Units.SI.Density rho_f;
  Modelica.Units.SI.Mass Mm;
  Modelica.Units.SI.Mass Mg;
  Modelica.Units.SI.Mass M;
  Modelica.Units.SI.Mass S(start=S_start);
  Modelica.Units.SI.Energy E;
  Modelica.Units.SI.SpecificInternalEnergy u_g;
  Modelica.Units.SI.SpecificInternalEnergy u_b;
  Modelica.Units.SI.Power Qhx;
  Modelica.Units.SI.Volume Vg;
  Modelica.Units.SI.Volume Vm;
  Modelica.Units.SI.Velocity velg;
  Modelica.Units.SI.SurfaceTension sigma;

  Modelica.Blocks.Interfaces.RealOutput RelLevel( start=RelLevel_start, fixed=true, quantity="Relative Level")
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
        iconTransformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput Cs_out annotation (Placement(transformation(extent={{100,20},{120,40}}), iconTransformation(extent={{100,20},
            {120,40}})));
  Modelica.Blocks.Interfaces.RealInput Cs_in
    annotation (Placement(transformation(extent={{-90,10},{-110,30}}), iconTransformation(extent={{-100,20},{-80,40}})));
equation
  der(Mg)=m_T+m_steam;
  der(Mm)=m_b_in+m_b_out-m_T;

  der(E)=m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
  der(S)=m_b_in*Cs_in+m_b_out*Cs_out;

//Definitions  & Stae Eqs
  MixState= MediumW.setState_phX(p, h_b_out);
  u_b= MediumW.specificInternalEnergy(MixState);
  rho_b = MediumW.density(MixState);

  liquidState = MediumW.setState_phX(p, h_f);
  rho_f = MediumW.density(liquidState);
  vapourState = MediumW.setState_phX(p, h_g);
  rho_g = MediumW.density(vapourState);
  sat.psat = p;
  sat.Tsat = MediumW.saturationTemperature(p);
  h_f = MediumW.bubbleEnthalpy(sat);
  h_g = MediumW.dewEnthalpy(sat);
  h_b_out=h_f;
  u_g= MediumW.specificInternalEnergy(vapourState);
  sigma=MediumW.surfaceTension(sat);
  M=Mg+Mm;
  Mg=Vg*rho_g;
  Mm=Vm*((1-alphag)*rho_b+alphag*rho_g);
  E=Vm*((1-alphag)*(rho_b*u_b)+alphag*rho_g*u_g)+Vg*rho_g*u_g;
  S= Vm*(1-alphag)*rho_f*Cs_out;
  V=Vg+Vm;
  m_T=alphag*rho_g*velg*A;
  velg=(1.41*3.28084/(1-alphag))*(sigma*9.81*(rho_f-rho_g)/(rho_f^2))^0.25;

 // m_b_out=h_f;
  level=Vm/A;
  RelLevel=level/(V/A);

  Brine_Inlet_port.p = p;
  m_b_in=Brine_Inlet_port.m_flow;
  Brine_Inlet_port.h_outflow=h_f;
  h_b_in =inStream(Brine_Inlet_port.h_outflow);

  Brine_Outlet_port.p = p;
  m_b_out=Brine_Outlet_port.m_flow;
  Brine_Outlet_port.h_outflow=h_b_out;

  steam_port.p = p;
  m_steam=steam_port.m_flow;
  steam_port.h_outflow = h_g;
  h_steam=h_g;
  Heat_Port.T=sat.Tsat;
  Qhx =Heat_Port.Q_flow
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

  annotation (Icon(graphics={
        Ellipse(
          extent={{-60,60},{60,100}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=360,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-60,-100},{60,-60}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,80},{60,28}},
          lineColor={164,189,255},
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,26},{-8,40}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-4,26},{38,40}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{38,26},{60,30}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          closure=EllipseClosure.Chord),
        Ellipse(
          extent={{-60,26},{-42,30}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-60,28},{-50,30},{-30,26},{-6,28},{-4,28},{20,26},{28,28},{56,26},{60,28}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,80},{60,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{90,0},{60,0}},
          color={28,108,200},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-60,0},{-90,0}},
          color={28,108,200},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled})}), Documentation(info="<html>
<p>Evaporator shell model with pure water, in both regions</p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end Evaporator_Water_SHP;
