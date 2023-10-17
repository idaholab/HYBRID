within NHES.Desalination.MEE.Components;
model MEE_SS
    parameter SI.MassFraction Cs_in=0.08;
  parameter SI.MassFraction Cs_out=X_nom;
  import Modelica.Units.SI;

  replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
    replaceable package MediumB = NHES.Media.SeaWater;

parameter  SI.Area [nE] Ax={54.8782,467.2145,378.3631,308.78772,254.02841,210.70619,176.24812,148.6829,126.48705,108.4663,93.659195,81.248726};

  parameter Integer nE=12;
  parameter Real X_nom=0.11;
  parameter SI.AbsolutePressure [nE] psys= linspace(1e5,0.3e5,
                                                             nE);
 input Modelica.Units.SI.SpecificEnthalpy h_input=2700e3 annotation(Dialog(group="1st Effect Nominal Inlet"));
 input Modelica.Units.SI.MassFlowRate m_flow_input=2 annotation(Dialog(group="1st Effect Nominal Inlet"));
 input Modelica.Units.SI.AbsolutePressure p_input=2e5 annotation(Dialog(group="1st Effect Nominal Inlet"));
  parameter Modelica.Units.SI.SpecificEnthalpy  h_b_innom=250e3;
  parameter Integer nV=10 "Heat Exchanger Nodes";
  Modelica.Units.SI.SpecificEnthalpy [nE] h_b_out;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_steam;
  Modelica.Units.SI.MassFlowRate [nE] m_b_in;
  Modelica.Units.SI.MassFlowRate [nE] m_b_out;
  Modelica.Units.SI.MassFlowRate [nE] m_steam;
  Modelica.Units.SI.Power [nE] Qhx;
  Modelica.Units.SI.MassFraction [2] Xin;
  Modelica.Units.SI.MassFraction [2] Xo;
  Modelica.Units.SI.Temperature [nE,nV] T_tube;
  Modelica.Units.SI.Temperature [nE] T;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_min;
  Modelica.Units.SI.SpecificEnthalpy [nE,nV] h_in;
  Modelica.Units.SI.SpecificEnthalpy [nE,nV] h_out;
  Modelica.Units.SI.AbsolutePressure [nE] p;
  Modelica.Units.SI.CoefficientOfHeatTransfer [nE] U;
  Modelica.Units.SI.Power [nE,nV] Q;
  Modelica.Units.SI.MassFlowRate [nE] mdot;
  Modelica.Units.SI.AbsolutePressure [nE] pT;
  Modelica.Units.SI.SpecificEnergy [nE] chemp;
  Modelica.Units.SI.SpecificGibbsFreeEnergy [nE] gW;

  Modelica.Blocks.Continuous.FirstOrder delay[nE - 1](T=tau)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter SI.Time tau=5 "Time Constant";
equation
  Xin[1]=1-Cs_in;
  Xin[2]=Cs_in;
  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;
  mdot[1]=m_flow_input;
  p_input = pT[1];
  h_in[1,1] =h_input;
  p=psys;
 for j in 2:nE loop
   pT[j]=p[j-1];
   delay[j-1].u=-m_steam[j-1];
   delay[j-1].y=mdot[j];
   //mdot[j]=-m_steam[j-1];
   h_in[j,1]=h_steam[j-1];
 end for;
 for i in 1:nE loop
  0=m_b_in[i]-m_b_out[i]+m_steam[i];
  Cs_out=Cs_in*abs(m_b_in[i]/max(m_b_out[i],1e-6));
  0=Qhx[i]+h_steam[i]*m_steam[i]+h_b_innom*m_b_in[i]-h_b_out[i]*m_b_out[i];
  h_b_out[i]=MediumB.specificEnthalpy(MediumB.setState_pTX(p[i],T[i],Xo));
  chemp[i]=MediumB.mu_pTX(p[i],T[i],Xo);
  h_steam[i]=Medium.specificEnthalpy(Medium.setState_pT(p[i], T[i]));
  gW[i]=Medium.specificGibbsEnergy(Medium.setState_pT(p[i], T[i]));
  gW[i]=chemp[i];
  h_min[i]=Medium.specificEnthalpy(Medium.setState_pT(pT[i],T[i]));
  U[i]=(1939.4+1.40562*(T[i]-273.15)-0.020725*((T[i]-273.15)^2)+0.0023186*((T[i]-273.15)^3));
   for z in 2:nV loop
  h_in[i,z]=h_out[i,z-1];
   end for;
   for k in 1:nV loop
  T_tube[i,k]=Medium.temperature_ph(pT[i],h_in[i,k]);
  h_out[i,k]=h_in[i,k]-(Q[i,k]/mdot[i]);
  if h_out[i,k] >h_min[i] then
  Q[i,k]=(Ax[i]/nV)*U[i]*(T_tube[i,k]-T[i]);
  else
    h_min[i]=h_out[i,k];
  end if;
   end for;
  Qhx[i]=sum(Q[i,:]);
 end for;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-92,-20},{-70,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Line(points={{-100,-12},{-100,-12},{-90,-12},{-88,-18},{-86,-6},{-84,
              -18},{-82,-6},{-80,-18},{-78,-6},{-76,-18},{-74,-6},{-72,-12},{
              -64,-12}}, color={0,0,0}),
        Rectangle(
          extent={{-92,20},{-70,-4}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Backward),
        Line(points={{-100,12},{-92,12}}, color={0,0,0}),
        Line(points={{-70,12},{-62,12}}, color={0,0,0}),
        Line(points={{-82,20},{-82,40},{-32,40}}, color={0,0,0}),
        Line(points={{-76,20},{-76,20},{-76,30},{-58,30},{-58,-12},{-52,-12},{
              -52,-12}}, color={0,0,0}),
        Ellipse(
          extent={{-100,10},{-96,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{-64,10},{-60,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{-64,-14},{-60,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-42,-20},{-20,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Line(points={{-52,-12},{-52,-12},{-40,-12},{-38,-18},{-36,-6},{-34,-18},
              {-32,-6},{-30,-18},{-28,-6},{-26,-18},{-24,-6},{-22,-12},{-14,-12}},
            color={0,0,0}),
        Rectangle(
          extent={{-42,20},{-20,-4}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Backward),
        Line(points={{-50,12},{-42,12}}, color={0,0,0}),
        Line(points={{-20,12},{-12,12}}, color={0,0,0}),
        Line(points={{-32,20},{-32,40},{18,40}}, color={0,0,0}),
        Line(points={{-26,20},{-26,20},{-26,30},{-8,30},{-8,-12},{-2,-12},{-2,
              -12}}, color={0,0,0}),
        Ellipse(
          extent={{-52,10},{-48,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{-14,10},{-10,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{-14,-14},{-10,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{8,-20},{30,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Line(points={{-2,-12},{-2,-12},{10,-12},{12,-18},{14,-6},{16,-18},{18,
              -6},{20,-18},{22,-6},{24,-18},{26,-6},{28,-12},{36,-12}}, color={
              0,0,0}),
        Rectangle(
          extent={{8,20},{30,-4}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Backward),
        Line(points={{0,12},{8,12}}, color={0,0,0}),
        Line(points={{30,12},{38,12}}, color={0,0,0}),
        Line(points={{18,20},{18,40},{68,40}}, color={0,0,0}),
        Line(points={{24,20},{24,20},{24,30},{42,30},{42,-12},{48,-12},{48,-12}},
            color={0,0,0}),
        Ellipse(
          extent={{-2,10},{2,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{36,10},{40,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{36,-14},{40,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{58,-20},{80,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Line(points={{48,-12},{48,-12},{60,-12},{62,-18},{64,-6},{66,-18},{68,
              -6},{70,-18},{72,-6},{74,-18},{76,-6},{78,-12},{86,-12}}, color={
              0,0,0}),
        Rectangle(
          extent={{58,20},{80,-4}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Backward),
        Line(points={{50,12},{58,12}}, color={0,0,0}),
        Line(points={{80,12},{88,12}}, color={0,0,0}),
        Line(points={{68,20},{68,40},{100,40}}, color={0,0,0}),
        Line(points={{74,20},{74,20},{74,30},{92,30},{92,-12},{98,-12},{98,-12}},
            color={0,0,0}),
        Ellipse(
          extent={{48,10},{52,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{86,10},{90,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward),
        Ellipse(
          extent={{86,-14},{90,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Forward)}), Documentation(info="<html>
<p>Steady State MEE model</p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end MEE_SS;
