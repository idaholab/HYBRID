within NHES.Systems.HeatTransport.Examples;
model HTtest2
  extends Modelica.Icons.Example;
  OneWayTransport oneWayTransport(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    nominal_m_flow_supply=5,
    nominal_P_sink_supply=250000,
    nominal_h_sink_supply=2969.5e3,
    S_use_T_start=true,
    S_T_a_start=523.15,
    S_T_b_start=523.15,
    Supply(p_a_start=300000, p_b_start=300000))
    annotation (Placement(transformation(extent={{-40,-16},{40,64}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    m_flow=5,
    T=523.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=250000,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,14},{80,34}})));
equation
  connect(boundary.ports[1], oneWayTransport.port_a_supply)
    annotation (Line(points={{-80,24},{-40,24}}, color={0,127,255}));
  connect(oneWayTransport.port_b_supply, boundary3.ports[1])
    annotation (Line(points={{40,24},{80,24}}, color={0,127,255}));
  annotation (experiment(
      StopTime=1000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end HTtest2;
