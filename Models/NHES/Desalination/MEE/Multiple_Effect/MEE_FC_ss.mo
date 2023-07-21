within NHES.Desalination.MEE.Multiple_Effect;
model MEE_FC_ss "Multi-Effect Evaporator"
  extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable Data.MEE_Data data);

  Medium.SaturationProperties [data.nE] sat;
  Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss[data.nE](
    p=data.psys,
    T_st=data.Tsys,
    h_b_in=NHES.Media.SeaWater.specificEnthalpy_pTX(
        1e5,
        data.T_b_in,
        Xin),
    Cs_in=Cs_in,
    Cs_out=data.Xsys)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[data.nE](
     use_port=true, Q_flow=1000000)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  parameter SI.MassFraction Cs_in=0.08;
  parameter SI.AbsolutePressure p_innom=2e5;

  SI.SpecificEnthalpy [data.nE] h_innom;
  SI.SpecificEnthalpy [data.nE] h_outnom;
  parameter SI.MassFraction [2] Xin={(1-Cs_in),Cs_in};
  SI.SpecificEnthalpy [data.nE] h_in;
  SI.SpecificEnthalpy [data.nE] h_out;
  SI.Molality [data.nE-1] m;
  SI.TemperatureDifference [data.nE-1] dTbpe;
  SI.Power [data.nE] Q;
  SI.MassFlowRate Cond_out;
  Real GOR;

  Modelica.Blocks.Sources.RealExpression heat_in[data.nE](y=Q)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
equation

  //First stage
  port_a.m_flow=-port_b.m_flow;
  port_a.p=port_b.p;
  sat[1].psat=p_innom;
  sat[1].Tsat= Medium.saturationTemperature(p_innom);
  h_in[1]=inStream(port_a.h_outflow);
  h_innom[1]=Medium.dewEnthalpy(sat[1]);

  //Other stages
  m=data.Xsys[1:data.nE-1]./(0.05844);
  dTbpe=1.024.*m;
  sat[2:data.nE].psat = data.psys[2:data.nE];
  sat[2:data.nE].Tsat = Medium.saturationTemperature(data.psys[1:data.nE-1]);
  h_innom[2:data.nE]=Medium.specificEnthalpy_pT(data.psys[1:data.nE-1],(sat[1:data.nE-1].Tsat+dTbpe));
  h_in[2:data.nE]=evaporator_Brine_SHP_ss[1:data.nE-1].h_steam;

  //hout and Qs
  h_outnom=Medium.bubbleEnthalpy(sat);
  for i in 1:data.nE loop
    if h_in[i]>h_innom[i] then
    h_out[i]=h_in[i]-(h_innom[i]-h_outnom[i])-sqrt(abs(h_in[i]-h_innom[i]));
    else
    h_out[i]= h_outnom[i];
    end if;
  end for;
  Q[1]=port_a.m_flow*(h_in[1]-h_out[1]);
  Q[2:data.nE]=-evaporator_Brine_SHP_ss[1:data.nE-1].m_steam.*(h_in[2:data.nE]-h_out[2:data.nE]);
  port_a.h_outflow=inStream(port_b.h_outflow);
  port_b.h_outflow=h_out[1];

  Cond_out=abs(sum(evaporator_Brine_SHP_ss.m_steam));
  GOR=abs(Cond_out/port_a.m_flow);

connect(boundary.port, evaporator_Brine_SHP_ss.Heat_Port)
    annotation (Line(points={{-20,-70},{0,-70},{0,-40}}, color={191,0,0}));

  connect(heat_in.y, boundary.Q_flow_ext)
    annotation (Line(points={{-59,-70},{-34,-70}}, color={0,0,127}));
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
end MEE_FC_ss;
