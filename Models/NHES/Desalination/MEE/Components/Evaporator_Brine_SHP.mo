within NHES.Desalination.MEE.Components;
model Evaporator_Brine_SHP
  "Evaporator for desalinaition, this model has a single heat port and use SeaWater Media Package;"

  import Modelica.Fluid.Types.Dynamics;

replaceable package MediumW = Modelica.Media.Water.StandardWater;
replaceable package MediumB = NHES.Media.SeaWater;

  MediumW.ThermodynamicState vapourState "Thermodynamic state of the vapour";
  MediumW.SaturationProperties sat;
  MediumB.ThermodynamicState bstate "Thermodynamic state of the brine";

  outer Modelica.Fluid.System system "System properties";
// Initialization
  parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Mass Mm_start=20 "Initial Mixure Mass"
    annotation (Dialog(tab="Initialization"));
  parameter Real RelLevel_start=0.5 "Initial Level"
    annotation(Dialog(tab="Initialization"));

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
  annotation(Dialog(tab="Assumptions"));

  Modelica.Fluid.Interfaces.FluidPort_a Brine_Inlet_port(
    p(start=p_start),
    redeclare package Medium = MediumB (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

 Modelica.Fluid.Interfaces.FluidPort_b Brine_Outlet_port(
    p(start=p_start),
    redeclare package Medium = MediumB (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
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
  parameter Modelica.Units.SI.Temperature T_st=300 "init temp";
  parameter Modelica.Units.SI.Volume V;
  parameter Modelica.Units.SI.Area A;
  Modelica.Units.SI.Height level;

  Real alphag
             "(start=0.5)";
  MediumW.AbsolutePressure p;
  //(start=p_start, fixed=true);
  Modelica.Units.SI.SpecificEnthalpy h_b_in;
  Modelica.Units.SI.SpecificEnthalpy h_b_out;
  Modelica.Units.SI.SpecificEnthalpy h_steam;
  Modelica.Units.SI.MassFlowRate m_T;
  Modelica.Units.SI.MassFlowRate m_b_in;
  Modelica.Units.SI.MassFlowRate m_b_out;
  Modelica.Units.SI.MassFlowRate m_steam(start=1);
  Modelica.Units.SI.Density rho_g;
  Modelica.Units.SI.Density rho_b;
  Modelica.Units.SI.Mass Mm(start=Mm_start);
  Modelica.Units.SI.Mass Mg;
  Modelica.Units.SI.Mass M;
  Modelica.Units.SI.Mass Sa;
  //(start=0.01,fixed=true);
  Modelica.Units.SI.Energy E;
  Modelica.Units.SI.SpecificInternalEnergy u_g;
  Modelica.Units.SI.SpecificInternalEnergy u_b;
  Modelica.Units.SI.Power Qhx;
  Modelica.Units.SI.Volume Vg;
  Modelica.Units.SI.Volume Vm;
  Modelica.Units.SI.Velocity velg;
  Modelica.Units.SI.SurfaceTension sigma;
  Modelica.Units.SI.EnergyDensity rub;
  Modelica.Units.SI.EnergyDensity rug;
  Modelica.Units.SI.EnergyDensity rum;
  Modelica.Units.SI.MassFraction [2] Xin;
  Modelica.Units.SI.MassFraction [2] Xo;
  Modelica.Units.SI.MassFraction Cs_in;
  Modelica.Units.SI.MassFraction Cs_out(start=Cs_in,fixed=true);
  Modelica.Units.SI.Temperature T(start=T_st,fixed=true);
  Modelica.Units.SI.SpecificEnergy chemp;
  Modelica.Units.SI.SpecificGibbsFreeEnergy gW;

  Modelica.Blocks.Interfaces.RealOutput RelLevel( start=RelLevel_start, fixed=true, quantity="Relative Level")
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
        iconTransformation(extent={{100,60},{120,80}})));
initial equation
  //0=m_steam+m_b_in+m_b_out;
  //10=m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
  //0=m_b_in*Cs_in+m_b_out*Cs_out;
equation
  der(Mg)=m_T+m_steam;
  der(Mm)=m_b_in+m_b_out-m_T;
  der(E)=m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
  der(Sa)=m_b_in*Cs_in+m_b_out*Cs_out;

//Definitions  & Stae Eqs
  bstate=MediumB.setState_pTX(p,T,Xo);
  h_b_out=MediumB.specificEnthalpy(bstate);
  rho_b=MediumB.density(bstate);
  u_b=MediumB.specificInternalEnergy(bstate);
  chemp=MediumB.mu_pTX(p,T,Xo);

  Xin[2]=Cs_in;
  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;

  h_steam=MediumW.specificEnthalpy(vapourState);
  gW=MediumW.specificGibbsEnergy(vapourState);
  vapourState = MediumW.setState_pT(p, T);
  rho_g = MediumW.density(vapourState);
  u_g= MediumW.specificInternalEnergy(vapourState);

  gW=chemp;

  sat.psat = p;
  sat.Tsat = MediumW.saturationTemperature(p);
  sigma=MediumW.surfaceTension(sat);

  rug=rho_g*u_g;
  rub=rho_b*u_b;

  rum=(1-min(alphag,1))*rub+min(alphag,1)*rug;

  M=Mg+Mm;
  Mg=Vg*rho_g;
  Mm=Vm*((1-min(alphag,1))*rho_b+min(alphag,1)*rho_g);
  E=Vm*rum+Vg*rug;
  Sa= Vm*(1-min(alphag,1))*rho_b*Cs_out;
  V=Vg+Vm;
  m_T=min(alphag,1)*rho_g*velg*A;
  velg=(1.41*3.28084/(1-alphag))*(sigma*9.81*(rho_b-rho_g)/(rho_b^2))^0.25;
  //assert(alphag>=0 and alphag<=1,"alphag must be btween 0 and 1");

 // m_b_out=h_f;
  level=Vm/A;
  RelLevel=level/(V/A);

  Brine_Inlet_port.p = p;
  m_b_in=Brine_Inlet_port.m_flow;
  h_b_in =inStream(Brine_Inlet_port.h_outflow);
  Xin=inStream(Brine_Inlet_port.Xi_outflow);
  Brine_Inlet_port.h_outflow = inStream(Brine_Outlet_port.h_outflow);
  Brine_Inlet_port.Xi_outflow = inStream(Brine_Outlet_port.Xi_outflow);

  Brine_Outlet_port.p = p;
  m_b_out=Brine_Outlet_port.m_flow;
  Brine_Outlet_port.h_outflow=h_b_out;
  Brine_Outlet_port.Xi_outflow=Xo;

  steam_port.p = p;
  m_steam=steam_port.m_flow;
  steam_port.h_outflow = h_steam;

  Heat_Port.T=T;
  Qhx =Heat_Port.Q_flow
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

    annotation (Dialog(tab="Initialization"),
              Icon(graphics={
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
          arrow={Arrow.None,Arrow.Filled})}));
end Evaporator_Brine_SHP;
