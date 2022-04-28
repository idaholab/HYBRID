within NHES.Systems.EnergyStorage.LAES.LAES.Discharging;
model Reheating_Test "Test to show Expansion from a Liquid Air system works"
  import LAES_INL =
         NHES.Systems.EnergyStorage.LAES;
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    p=100000,
    T=78.15,
    nPorts=1) annotation (Placement(transformation(extent={{-92,-16},{-72,4}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    m_flow=-201,
    h=1e5,
    nPorts=1) annotation (Placement(transformation(extent={{92,-88},{72,-68}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(redeclare package Medium
      = LAES_INL.LAES.Media.AirCoolProp, p_nominal=7500000)
    annotation (Placement(transformation(extent={{-52,-16},{-32,4}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-32,4},{-12,24}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Media.AirCoolProp, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
    annotation (Placement(transformation(extent={{-28,-16},{-8,-36}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume evaporator(
    redeclare package Medium = Media.AirCoolProp,
    p_start=pump.p_nominal,
    T_start=75.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-12,6},{8,-14}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(Q_flow(
        displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-46,30},{-26,50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume reheater(
    redeclare package Medium = Media.AirCoolProp,
    p_start=evaporator.p_start,
    T_start=evaporator.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{14,6},{34,-14}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(Q_flow(
        displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-6,46},{14,66}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{2,4},{22,24}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{34,4},{54,24}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume superheater(
    redeclare package Medium = Media.AirCoolProp,
    p_start=evaporator.p_start,
    T_start=evaporator.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-82,-60},{-62,-80}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(Q_flow(
        displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-108,-50},{-88,-30}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-64,-76},{-44,-96}})));
equation
  connect(boundary.ports[1], pump.port_a)
    annotation (Line(points={{-72,-6},{-52,-6}}, color={0,127,255}));
  connect(sensor_T1.port, pump.port_b)
    annotation (Line(points={{-22,4},{-22,-6},{-32,-6}}, color={0,127,255}));
  connect(pump.port_b, sensor_p.port)
    annotation (Line(points={{-32,-6},{-18,-6},{-18,-16}}, color={0,127,255}));
  connect(boundary2.port, evaporator.heatPort)
    annotation (Line(points={{-26,40},{-2,40},{-2,2}}, color={191,0,0}));
  connect(pump.port_b, evaporator.port_a) annotation (Line(points={{-32,-6},{
          -16,-6},{-16,-4},{-8,-4}}, color={0,127,255}));
  connect(boundary3.port, reheater.heatPort)
    annotation (Line(points={{14,56},{24,56},{24,2}}, color={191,0,0}));
  connect(evaporator.port_b, reheater.port_a)
    annotation (Line(points={{4,-4},{18,-4}}, color={0,127,255}));
  connect(sensor_T3.port, reheater.port_b)
    annotation (Line(points={{44,4},{44,-4},{30,-4}}, color={0,127,255}));
  connect(sensor_T2.port, evaporator.port_b)
    annotation (Line(points={{12,4},{12,-4},{4,-4}}, color={0,127,255}));
  connect(boundary4.port, superheater.heatPort)
    annotation (Line(points={{-88,-40},{-72,-40},{-72,-64}}, color={191,0,0}));
  connect(reheater.port_b, superheater.port_a) annotation (Line(points={{30,-4},
          {52,-4},{52,-50},{-86,-50},{-86,-70},{-78,-70}}, color={0,127,255}));
  connect(superheater.port_b, boundary1.ports[1]) annotation (Line(points={{-66,
          -70},{-26,-70},{-26,-78},{72,-78}}, color={0,127,255}));
  connect(sensor_T4.port, superheater.port_b) annotation (Line(points={{-54,-76},
          {-54,-70},{-66,-70}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=18000,
      Interval=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
end Reheating_Test;
