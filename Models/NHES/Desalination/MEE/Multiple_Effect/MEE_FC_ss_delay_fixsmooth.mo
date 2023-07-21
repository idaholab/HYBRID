within NHES.Desalination.MEE.Multiple_Effect;
model MEE_FC_ss_delay_fixsmooth "Multi-Effect Evaporator"
  extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable Data.MEE_Data data);

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
  parameter SI.MassFraction Cs_in=0.08;
  parameter SI.MassFraction [2] Xin={(1-Cs_in),Cs_in};
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
  Modelica.Blocks.Sources.RealExpression steamflow[data.nE - 1](y=-
        evaporator_Brine_SHP_ss[1:data.nE - 1].m_steam)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  parameter SI.Time tau=5 "Time Constant";
  parameter SI.Area [data.nE] Ax=fill(1e4, data.nE);
  Modelica.Blocks.Sources.RealExpression steament[data.nE - 1](y=
        evaporator_Brine_SHP_ss[1:data.nE - 1].h_steam)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Components.SEE_Tube_Side_PoolBoiling_smooth
                                       HX(p_start=200000, Ax=Ax[1])
                                          annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-122,0})));
  Components.SEE_Tube_Side_PoolBoiling_smooth_portless
                                                 HXs[data.nE - 1](p_start=data.psys[
        1:data.nE - 1], Ax=Ax[2:data.nE])
    annotation (Placement(transformation(extent={{-20,-114},{20,-74}})));
equation

  Cond_out=abs(sum(evaporator_Brine_SHP_ss.m_steam));
  GOR=abs(Cond_out/port_a.m_flow);

  // middle effects
  HXs[:].h_input =steament[:].y;
  HXs[:].m_flow_input =steamflow[:].y;

  HXs[:].pT =data.psys[1:data.nE-1];

  connect(HX.Steam_Inlet_Port, port_a) annotation (Line(points={{-122,20},{-122,
          60},{-100,60}}, color={0,127,255}));
  connect(HX.Liquid_Outlet_Port, port_b) annotation (Line(points={{-122,-20},{-122,
          -60},{-100,-60}}, color={0,127,255}));
  connect(HX.Heat_Port, evaporator_Brine_SHP_ss[1].Heat_Port) annotation (Line(
        points={{-112,-1.77636e-15},{-74,-1.77636e-15},{-74,-50},{0,-50},{0,-40}},
        color={191,0,0}));
  connect(HXs.Heat_Port, evaporator_Brine_SHP_ss[2:data.nE].Heat_Port)
    annotation (Line(points={{0,-84},{0,-42}}, color={191,0,0}));
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
end MEE_FC_ss_delay_fixsmooth;
