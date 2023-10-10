within NHES.Desalination.MEE.Multiple_Effect;
model MEE_FC_ss_UTextnode "Multi-Effect Evaporator"
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable MEE.CS.CS_Dummy CS,
    redeclare replaceable MEE.CS.ED_Dummy ED,
    redeclare replaceable Data.MEE_Data data);

 parameter Modelica.Units.SI.MassFraction Cs_in=0.08;
 parameter Modelica.Units.SI.MassFraction Cs_out=data.X_nom;
 replaceable package Medium = Modelica.Media.Water.StandardWater;
 replaceable package MediumB = NHES.Media.SeaWater;
 final parameter Modelica.Units.SI.Area[data.nE] Ax(fixed=false)=fill(10,
    data.nE);
 parameter Real [2] Xin={1-Cs_in,Cs_in};
 parameter Integer nV=5;
 parameter Modelica.Units.SI.SpecificEnthalpy h_input=2700e3 annotation(Dialog(group="1st Effect Nominal Inlet"));
 parameter Modelica.Units.SI.MassFlowRate m_flow_input=2 annotation(Dialog(group="1st Effect Nominal Inlet"));
 parameter Modelica.Units.SI.AbsolutePressure p_input=2e5 annotation(Dialog(group="1st Effect Nominal Inlet"));
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
 final parameter Modelica.Units.SI.Temperature [data.nE,nV] T_tube(fixed=false)=fill(400,data.nE,nV);
 final parameter Modelica.Units.SI.Temperature [data.nE] T(fixed=false)=fill(400,data.nE);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_f(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE,nV] h_in(fixed=false)=fill(3000e3,data.nE,nV);
 final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE,nV] h_out(fixed=false)=fill(600e3,data.nE,nV);
 final parameter Modelica.Units.SI.AbsolutePressure [data.nE] p(fixed=false)=fill(1e5,data.nE);
 final parameter Modelica.Units.SI.CoefficientOfHeatTransfer [data.nE] U(fixed=false)=fill(600e3,data.nE);
 final parameter Modelica.Units.SI.Power [data.nE,nV] Q(fixed=false)=fill(600e3,data.nE,nV);
 final parameter Modelica.Units.SI.MassFlowRate [data.nE] mdot(fixed=false)=fill(1,data.nE);
 final parameter Modelica.Units.SI.AbsolutePressure [data.nE] pT(fixed=false)=fill(1e5,data.nE);
 final parameter Modelica.Units.SI.SpecificEnergy [data.nE] chemp(fixed=false)=fill(30,data.nE);
 final parameter Modelica.Units.SI.SpecificGibbsFreeEnergy [data.nE] gW(fixed=false)=fill(30,data.nE);
 Modelica.Units.SI.MassFlowRate Cond_out;
  Real GOR;
  Components.MEE_SS mEE_innernodelized(
    Cs_in=Cs_in,
    Cs_out=Cs_out,
    Ax=Ax,
    nE=data.nE,
    X_nom=data.X_nom,
    psys=data.psys,
    h_input=sensor_h.h_out,
    m_flow_input=sensor_m_flow.m_flow,
    p_input=sensor_p.p,
    nV=nV,
    delay(y_start=mdot[2:data.nE]))
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph steam_in(
    redeclare package Medium = Medium,
    use_p_in=true,
    h=2700e3,
    nPorts=1) annotation (Placement(transformation(extent={{0,50},{-20,70}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h liquid_return(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_h_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=mEE_innernodelized.h_out[
        1, mEE_innernodelized.nV])
    annotation (Placement(transformation(extent={{0,-74},{-20,-54}})));
initial equation

  Xo[2]=Cs_out;
  Xo[1]=1-Cs_out;
  mdot[1]=m_flow_input;
  p_input = pT[1];
  h_in[1,1] =h_input;
  p=data.psys;
 for j in 2:data.nE loop
   pT[j]=p[j-1];
   mdot[j]=-m_steam[j-1];
   h_in[j,1]=h_steam[j-1];
 end for;
 for i in 1:data.nE loop
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
  h_out[i,nV]=h_f[i];
     for z in 2:nV loop
  h_in[i,z]=h_out[i,z-1];
   end for;
   for k in 1:nV loop
  T_tube[i,k]=Medium.temperature_ph(pT[i],h_in[i,k]);
  h_out[i,k]=h_in[i,k]-(Q[i,k]/mdot[i]);
  Q[i,k]=(Ax[i]/nV)*U[i]*(T_tube[i,k]-T[i]);
   end for;
  Qhx[i]=sum(Q[i,:]);
 end for;
equation
  Cond_out=abs(sum(-mEE_innernodelized.m_steam[:]));
  GOR=abs(Cond_out/port_a.m_flow);

  connect(port_a, sensor_m_flow.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, sensor_h.port)
    annotation (Line(points={{-60,60},{-40,60}}, color={0,127,255}));
  connect(sensor_h.port,steam_in. ports[1])
    annotation (Line(points={{-40,60},{-20,60}}, color={0,127,255}));
  connect(port_b, sensor_p.port)
    annotation (Line(points={{-100,-60},{-80,-60}}, color={0,127,255}));
  connect(sensor_p.port, liquid_return.ports[1])
    annotation (Line(points={{-80,-60},{-60,-60}}, color={0,127,255}));
  connect(sensor_m_flow.m_flow, liquid_return.m_flow_in) annotation (Line(
        points={{-70,63.6},{-70,84},{40,84},{40,-52},{-40,-52}}, color={0,0,127}));
  connect(sensor_p.p,steam_in. p_in) annotation (Line(points={{-74,-50},{-66,-50},
          {-66,32},{22,32},{22,68},{2,68}}, color={0,0,127}));
  connect(realExpression.y, liquid_return.h_in) annotation (Line(points={{-21,-64},
          {-28,-64},{-28,-56},{-38,-56}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=500,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p><br>MEE model that assumes steady state evaporators.</p><p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end MEE_FC_ss_UTextnode;
