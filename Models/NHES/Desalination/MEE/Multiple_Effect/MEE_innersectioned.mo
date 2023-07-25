within NHES.Desalination.MEE.Multiple_Effect;
model MEE_innersectioned
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
  Modelica.Units.SI.Temperature [nE] T_tube_in;
  Modelica.Units.SI.Temperature [nE] T_tube_sat;
  Modelica.Units.SI.Temperature [nE] T_tube_out;
  Modelica.Units.SI.Temperature [nE] T;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_f;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_in;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_1;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_2;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_3;
  Modelica.Units.SI.SpecificEnthalpy [nE] h_out;
  Modelica.Units.SI.AbsolutePressure [nE] p;
  Modelica.Units.SI.CoefficientOfHeatTransfer [nE] U;
  Modelica.Units.SI.Power [nE] Q;
  Modelica.Units.SI.MassFlowRate [nE] mdot;
  Modelica.Units.SI.AbsolutePressure [nE] pT;
  Modelica.Units.SI.SpecificEnergy [nE] chemp;
  Modelica.Units.SI.SpecificGibbsFreeEnergy [nE] gW;
  Modelica.Units.SI.Area [nE] AxSH;
  Modelica.Units.SI.Area [nE] AxSat;
  Modelica.Units.SI.Area [nE] AxSC;

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
  h_in[1] =h_input;
  p=psys;
 for j in 2:nE loop
   pT[j]=p[j-1];
   delay[j-1].u=-m_steam[j-1];
   delay[j-1].y=mdot[j];
   //mdot[j]=-m_steam[j-1];
   h_in[j]=h_steam[j-1];
 end for;
 for i in 1:nE loop
  0=m_b_in[i]-m_b_out[i]+m_steam[i];
  Cs_out=Cs_in*abs(m_b_in[i]/m_b_out[i]);
  0=Qhx[i]+h_steam[i]*m_steam[i]+h_b_innom*m_b_in[i]-h_b_out[i]*m_b_out[i];
  h_b_out[i]=MediumB.specificEnthalpy(MediumB.setState_pTX(p[i],T[i],Xo));
  chemp[i]=MediumB.mu_pTX(p[i],T[i],Xo);
  h_steam[i]=Medium.specificEnthalpy(Medium.setState_pT(p[i], T[i]));
  gW[i]=Medium.specificGibbsEnergy(Medium.setState_pT(p[i], T[i]));
  gW[i]=chemp[i];
  h_f[i]=Medium.bubbleEnthalpy(Medium.setSat_p(pT[i]));
  U[i]=(1939.4+1.40562*(T[i]-273.15)-0.020725*((T[i]-273.15)^2)+0.0023186*((T[i]-273.15)^3));

  h_1[i]=Medium.dewEnthalpy(Medium.setSat_p(pT[i]));
  h_2[i]=Medium.bubbleEnthalpy(Medium.setSat_p(pT[i]));
  h_3[i]=Medium.specificEnthalpy(Medium.setState_pT(pT[i], T[i]));
  T_tube_in[i]=Medium.temperature_ph(pT[i],h_in[i]);
  T_tube_sat[i]=Medium.saturationTemperature_sat(Medium.setSat_p(pT[i]));
  T_tube_out[i]=Medium.temperature_ph(pT[i],h_out[i]);
  AxSH=mdot*(h_in[i]-h_1[i])/(U[i]*(((T_tube_in[i]+T_tube_sat[i])/2)-T[i]));
  AxSat=mdot*(h_1[i]-h_2[i])/(U[i]*(T_tube_sat[i]-T[i]));
  AxSC=mdot*(h_2[i]-h_3[i])/(U[i]*(((T_tube_sat[i]+T[i])/2)-T[i]));
  if Ax[i]<=AxSH[i] then
  h_out[i]=h_in[i]-(Q[i]/mdot[i]);
  Q[i]=(Ax[i]*U[i]*(((T_tube_in[i]+T_tube_sat[i])/2)-T[i]));
  elseif Ax[i]<= AxSH[i]+AxSat[i] then
  h_out[i]=h_in[i]-(Q[i]/mdot[i]);
  Q[i]=(AxSH[i]*U[i]*(((T_tube_in[i]+T_tube_sat[i])/2)-T[i]))+((Ax[i]-AxSH[i])*U[i]*(T_tube_sat[i]-T[i]));
  elseif Ax[i]<= AxSH[i]+AxSat[i]+AxSC[i] then
  h_out[i]=h_in[i]-(Q[i]/mdot[i]);
  Q[i]=(AxSH[i]*U[i]*(((T_tube_in[i]+T_tube_sat[i])/2)-T[i]))+((AxSat[i])*U[i]*(T_tube_sat[i]-T[i]))+((Ax[i]-AxSH[i]-AxSat[i])*U[i]*(((T_tube_in[i]+T[i])/2)-T[i]));
  else
  h_out[i]=h_3[i];
  Q[i]=mdot[i]*(h_in[i]-h_out[i]);
  end if;
  Qhx[i]=Q[i];
 end for;

  annotation ();
end MEE_innersectioned;
