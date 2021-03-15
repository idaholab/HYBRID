within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_L1_FMU
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries         BOP(
    nPorts_a3=1,
    port_a_nominal(
      m_flow=67,
      p=3470000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=1000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.CS_OTSG_TCV_Pressure_TBV_Power_Control
      CS(
      delayStartTCV=20,
      p_nominal=3447400,
      W_totalSetpoint=BOP_Demand))
    annotation (Placement(transformation(extent={{-18,-30},{42,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(use_port=false,
                                              f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    use_T_in=false,
    nPorts=1,
    p(displayUnit="MPa") = BOP.port_b_nominal.p,
    T(displayUnit="K") = BOP.port_b_nominal.T)
    annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-72,-52},{-28,-22}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-72,20},{-28,50}})));
  Modelica.Fluid.Sources.MassFlowSource_h source1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_m_flow_in=false,
    h=3e6)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Fluid.Sources.MassFlowSource_h source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_h_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
  Modelica.Blocks.Interfaces.RealInput Enthalpy
    annotation (Placement(transformation(extent={{-140,-8},{-100,32}})));
  Modelica.Blocks.Interfaces.RealInput mass_flow
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput enthalpy_out
    annotation (Placement(transformation(extent={{-100,-58},{-124,-34}})));
  Modelica.Blocks.Interfaces.RealOutput pressure_out
    annotation (Placement(transformation(extent={{-100,-92},{-124,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Power
    annotation (Placement(transformation(extent={{100,48},{124,72}})));
  Modelica.Blocks.Interfaces.RealOutput freq
    annotation (Placement(transformation(extent={{100,8},{124,32}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=BOP.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-64,-72},{-84,-52}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=BOP.port_b.p)
    annotation (Placement(transformation(extent={{-64,-90},{-84,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=BOP.portElec_b.W)
    annotation (Placement(transformation(extent={{62,50},{82,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=BOP.portElec_b.f)
    annotation (Placement(transformation(extent={{64,18},{84,38}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=BOP.port_a.p)
    annotation (Placement(transformation(extent={{-66,60},{-86,80}})));
  Modelica.Blocks.Interfaces.RealOutput port_inlet_pressure
    "This is a feedback of the pressure going into the balance of plant"
    annotation (Placement(transformation(extent={{-100,60},{-124,84}})));
  Modelica.Blocks.Interfaces.RealInput BOP_Demand annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-50,-40.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
  connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
          {-64,-12},{-60,-12}}, color={0,127,255}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-40,-12},{-18,-12}}, color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-40,12},{-18,12}}, color={0,127,255}));
  connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{-20,-80},
          {0,-80},{0,-30}},     color={0,127,255}));
  connect(source.ports[1], stateSensor1.port_a)
    annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{42,0},{70,0}}, color={255,0,0}));
  connect(Enthalpy, source.h_in) annotation (Line(points={{-120,12},{-96,12},{
          -96,16},{-90,16}}, color={0,0,127}));
  connect(realExpression.y, enthalpy_out) annotation (Line(points={{-85,-62},{
          -92,-62},{-92,-46},{-112,-46}}, color={0,0,127}));
  connect(realExpression1.y, pressure_out)
    annotation (Line(points={{-85,-80},{-112,-80}}, color={0,0,127}));
  connect(realExpression2.y, Power)
    annotation (Line(points={{83,60},{112,60}}, color={0,0,127}));
  connect(realExpression3.y, freq) annotation (Line(points={{85,28},{88,28},{88,
          20},{112,20}}, color={0,0,127}));
  connect(mass_flow, source.m_flow_in) annotation (Line(points={{-120,40},{-96,
          40},{-96,20},{-88,20}}, color={0,0,127}));
  connect(realExpression4.y, port_inlet_pressure) annotation (Line(points={{-87,
          70},{-94,70},{-94,72},{-112,72}}, color={0,0,127}));
  annotation (experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_L1_FMU;
