within NHES.Systems.BalanceOfPlant.Turbine;
model WaterCircTrial_0
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
    T_start=473.15,
    use_HeatPort=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=500000,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
        (length=2, crossArea=0.01),
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
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=
        100000000)
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
        (V=0.2),
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
    offset=35000,
    startTime=100)
    annotation (Placement(transformation(extent={{-152,18},{-138,32}})));
  Modelica.Blocks.Sources.Constant const(k=-35000)
    annotation (Placement(transformation(extent={{90,48},{104,62}})));
  Modelica.Blocks.Sources.Constant const1(k=500 + 273)
    annotation (Placement(transformation(extent={{-154,-76},{-140,-62}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5000,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{8,-82},{28,-62}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-80,68},{-60,88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{26,70},{46,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{86,-8},{106,12}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT0(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-76,-54},{-56,-34}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.1,
    Ti=10,
    yMax=0.1,
    yMin=0.0001,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=0.01)
    annotation (Placement(transformation(extent={{-112,-88},{-98,-74}})));
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
  connect(const.y, boundary1.Q_flow_ext) annotation (Line(points={{104.7,55},{108,
          55},{108,28},{82,28}}, color={0,0,127}));
  connect(ramp.y, boundary.Q_flow_ext) annotation (Line(points={{-137.3,25},{-124.65,
          25},{-124.65,26},{-112,26}}, color={0,0,127}));
  connect(boundary2.ports[1], pump_SimpleMassFlow1.port_a) annotation (Line(
        points={{28,-72},{32,-72},{32,-13},{4,-13}}, color={0,127,255}));
  connect(sensor_pT1.port, Qin.port_b)
    annotation (Line(points={{-70,68},{-70,42}}, color={0,127,255}));
  connect(sensor_pT2.port, Qout.port_b)
    annotation (Line(points={{36,70},{38,70},{38,36}}, color={0,127,255}));
  connect(sensor_pT3.port, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{96,-8},{96,-13},{4,-13}}, color={0,127,255}));
  connect(sensor_pT0.port, Qin.port_a) annotation (Line(points={{-66,-54},{-66,-56},
          {-52,-56},{-52,-8},{-70,-8},{-70,30}}, color={0,127,255}));
  connect(const1.y, FWCP_Speed.u_s) annotation (Line(points={{-139.3,-69},{
          -139.3,-70},{-120,-70},{-120,-81},{-113.4,-81}}, color={0,0,127}));
  connect(sensor_pT1.T, FWCP_Speed.u_m) annotation (Line(points={{-64,75.8},{
          -60,75.8},{-60,80},{-54,80},{-54,62},{-158,62},{-158,-92},{-105,-92},
          {-105,-89.4}}, color={0,0,127}));
  connect(FWCP_Speed.y, pump_SimpleMassFlow1.in_m_flow) annotation (Line(points
        ={{-97.3,-81},{-97.3,-82},{-7,-82},{-7,-21.03}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end WaterCircTrial_0;
