within NHES.Desalination.MEE.Examples;
model Single_Effect_pool "Test of a single effect with constant UA"

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=70000,
    nPorts=1) annotation (Placement(transformation(extent={{-6,38},{-26,58}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=1,
    h=2725.9e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-146,-60},{-126,-40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-6,-60},{-26,-40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    p=10000,
    X={0.92,0.08},
    nPorts=1)
    annotation (Placement(transformation(extent={{-148,-20},{-128,0}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    use_m_flow_in=false,
    use_X_in=false,
    m_flow=4,
    T=353.15,
    X={0.92,0.08},
    nPorts=1) annotation (Placement(transformation(extent={{-8,-20},{-28,0}})));

  MEE.Single_Effect.Brine_Models.Single_Effect_pool single_Effect_pool(
    V=50,
    A=1,
    Ax=2e4,
    pT=100000)
    annotation (Placement(transformation(extent={{-114,-40},{-56,18}})));
equation
  connect(single_Effect_pool.Brine_Inlet_Port, boundary3.ports[1])
    annotation (Line(points={{-56,-11},{-43,-11},{-43,-10},{-28,-10}},
        color={0,127,255}));
  connect(single_Effect_pool.Steam_Outlet_Port, Steam_Exit2.ports[1])
    annotation (Line(points={{-85,18},{-88,18},{-88,48},{-26,48}}, color={0,
          127,255}));
  connect(single_Effect_pool.Brine_Outlet_Port, boundary2.ports[1])
    annotation (Line(points={{-114,-11},{-122,-11},{-122,-10},{-128,-10}},
        color={0,127,255}));
  connect(single_Effect_pool.Tube_Inlet, Tube_Inlet2.ports[1]) annotation (
      Line(points={{-113.42,-22.6},{-124,-22.6},{-124,-36},{-122,-36},{-122,
          -50},{-126,-50}}, color={0,127,255}));
  connect(single_Effect_pool.Tube_Outlet, Brine_Oulet1.ports[1])
    annotation (Line(points={{-55.42,-22.6},{-32,-22.6},{-32,-50},{-26,-50}},
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
end Single_Effect_pool;
