within NHES.Desalination.MEE.Components;
model Evaporator_Brine_SHP_ss
  "Evaporator for desalinaition, this model has a single heat port and use SeaWater Media Package;"

  import Modelica.Fluid.Types.Dynamics;

replaceable package MediumW = Modelica.Media.Water.StandardWater;
replaceable package MediumB = NHES.Media.SeaWater;

  MediumW.ThermodynamicState vapourState "Thermodynamic state of the vapour";
  MediumB.ThermodynamicState bstate "Thermodynamic state of the brine";

  outer Modelica.Fluid.System system "System properties";
// Initialization
  parameter Modelica.Units.SI.Pressure p=0.5e5
                                              "system pressure";

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
  annotation(Dialog(tab="Assumptions"));

 Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  parameter Modelica.Units.SI.Temperature T_st=300 "init temp";
  input Modelica.Units.SI.SpecificEnthalpy h_b_in=300e3 annotation(Dialog(group="General"));
  Modelica.Units.SI.SpecificEnthalpy h_b_out;
  Modelica.Units.SI.SpecificEnthalpy h_steam;
  Modelica.Units.SI.MassFlowRate m_b_in;
  Modelica.Units.SI.MassFlowRate m_b_out;
  Modelica.Units.SI.MassFlowRate m_steam;
  Modelica.Units.SI.Power Qhx;
  Modelica.Units.SI.MassFraction [2] Xin;
  Modelica.Units.SI.MassFraction [2] Xo;
  parameter Modelica.Units.SI.MassFraction Cs_in=0.08;
  parameter Modelica.Units.SI.MassFraction Cs_out=0.1;
  Modelica.Units.SI.Temperature T(start=T_st);
  Modelica.Units.SI.SpecificEnergy chemp;
  Modelica.Units.SI.SpecificGibbsFreeEnergy gW;

equation

  0=m_b_in+m_b_out+m_steam;
  Cs_out=Cs_in*abs(m_b_in/m_b_out);
  //-m_steam=Qhx/(h_steam-h_b_out);
  0=Qhx+h_steam*m_steam+h_b_in*m_b_in+h_b_out*m_b_out;
//Definitions  & Stae Eqs
  bstate=MediumB.setState_pTX(p,T,Xo);
  h_b_out=MediumB.specificEnthalpy(bstate);
  chemp=MediumB.mu_pTX(p,T,Xo);
  Xin[1]=1-Cs_in;
  Xin[2]=Cs_in;
  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;

  h_steam=MediumW.specificEnthalpy(vapourState);
  gW=MediumW.specificGibbsEnergy(vapourState);
  vapourState = MediumW.setState_pT(p, T);

  gW=chemp;

  Heat_Port.T=T_st;
  Qhx =Heat_Port.Q_flow;
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
          arrow={Arrow.None,Arrow.Filled})}));
end Evaporator_Brine_SHP_ss;
