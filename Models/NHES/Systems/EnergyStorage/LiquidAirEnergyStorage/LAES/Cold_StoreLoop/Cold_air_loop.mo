within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES.Cold_StoreLoop;
model Cold_air_loop "Test to show Expansion from a Liquid Air system works"
  import LAES_INL =
         NHES.Systems.EnergyStorage.LiquidAirEnergyStorage;
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    p=100000,
    T(displayUnit="K") = 288,
    nPorts=1) annotation (Placement(transformation(extent={{72,-12},{52,8}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    use_m_flow_in=false,
    m_flow=90.81,
    T=561.15,
    nPorts=1) annotation (Placement(transformation(extent={{-96,-12},{-76,8}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(Q_flow(
        displayUnit="MW") = 2000000)
    annotation (Placement(transformation(extent={{-36,6},{-16,26}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
        LAES_INL.LAES.Media.AirCoolProp,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{26,12},{46,32}})));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance1(redeclare
      package Medium = LAES_INL.LAES.Media.AirCoolProp,               dp0=10000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-40,-2})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium
      = LAES_INL.LAES.Media.AirCoolProp)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,-2})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-20,8},{0,-12}})));
equation
  connect(resistance1.port_b, volume.port_a)
    annotation (Line(points={{-33,-2},{-16,-2}}, color={0,127,255}));
  connect(volume.port_b, sensor_m_flow1.port_a)
    annotation (Line(points={{-4,-2},{8,-2}}, color={0,127,255}));
  connect(sensor_m_flow1.port_b, boundary.ports[1])
    annotation (Line(points={{28,-2},{52,-2}}, color={0,127,255}));
  connect(boundary1.ports[1], resistance1.port_a)
    annotation (Line(points={{-76,-2},{-47,-2}}, color={0,127,255}));
  connect(boundary2.port, volume.heatPort)
    annotation (Line(points={{-16,16},{-10,16},{-10,4}}, color={191,0,0}));
  connect(sensor_m_flow1.port_b, sensor_T2.port)
    annotation (Line(points={{28,-2},{36,-2},{36,12}}, color={0,127,255}));
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
end Cold_air_loop;
