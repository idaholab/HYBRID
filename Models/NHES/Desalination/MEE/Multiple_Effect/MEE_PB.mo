within NHES.Desalination.MEE.Multiple_Effect;
model MEE_PB "Multi-Effect Evaporator"
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable MEE.CS.CS_Dummy CS,
    redeclare replaceable MEE.CS.ED_Dummy ED,
    redeclare replaceable Data.MEE_Data data);

  Single_Effect.Brine_Models.Single_Effect_pool Effect[data.nE](
    V=data.Vsys,
    A=data.Asys,
    Tsys=data.Tsys,
    m_brine_out=data.m_brine_outsys,
    dp=data.dpsys,
    Ax=data.Axsys,
    Do=data.Dosys,
    th=data.thsys,
    pT=data.pTsys,
    KV=data.KVsys,
    Ti=data.Tisys,
    k=data.ksys,
    nV=data.nVsys)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  NHES.Fluid.Valves.PressureCV PCV[data.nE](
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    Pressure_target=data.psys,
    ValvePos_start=0.5,
    init_time=0,
    PID_k=-1e-6,
    PID_Ti=2,
    m_flow_nominal=2,
    dp_nominal=data.psys - fill(0.1, data.nE))
    annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
    annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
    annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
    annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
  MEE.Components.GOR gOR annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-70})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Fluid.Utilities.MultiPort_nonScaling
    multiPort_nonScaling(redeclare package Medium =
        Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
    annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    p=200000,
    T=data.T_b_in,
    X={0.92,0.08},
    nPorts=data.nE)
    annotation (Placement(transformation(extent={{100,30},{80,50}})));

  NHES.Fluid.Valves.FlowCV  FCV[data.nE](
    redeclare package Medium = NHES.Media.SeaWater,
    Use_input=false,
    FlowRate_target=data.msys,
    m_flow_nominal=data.msys) if data.use_flowrates
    annotation (Placement(transformation(extent={{66,30},{46,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    p=10000,
    X={0.92,0.08},
    nPorts=data.nE)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  NHES.Fluid.Valves.LevelCV SCV[data.nE](
    redeclare package Medium = NHES.Media.SeaWater,
    Use_input=false,
    Level_target=data.Xsys,
    PID_k=-1,
    m_flow_nominal=4) if not data.use_flowrates
    annotation (Placement(transformation(extent={{66,56},{46,76}})));
  Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
    annotation (Placement(transformation(extent={{100,76},{80,96}})));
  MEE.Components.PreHeater preHeater(redeclare package Medium_1 =
        Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
        NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
    if data.use_preheater
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Fluid.Utilities.MultiPort_nonScaling                        multiPort_preheater(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      nPorts_b=data.nE) if data.use_preheater
    annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
equation
  connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
        points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

  if data.use_preheater then
    connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
    connect(preHeater.port_b1,PCV[data.nE].port_a);
    else
    connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
          0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
  end if;
  connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
          {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
  connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
          {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
  connect(return_res[1].port_a, sensor_m_flow.port_a)
    annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
  connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
          -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                               color={0,0,127}));
  connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
          {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
          127}));
  connect(inlet_res[1].port_a, port_a_steam)
    annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, port_b_liquid_return)
    annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
  connect(sensor_m_flow1.port_a, port_b_liquid_cond)
    annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
  connect(multiPort_nonScaling.ports_b, PCV.port_b)
    annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
  connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
    annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

    if data.use_flowrates then

      if data.use_preheater then
    connect(FCV.port_b, Effect.Brine_Inlet_Port);
    connect(Brine_Source.ports[1],  preHeater.port_a2);
    connect(multiPort_preheater.ports_b,   FCV.port_a);
    else
  connect(FCV.port_b, Effect.Brine_Inlet_Port)
    annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
  connect(Brine_Source.ports, FCV.port_a)
    annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
      end if;

    else

      if data.use_preheater then
    connect(SCV.port_b, Effect.Brine_Inlet_Port);
    connect(Brine_Source.ports[1],   preHeater.port_a2);
    connect(multiPort_preheater.ports_b,   SCV.port_a);
    else
  connect(SCV.port_b, Effect.Brine_Inlet_Port)
    annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
  connect(Brine_Source.ports, SCV.port_a)
    annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
    end if;
    end if;

  connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
    annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

  connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
    annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
          127,255}));
  connect(X.y, SCV.level_input)
    annotation (Line(points={{79,86},{64,86},{64,74}}, color={0,0,127}));
  connect(multiPort_preheater.port_a, preHeater.port_b2)
    annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
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
<p><br>MEE model that assumes nucleate condensing in the HX.</p><p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end MEE_PB;
