within NHES.Systems.EnergyStorage.LAES.LAES.Discharging;
model Turbine_Expansion_Test
  "Test to show Expansion from a Liquid Air system works"
  import LAES_INL =
         NHES.Systems.EnergyStorage.LAES;
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    p=100000,
    T=78.15,
    nPorts=1) annotation (Placement(transformation(extent={{-96,26},{-76,46}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
    redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
    m_flow=-201,
    h=1e5,
    nPorts=1) annotation (Placement(transformation(extent={{112,-42},{92,-22}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(redeclare package Medium
      = LAES_INL.LAES.Media.AirCoolProp, p_nominal=7500000)
    annotation (Placement(transformation(extent={{-56,26},{-36,46}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-36,46},{-16,66}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Media.AirCoolProp, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
    annotation (Placement(transformation(extent={{-32,26},{-12,6}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume evaporator(
    redeclare package Medium = Media.AirCoolProp,
    p_start=pump.p_nominal,
    T_start=75.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-16,48},{4,28}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(use_port=
        true, Q_flow(displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume recuperator(
    redeclare package Medium = Media.AirCoolProp,
    p_start=evaporator.p_start,
    T_start=evaporator.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{10,48},{30,28}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(use_port=
        true, Q_flow(displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-6,74},{14,94}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-2,46},{18,66}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{30,46},{50,66}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume superheater(
    redeclare package Medium = Media.AirCoolProp,
    p_start=evaporator.p_start,
    T_start=evaporator.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{48,48},{68,28}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(use_port=
        true, Q_flow(displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{34,70},{54,90}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{64,46},{84,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=53e6)
    annotation (Placement(transformation(extent={{-110,74},{-90,94}})));
  NHES.GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Media.AirCoolProp,
    eta0=0.70,
    PR0=3.6,
    w0=201) annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-74,-38},{-54,-58}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
        Media.AirCoolProp, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
    annotation (Placement(transformation(extent={{-74,-28},{-54,-8}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume superheater1(
    redeclare package Medium = Media.AirCoolProp,
    p_start=evaporator.p_start,
    T_start=evaporator.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary5(use_port=
        false, Q_flow(displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-47,-55})));
  NHES.GasTurbine.Turbine.Turbine turbine1(
    redeclare package Medium = Media.AirCoolProp,
    eta0=0.70,
    PR0=3.6,
    w0=201) annotation (Placement(transformation(extent={{-24,-50},{-4,-30}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-38,-46},{-18,-66}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p2(
    redeclare package Medium = Media.AirCoolProp,
    precision=3,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T7(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-8,-42},{12,-62}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume superheater2(
    redeclare package Medium = Media.AirCoolProp,
    p_start=evaporator.p_start,
    T_start=evaporator.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{12,-42},{32,-22}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary6(use_port=
        false, Q_flow(displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={23,-55})));
  NHES.GasTurbine.Turbine.Turbine turbine2(
    redeclare package Medium = Media.AirCoolProp,
    eta0=0.70,
    PR0=3.6,
    w0=201) annotation (Placement(transformation(extent={{46,-50},{66,-30}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T9(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{32,-46},{52,-66}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p3(
    redeclare package Medium = Media.AirCoolProp,
    precision=3,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
    annotation (Placement(transformation(extent={{62,-28},{82,-8}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T10(redeclare package Medium =
        Media.AirCoolProp, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{62,-42},{82,-62}})));
equation
  connect(boundary.ports[1], pump.port_a)
    annotation (Line(points={{-76,36},{-56,36}}, color={0,127,255}));
  connect(sensor_T1.port, pump.port_b)
    annotation (Line(points={{-26,46},{-26,36},{-36,36}}, color={0,127,255}));
  connect(pump.port_b, sensor_p.port)
    annotation (Line(points={{-36,36},{-22,36},{-22,26}}, color={0,127,255}));
  connect(boundary2.port, evaporator.heatPort)
    annotation (Line(points={{-10,70},{-6,70},{-6,44}}, color={191,0,0}));
  connect(pump.port_b, evaporator.port_a) annotation (Line(points={{-36,36},{
          -20,36},{-20,38},{-12,38}}, color={0,127,255}));
  connect(boundary3.port, recuperator.heatPort)
    annotation (Line(points={{14,84},{20,84},{20,44}}, color={191,0,0}));
  connect(evaporator.port_b, recuperator.port_a)
    annotation (Line(points={{0,38},{14,38}}, color={0,127,255}));
  connect(sensor_T3.port, recuperator.port_b)
    annotation (Line(points={{40,46},{40,38},{26,38}}, color={0,127,255}));
  connect(sensor_T2.port, evaporator.port_b)
    annotation (Line(points={{8,46},{8,38},{0,38}}, color={0,127,255}));
  connect(boundary4.port, superheater.heatPort)
    annotation (Line(points={{54,80},{58,80},{58,44}}, color={191,0,0}));
  connect(recuperator.port_b, superheater.port_a)
    annotation (Line(points={{26,38},{52,38}}, color={0,127,255}));
  connect(sensor_T4.port, superheater.port_b)
    annotation (Line(points={{74,46},{74,38},{64,38}}, color={0,127,255}));
  connect(realExpression.y, boundary2.Q_flow_ext) annotation (Line(points={{-89,
          84},{-76,84},{-76,70},{-24,70}}, color={0,0,127}));
  connect(realExpression.y, boundary3.Q_flow_ext)
    annotation (Line(points={{-89,84},{0,84}}, color={0,0,127}));
  connect(realExpression.y, boundary4.Q_flow_ext) annotation (Line(points={{-89,
          84},{-10,84},{-10,98},{30,98},{30,80},{40,80}}, color={0,0,127}));
  connect(superheater.port_b, turbine.inlet) annotation (Line(points={{64,38},{
          64,-4},{-94,-4},{-94,-32},{-88,-32}}, color={0,127,255}));
  connect(turbine.outlet, sensor_T5.port) annotation (Line(points={{-76,-32},{
          -64,-32},{-64,-38}}, color={0,127,255}));
  connect(sensor_p1.port, turbine.outlet) annotation (Line(points={{-64,-28},{
          -64,-32},{-76,-32}}, color={0,127,255}));
  connect(turbine.outlet, superheater1.port_a)
    annotation (Line(points={{-76,-32},{-54,-32}}, color={0,127,255}));
  connect(boundary5.port, superheater1.heatPort)
    annotation (Line(points={{-47,-48},{-48,-48},{-48,-38}}, color={191,0,0}));
  connect(superheater1.port_b, turbine1.inlet)
    annotation (Line(points={{-42,-32},{-20,-32}}, color={0,127,255}));
  connect(superheater1.port_b, sensor_T6.port) annotation (Line(points={{-42,
          -32},{-28,-32},{-28,-46}}, color={0,127,255}));
  connect(turbine1.outlet, sensor_p2.port)
    annotation (Line(points={{-8,-32},{2,-32},{2,-28}}, color={0,127,255}));
  connect(sensor_p2.port, sensor_T7.port)
    annotation (Line(points={{2,-28},{2,-42}}, color={0,127,255}));
  connect(boundary6.port, superheater2.heatPort)
    annotation (Line(points={{23,-48},{22,-48},{22,-38}}, color={191,0,0}));
  connect(superheater2.port_b, turbine2.inlet)
    annotation (Line(points={{28,-32},{50,-32}}, color={0,127,255}));
  connect(superheater2.port_b, sensor_T9.port)
    annotation (Line(points={{28,-32},{42,-32},{42,-46}}, color={0,127,255}));
  connect(turbine2.outlet, sensor_p3.port)
    annotation (Line(points={{62,-32},{72,-32},{72,-28}}, color={0,127,255}));
  connect(sensor_p3.port, sensor_T10.port)
    annotation (Line(points={{72,-28},{72,-42}}, color={0,127,255}));
  connect(turbine1.outlet, superheater2.port_a)
    annotation (Line(points={{-8,-32},{16,-32}}, color={0,127,255}));
  connect(turbine2.outlet, boundary1.ports[1])
    annotation (Line(points={{62,-32},{92,-32}}, color={0,127,255}));
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
end Turbine_Expansion_Test;
