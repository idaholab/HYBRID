within NHES.Desalination.MEE.Multiple_Effect;
model MEE_FC_ss_U "Multi-Effect Evaporator"
  extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable Data.MEE_Data data);

  Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss[data.nE](
    p=data.psys,
    T_st=data.Tsys,
    h_b_in=h_b_innom,
    Cs_in=Cs_in,
    Cs_out=data.Xsys)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  parameter SI.MassFraction Cs_in=0.08;
  parameter SI.MassFraction Cs_out=data.X_nom;
  SI.MassFlowRate Cond_out;
  Real GOR;

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
    replaceable package MediumB = NHES.Media.SeaWater;

  Modelica.Blocks.Sources.RealExpression steamflow[data.nE - 1](y=-
        evaporator_Brine_SHP_ss[1:data.nE - 1].m_steam)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));

 final parameter SI.Area [data.nE] Ax(fixed=false)=fill(10,data.nE);
  Modelica.Blocks.Sources.RealExpression steament[data.nE - 1](y=
        evaporator_Brine_SHP_ss[1:data.nE - 1].h_steam)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Components.SEE_Tube_Side_Ue          HX(Ax=Ax[1])
                                          annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-122,0})));
  Components.SEE_Tube_Side_Ue_portless           HXs[data.nE - 1](Ax=Ax[2:data.nE])
    annotation (Placement(transformation(extent={{-20,-114},{20,-74}})));
    parameter Real [2] Xin={1-Cs_in,
                                Cs_in};
 final parameter Modelica.Units.SI.SpecificEnthalpy h_input=2700e3 annotation(Dialog(group="1st Effect Nominal Inlet"));
 final parameter Modelica.Units.SI.MassFlowRate m_flow_input=2 annotation(Dialog(group="1st Effect Nominal Inlet"));
 final parameter Modelica.Units.SI.AbsolutePressure p_input=2e5 annotation(Dialog(group="1st Effect Nominal Inlet"));
 final parameter Modelica.Units.SI.SpecificEnthalpy  h_b_innom=250e3;

 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_b_out(fixed=false) =fill(600e3,data.nE);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_steam(fixed=false) =fill(3000e3,data.nE);
 final parameter Modelica.Units.SI.MassFlowRate [data.nE] m_b_in( fixed=false)=fill(1,data.nE);
 final parameter Modelica.Units.SI.MassFlowRate [data.nE] m_b_out(fixed=false)=fill(0.5,
                                                                    data.nE);
 final parameter Modelica.Units.SI.MassFlowRate [data.nE] m_steam(fixed=false)=fill(-1,data.nE);
 final parameter Modelica.Units.SI.Power [data.nE] Qhx(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.MassFraction [2] Xo(fixed=false)={0.9,
                                                     0.1};
 final parameter Modelica.Units.SI.Temperature [data.nE] T_tube(fixed=false)=fill(400,data.nE);
 final parameter Modelica.Units.SI.Temperature [data.nE] T(fixed=false)=fill(400,data.nE);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_f(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_in(fixed=false)=fill(3000e3,data.nE);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_out(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.AbsolutePressure [data.nE] p(fixed=false)=fill(1e5,data.nE);
 final parameter Modelica.Units.SI.CoefficientOfHeatTransfer [data.nE] U(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.Power [data.nE] Q(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.MassFlowRate [data.nE] mdot(fixed=false)=fill(1,data.nE);
 final parameter Modelica.Units.SI.AbsolutePressure [data.nE] pT(fixed=false)=fill(1e5,data.nE);
 final parameter Modelica.Units.SI.SpecificEnergy [data.nE] chemp(fixed=false)=fill(30,data.nE);
 final parameter Modelica.Units.SI.SpecificGibbsFreeEnergy [data.nE] gW(fixed=false)=fill(30,data.nE);





initial equation

  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;
  mdot[1]=m_flow_input;
  p_input = pT[1];
  h_in[1] =h_input;
  p=data.psys;
 for j in 2:data.nE loop
   pT[j]=p[j-1];
   mdot[j]=-m_steam[j-1];
   h_in[j]=h_steam[j-1];
 end for;
 for i in 1:data.nE loop
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
  h_out[i]=h_f[i];
  Q[i]=Qhx[i];
 end for;

equation
  Cond_out=abs(sum(evaporator_Brine_SHP_ss.m_steam));
  GOR=abs(Cond_out/port_a.m_flow);

  // middle effects
  HXs[:].h_input =steament[:].y;
  HXs[:].m_flow_input =steamflow[:].y;
  HXs[:].p =data.psys[1:data.nE-1];

  connect(port_a, HX.port_a) annotation (Line(points={{-100,60},{-100,44},{-122,
          44},{-122,20}}, color={0,127,255}));
  connect(HX.port_b, port_b) annotation (Line(points={{-122,-20},{-122,-60},{-100,
          -60}}, color={0,127,255}));
  connect(HX.heat_port, evaporator_Brine_SHP_ss[1].Heat_Port) annotation (Line(
        points={{-110,-2.22045e-15},{-46,-2.22045e-15},{-46,-40},{0,-40}},
        color={191,0,0}));
  connect(HXs.heat_port, evaporator_Brine_SHP_ss[2:data.nE].Heat_Port)
    annotation (Line(points={{0,-82},{0,-38}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-94,94},{94,32}},
          textColor={28,108,200},
          textString="%data.nE Effect MEE
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=500,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_FC_ss_U;
