within NHES.Desalination.MEE.Multiple_Effect;
model MEE_inner
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
  Modelica.Units.SI.SpecificEnthalpy [nE] h_b_out;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_steam;
  Modelica.Units.SI.MassFlowRate [nE] m_b_in;
  Modelica.Units.SI.MassFlowRate [nE] m_b_out;
  Modelica.Units.SI.MassFlowRate [nE] m_steam;
  Modelica.Units.SI.Power [nE] Qhx;
  Modelica.Units.SI.MassFraction [2] Xin;
  Modelica.Units.SI.MassFraction [2] Xo;
  Modelica.Units.SI.Temperature [nE] T_tube;
  Modelica.Units.SI.Temperature [nE] T;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_f;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_in;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_out;
  Modelica.Units.SI.AbsolutePressure [nE] p;
  Modelica.Units.SI.CoefficientOfHeatTransfer [nE] U;
  Modelica.Units.SI.Power [nE] Q;
  Modelica.Units.SI.MassFlowRate [nE] mdot;
  Modelica.Units.SI.AbsolutePressure [nE] pT;
  Modelica.Units.SI.SpecificEnergy [nE] chemp;
  Modelica.Units.SI.SpecificGibbsFreeEnergy [nE] gW;

equation
  Xin[1]=1-Cs_in;
  Xin[2]=Cs_in;
  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;
  mdot[1]=m_flow_input;
  p_input = pT[1];
  h_in[1] =h_input;
  p=psys;
 for j in 2:nE loop
   pT[j]=p[j-1];
   mdot[j]=-m_steam[j-1];
   h_in[j]=h_steam[j-1];
 end for;
 for i in 1:nE loop
  0=m_b_in[i]+m_b_out[i]+m_steam[i];
  Cs_out=Cs_in*abs(m_b_in[i]/m_b_out[i]);
  0=Qhx[i]+h_steam[i]*m_steam[i]+h_b_innom*m_b_in[i]+h_b_out[i]*m_b_out[i];
  h_b_out[i]=MediumB.specificEnthalpy(MediumB.setState_pTX(p[i],T[i],Xo));
  chemp[i]=MediumB.mu_pTX(p[i],T[i],Xo);
  h_steam[i]=Medium.specificEnthalpy(Medium.setState_pT(p[i], T[i]));
  gW[i]=Medium.specificGibbsEnergy(Medium.setState_pT(p[i], T[i]));
  gW[i]=chemp[i];
  h_f[i]=Medium.bubbleEnthalpy(Medium.setSat_p(pT[i]));
  T_tube[i]=Medium.temperature_ph(pT[i],h_in[i]);
  U[i]=(1939.4+1.40562*(T[i]-273.15)-0.020725*((T[i]-273.15)^2)+0.0023186*((T[i]-273.15)^3));
  Q[i]=Ax[i]*U[i]*(T_tube[i]-T[i]);
  h_out[i]=h_in[i]-(Q[i]/mdot[i]);
  Q[i]=Qhx[i];
 end for;
 //sum(-m_steam)=10;

  annotation ();
end MEE_inner;
