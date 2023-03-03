within NHES.Systems.BalanceOfPlant.Turbine;
model HydCircTrial
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={-7,-13})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Qin(
    T_start=293.15,
    use_HeatPort=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=100000,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder,
    use_T_start=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-70,36})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow    boundary(use_port=
        true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-108,26})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      R=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-12,56})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Qout(
    T_start=293.15,
    use_HeatPort=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=100000,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5),
    use_T_start=true)
     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={38,30})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow    boundary1(use_port=
        true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={78,28})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5000,
    duration=300,
    startTime=100)
    annotation (Placement(transformation(extent={{-152,18},{-138,32}})));
  Modelica.Blocks.Sources.Constant const(k=-1000)
    annotation (Placement(transformation(extent={{90,48},{104,62}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-40,-56},{-26,-42}})));
equation
  connect(boundary.port, Qin.heatPort) annotation (Line(points={{-98,26},{-78,26},
          {-78,36},{-76,36}}, color={191,0,0}));
  connect(resistance1.port_a, Qin.port_b)
    annotation (Line(points={{-19,56},{-70,56},{-70,42}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, Qin.port_a) annotation (Line(points={{-18,
          -13},{-34,-13},{-34,-8},{-70,-8},{-70,30}}, color={0,127,255}));
  connect(boundary1.port, Qout.heatPort) annotation (Line(points={{68,28},{52,28},
          {52,30},{44,30}}, color={191,0,0}));
  connect(Qout.port_a, pump_SimpleMassFlow1.port_a) annotation (Line(points={{38,
          24},{34,24},{34,0},{4,0},{4,-13}}, color={0,127,255}));
  connect(resistance1.port_b, Qout.port_b)
    annotation (Line(points={{-5,56},{38,56},{38,36}}, color={0,127,255}));
  connect(const1.y, pump_SimpleMassFlow1.in_m_flow) annotation (Line(points={{-25.3,
          -49},{-25.3,-50},{-7,-50},{-7,-21.03}}, color={0,0,127}));
  connect(const.y, boundary1.Q_flow_ext) annotation (Line(points={{104.7,55},{108,
          55},{108,28},{82,28}}, color={0,0,127}));
  connect(ramp.y, boundary.Q_flow_ext) annotation (Line(points={{-137.3,25},{-124.65,
          25},{-124.65,26},{-112,26}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end HydCircTrial;
