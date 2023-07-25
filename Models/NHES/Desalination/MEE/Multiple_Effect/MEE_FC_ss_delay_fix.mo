within NHES.Desalination.MEE.Multiple_Effect;
model MEE_FC_ss_delay_fix "Multi-Effect Evaporator"
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
  Modelica.Blocks.Continuous.FirstOrder firstOrder[data.nE - 1](T=tau, y_start=1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  parameter SI.Time tau=5 "Time Constant";
  parameter SI.Area [data.nE] Ax=fill(1e4, data.nE);
  Modelica.Blocks.Sources.RealExpression steament[data.nE - 1](y=
        evaporator_Brine_SHP_ss[1:data.nE - 1].h_steam)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1[data.nE - 1](T=tau, y_start=
        3000e3)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Components.SEE_Tube_Side_PoolBoiling HX(p_start=200000, Ax=Ax[1])
                                          annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-122,0})));
  Components.SEE_Tube_Side_PoolBoiling_portlesss HXs[data.nE - 1](p_start=data.psys[
        1:data.nE - 1], Ax=Ax[2:data.nE])
    annotation (Placement(transformation(extent={{-22,-116},{18,-76}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_h boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    h=3500e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-180,30},{-160,50}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    h=3500e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-226,-76},{-206,-56}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=2000,
    offset=1,
    startTime=2000)
    annotation (Placement(transformation(extent={{-256,34},{-236,54}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
               Modelica.Media.Water.StandardWater, use_input=true)
    annotation (Placement(transformation(extent={{-154,-76},{-174,-56}})));
equation

  Cond_out=abs(sum(evaporator_Brine_SHP_ss.m_steam));
  GOR=abs(Cond_out/port_a.m_flow);

  // middle effects
  HXs[:].h_input =firstOrder1[:].y;
  HXs[:].m_flow_input =firstOrder[:].y;

  HXs[:].pT =data.psys[1:data.nE-1];

  connect(steamflow.y, firstOrder.u)
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(steament.y, firstOrder1.u)
    annotation (Line(points={{-79,-30},{-62,-30}}, color={0,0,127}));
  connect(HX.Steam_Inlet_Port, port_a) annotation (Line(points={{-122,20},{-122,
          60},{-100,60}}, color={0,127,255}));
  connect(HX.Liquid_Outlet_Port, port_b) annotation (Line(points={{-122,-20},{-122,
          -60},{-100,-60}}, color={0,127,255}));
  connect(HX.Heat_Port, evaporator_Brine_SHP_ss[1].Heat_Port) annotation (Line(
        points={{-112,-1.77636e-15},{-74,-1.77636e-15},{-74,-50},{0,-50},{0,-40}},
        color={191,0,0}));
  connect(HXs.Heat_Port, evaporator_Brine_SHP_ss[2:data.nE].Heat_Port)
    annotation (Line(points={{-2,-86},{-2,-64},{0,-64},{0,-42}},
                                               color={191,0,0}));
  connect(boundary.ports[1], HX.Steam_Inlet_Port) annotation (Line(points={
          {-160,40},{-122,40},{-122,20}}, color={0,127,255}));
  connect(ramp.y, boundary.m_flow_in) annotation (Line(points={{-235,44},{
          -190,44},{-190,48},{-180,48}}, color={0,0,127}));
  connect(boundary1.ports[1], pump.port_b)
    annotation (Line(points={{-206,-66},{-174,-66}}, color={0,127,255}));
  connect(pump.port_a, HX.Liquid_Outlet_Port) annotation (Line(points={{
          -154,-66},{-122,-66},{-122,-20}}, color={0,127,255}));
  connect(ramp.y, pump.in_m_flow) annotation (Line(points={{-235,44},{-190,
          44},{-190,-48},{-164,-48},{-164,-58.7}}, color={0,0,127}));
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
end MEE_FC_ss_delay_fix;
