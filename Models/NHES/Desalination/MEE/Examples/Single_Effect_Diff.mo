within NHES.Desalination.MEE.Examples;
model Single_Effect_Diff "Test of a single effect with constant UA"

  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph Brine_Oulet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph Steam_Exit(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=70000,
    nPorts=1) annotation (Placement(transformation(extent={{22,50},{2,70}})));
  Single_Effect.Water_Models.Single_Effect_W sEE_mkUA(
    Psys=70000,
    V=0.5,
    A=1,
    KV=-0.03,
    Ax=2.68e4,
    pT=100000)
    annotation (Placement(transformation(extent={{-80,-30},{-20,30}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_h Tube_Inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=1.5,
    h=2725.9e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph Brine_Oulet1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    nPorts=1) annotation (Placement(transformation(extent={{22,-48},{2,-28}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_h Brine_Inlet1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=4,
    h=335000,
    nPorts=1) annotation (Placement(transformation(extent={{20,-12},{0,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0.08)
                                                                annotation (Placement(transformation(extent={{20,8},{
            0,28}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph Steam_Exit1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=70000,
    nPorts=1) annotation (Placement(transformation(extent={{182,48},{162,68}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_h Tube_Inlet1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=1,
    h=2725.9e3,
    nPorts=1) annotation (Placement(transformation(extent={{42,-50},{62,-30}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph Brine_Oulet2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{182,-50},{162,-30}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),

    p=10000,
    X={0.92,0.08},
    nPorts=1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),

    use_m_flow_in=false,
    use_X_in=false,
    m_flow=4,
    T=353.15,
    X={0.92,0.08},
    nPorts=1)
    annotation (Placement(transformation(extent={{180,-10},{160,10}})));

  Single_Effect.Brine_Models.Single_Effect single_Effect(
    V=0.5,
    A=1,
    Ax=2e4,
    pT=100000)
    annotation (Placement(transformation(extent={{72,-30},{130,28}})));
equation
  connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
      Line(points={{-80,0},{-100,0}},         color={0,127,255}));
  connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-100,
          -40},{-88,-40},{-88,-12},{-79.4,-12}},         color={0,127,255}));
  connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
        points={{2,-38},{-10,-38},{-10,-12},{-19.4,-12}},  color={0,127,255}));
  connect(realExpression1.y, sEE_mkUA.Cs_In) annotation (Line(points={{-1,18},
          {-12,18},{-12,6},{-20,6}},       color={0,0,127}));
  connect(Brine_Inlet1.ports[1], sEE_mkUA.Brine_Inlet_Port) annotation (
      Line(points={{0,-2},{-10,-2},{-10,0},{-20,0}},     color={0,127,255}));
  connect(sEE_mkUA.Steam_Outlet_Port, Steam_Exit.ports[1]) annotation (Line(
        points={{-50,30},{-50,60},{2,60}}, color={0,127,255}));
  connect(single_Effect.Brine_Inlet_Port, boundary1.ports[1]) annotation (
      Line(points={{130,-1},{146,-1},{146,0},{160,0}}, color={0,127,255}));
  connect(single_Effect.Steam_Outlet_Port, Steam_Exit1.ports[1])
    annotation (Line(points={{101,28},{102,28},{102,58},{162,58}}, color={0,
          127,255}));
  connect(single_Effect.Brine_Outlet_Port, boundary.ports[1]) annotation (
      Line(points={{72,-1},{66,-1},{66,4},{60,4},{60,0}}, color={0,127,255}));
  connect(single_Effect.Tube_Inlet, Tube_Inlet1.ports[1]) annotation (Line(
        points={{72.58,-12.6},{64,-12.6},{64,-26},{66,-26},{66,-40},{62,-40}},
        color={0,127,255}));
  connect(single_Effect.Tube_Outlet, Brine_Oulet2.ports[1]) annotation (
      Line(points={{130.58,-12.6},{148.29,-12.6},{148.29,-40},{162,-40}},
        color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),                               graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=500,
      Interval=0.5,
      __Dymola_Algorithm="Esdirk45a"));
end Single_Effect_Diff;
