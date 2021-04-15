within NHES.Systems.IndustrialProcess.HeaderTurbineCombo.Examples;
model Test2
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=IP.data.p_HP,
    T=IP.data.T_HP,
    use_p_in=false)
    annotation (Placement(transformation(extent={{-128,38},{-108,58}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=IP.data.p_LP,
    T=IP.data.T_LP)
    annotation (Placement(transformation(extent={{-128,-42},{-108,-22}})));
  StepDownTurbine IP(
    port_a_nominal(
      p=IP.data.p_HP,
      h=IP.data.h_HP,
      m_flow=IP.data.m_flow_total),
    port_b_nominal(p=IP.data.p_IP, h=IP.data.h_IP))
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  TRANSFORM.Electrical.Grid grid(Q_nominal=1e10, droop=0.01)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  StepDownTurbine IP1(
    port_a_nominal(
      p=IP.data.p_IP,
      h=IP.data.h_IP,
      m_flow=IP.data.m_flow_HP),
    port_b_nominal(p=IP.data.p_LP, h=IP.data.h_LP))
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
equation
  connect(IP.portElec, grid.port) annotation (Line(points={{-20,20},{0,20},{0,
          0},{20,0}}, color={255,0,0}));
  connect(IP.port_a, boundary.ports[1]) annotation (Line(points={{-40,24},{
          -74,24},{-74,48},{-108,48}}, color={0,127,255}));
  connect(IP1.portElec, grid.port) annotation (Line(points={{-20,-20},{0,-20},
          {0,0},{20,0}}, color={255,0,0}));
  connect(IP.port_b, IP1.port_a) annotation (Line(points={{-40,15.8},{-44,
          15.8},{-44,16},{-48,16},{-48,-16},{-40,-16}}, color={0,127,255}));
  connect(IP1.port_b, boundary1.ports[1]) annotation (Line(points={{-40,-24.2},
          {-74,-24.2},{-74,-32},{-108,-32}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false));
end Test2;
