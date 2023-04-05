within NHES.Systems.IndustrialProcess.IS_Dummy.Examples;
model Test_IP_Dummy
  extends Modelica.Icons.Example;

  Components.IS_Dummy_connections
                  iS_Dummy_connections
    annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ExternalPressue(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-108,-58},{-88,-38}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Inflow(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_T_in=true,
    m_flow=15,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,30},{-92,50}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=8,
    rising=300,
    width=600,
    falling=300,
    period=1800,
    offset=1,
    startTime=400)
    annotation (Placement(transformation(extent={{-182,34},{-162,54}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=20,
    f=1/220,
    phase=0,
    offset=573.15,
    startTime=600)
    annotation (Placement(transformation(extent={{-192,-6},{-172,14}})));
equation
  connect(Inflow.ports[1], iS_Dummy_connections.port_a) annotation (Line(points={{-92,40},
          {-50,40},{-50,19.6},{-40.8,19.6}},          color={0,127,255}));
  connect(ExternalPressue.ports[1], iS_Dummy_connections.port_b) annotation (
      Line(points={{-88,-48},{-48,-48},{-48,-21.2},{-40.8,-21.2}}, color={0,127,
          255}));
  connect(trapezoid.y, Inflow.m_flow_in) annotation (Line(points={{-161,44},{
          -122,44},{-122,48},{-112,48}}, color={0,0,127}));
  connect(sine.y, Inflow.T_in) annotation (Line(points={{-171,4},{-150,4},{-150,
          32},{-114,32},{-114,44}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end Test_IP_Dummy;
