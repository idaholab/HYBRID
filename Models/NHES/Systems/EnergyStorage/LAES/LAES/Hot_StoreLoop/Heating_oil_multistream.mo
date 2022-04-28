within NHES.Systems.EnergyStorage.LAES.LAES.Hot_StoreLoop;
model Heating_oil_multistream
  "Test to show Expansion from a Liquid Air system works"
  import LAES_INL =
         NHES.Systems.EnergyStorage.LAES;
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650,
    p=100000,
    T(displayUnit="K") = 288,
    nPorts=1) annotation (Placement(transformation(extent={{-96,-14},{-76,6}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
    redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650,
    m_flow=-43,
    h=1e5,
    nPorts=1) annotation (Placement(transformation(extent={{68,12},{48,32}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650, allowFlowReversal=
        true)
    annotation (Placement(transformation(extent={{-66,-22},{-46,-42}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume evaporator(
    redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650,
    p_start=100000,
    T_start=288.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-18,32},{2,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(Q_flow(
        displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-34,32},{-14,52}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume reheater(
    redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650,
    p_start=100000,
    T_start=288.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-18,-30},{2,-10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(Q_flow(
        displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-34,-52},{-14,-32}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650, allowFlowReversal=
        true)
    annotation (Placement(transformation(extent={{22,30},{42,50}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650, allowFlowReversal=
        true)
    annotation (Placement(transformation(extent={{24,-28},{44,-48}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(redeclare package Medium
      = Modelica.Media.Incompressible.Examples.Essotherm650, p_nominal=110000)
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
      package Medium = Modelica.Media.Incompressible.Examples.Essotherm650, dp0=
       10000) annotation (Placement(transformation(extent={{-42,12},{-22,32}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance1(redeclare
      package Medium = Modelica.Media.Incompressible.Examples.Essotherm650, dp0=
       10000)
    annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary4(
    redeclare package Medium =
        Modelica.Media.Incompressible.Examples.Essotherm650,
    m_flow=-47,
    h=1e5,
    nPorts=1) annotation (Placement(transformation(extent={{68,-30},{48,-10}})));
equation
  connect(boundary2.port, evaporator.heatPort)
    annotation (Line(points={{-14,42},{-8,42},{-8,28}}, color={191,0,0}));
  connect(boundary3.port, reheater.heatPort)
    annotation (Line(points={{-14,-42},{-8,-42},{-8,-26}}, color={191,0,0}));
  connect(evaporator.port_b, boundary1.ports[1])
    annotation (Line(points={{-2,22},{48,22}}, color={0,127,255}));
  connect(evaporator.port_b, sensor_T2.port)
    annotation (Line(points={{-2,22},{32,22},{32,30}}, color={0,127,255}));
  connect(reheater.port_b, sensor_T3.port)
    annotation (Line(points={{-2,-20},{34,-20},{34,-28}}, color={0,127,255}));
  connect(boundary.ports[1], pump.port_a)
    annotation (Line(points={{-76,-4},{-76,-2},{-68,-2}}, color={0,127,255}));
  connect(pump.port_b, resistance.port_a) annotation (Line(points={{-48,-2},{
          -46,-2},{-46,22},{-39,22}}, color={0,127,255}));
  connect(resistance.port_b, evaporator.port_a)
    annotation (Line(points={{-25,22},{-14,22}}, color={0,127,255}));
  connect(resistance1.port_b, reheater.port_a)
    annotation (Line(points={{-23,-20},{-14,-20}}, color={0,127,255}));
  connect(pump.port_b, resistance1.port_a) annotation (Line(points={{-48,-2},{
          -46,-2},{-46,-20},{-37,-20}}, color={0,127,255}));
  connect(sensor_T1.port, pump.port_b) annotation (Line(points={{-56,-22},{-54,
          -22},{-54,-20},{-48,-20},{-48,-2}}, color={0,127,255}));
  connect(reheater.port_b, boundary4.ports[1])
    annotation (Line(points={{-2,-20},{48,-20}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=360,
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
end Heating_oil_multistream;
