within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model HP_Tester

  HeatPipe_Limited_Connectable heatPipe_Limited_Connectable
    annotation (Placement(transformation(extent={{-58,-20},{-6,30}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(
      use_port=true, Q_flow=110)
    annotation (Placement(transformation(extent={{-138,-2},{-118,18}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary1(
      use_port=false, T=698.15)
    annotation (Placement(transformation(extent={{48,-2},{28,18}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=3900,
    duration=600,
    offset=100,
    startTime=600)
    annotation (Placement(transformation(extent={{-172,-2},{-152,18}})));
equation
  connect(boundary.port, heatPipe_Limited_Connectable.port_evaporator)
    annotation (Line(points={{-118,8},{-66,8},{-66,13},{-56.44,13}}, color={191,
          0,0}));
  connect(heatPipe_Limited_Connectable.port_condenser, boundary1.port)
    annotation (Line(points={{-8.6,12.5},{22,12.5},{22,8},{28,8}}, color={191,0,
          0}));
  connect(boundary.Q_flow_ext, ramp.y)
    annotation (Line(points={{-132,8},{-151,8}}, color={0,0,127}));
end HP_Tester;
