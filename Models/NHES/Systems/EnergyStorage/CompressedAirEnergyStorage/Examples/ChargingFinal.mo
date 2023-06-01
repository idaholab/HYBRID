within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model ChargingFinal
  parameter Real tablePhicC[11,7] = [0, 50, 60, 70, 80, 90, 100;
1, 47.8, 57.7, 69.0, 81.5, 95.3, 110.8;
2, 51.2, 61.2, 72.6, 85.2, 98.8, 112.9;
3, 54.9, 64.7, 76.1, 88.9, 101.8, 114.9;
4, 58.7, 68.5, 79.9, 91.9, 104.4, 116.7;
5, 62.6, 72.0, 83.3, 95.0, 106.3, 116.4;
6, 66.2, 75.2, 86.2, 97.6, 108.2, 116.2;
7, 69.4, 78.3, 89.1, 100.1, 109.6, 116.6;
8, 72.5, 81.3, 91.3, 101.6, 110.4, 116.6;
9, 75.4, 84.3, 93.5, 102.3, 110.2, 116.7;
10, 79.0, 86.0, 94.5, 103.0, 110.8, 116.8];

  parameter Real tablePR[11,7] = [0, 50, 60, 70, 80, 90, 100;
1, 42.5, 45.5, 50.4, 57.2, 65.7, 76.3;
2, 42.0, 45.4, 50.3, 57.0, 65.3, 75.0;
3, 41.8, 45.2, 50.1, 56.4, 64.3, 73.6;
4, 41.3, 44.9, 49.7, 55.7, 63.3, 71.8;
5, 40.9, 44.6, 49.3, 54.9, 61.4, 68.8;
6, 40.2, 44.0, 48.5, 53.7, 59.4, 65.5;
7, 39.1, 43.1, 47.5, 52.3, 57.3, 62.8;
8, 38.3, 42.0, 46.0, 50.3, 54.8, 59.5;
9, 37.5, 40.7, 44.3, 48.1, 52.1, 56.4;
10, 36.4, 39.1, 42.3, 45.8, 49.3, 53.3];

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
      4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
      4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
      89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
      90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{176,174},{196,194}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Source(
    redeclare package Medium = Media.Air,
    p=100000,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-184,-50},{-164,-30}})));
  TRANSFORM.Fluid.Valves.ValveLinear CompValve(
    redeclare package Medium = Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-64,50},{-44,70}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol1(
    redeclare package Medium = Media.Air,
    p_start=compressor2.pstart_out,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-94,20})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    yMax=0,
    yMin=-0.999999)
                 annotation (Placement(transformation(extent={{-132,158},{-112,178}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-84,128},{-64,148}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=compressor2.CompPower)
    annotation (Placement(transformation(extent={{-184,116},{-164,136}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,9e7; 1,9e7; 2,8e7; 3,8e7], timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-186,158},{-166,178}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-184,70},{-164,90}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port cavern(
    redeclare package Medium = Media.Air,
    p_start=compressor2.pstart_out,
    T_start=308.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=150000),
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{30,-31},{-30,31}},
        rotation=180,
        origin={0,61})));
  Components.ConstFlowCompressor compressor2(
    redeclare package Medium = Media.Air,
    m_max=105 - 105/MaxValue.y,
    tablePhic=tablePhicC,
    pstart_in=100000,
    pstart_out=4200000,
    Tstart_in=298.15,
    tablePR=tablePR,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=298.15,
    explicitIsentropicEnthalpy=true,
    Tdes_in=298.15,
    Ndesign=157) annotation (Placement(transformation(extent={{-148,-118},{-88,-58}}, rotation=0)));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=30)
    annotation (Placement(transformation(extent={{20,80},{72,128}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{142,110},{122,130}})));
  TRANSFORM.Mechanics.Rotational.Sources.VariableSpeed speedcontrol(w_fixed=120)
    annotation (Placement(transformation(extent={{-32,-98},{-52,-78}})));
  Modelica.Blocks.Sources.RealExpression ErrorMeasurement(y=PID.u_s - PID.u_m)
    annotation (Placement(transformation(extent={{-180,-140},{-160,-120}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1.01,
    duration=100,
    startTime=100) annotation (Placement(transformation(extent={{-180,-174},{-160,-154}})));
  Modelica.Blocks.Math.Max max1 annotation (Placement(transformation(extent={{-124,-156},{-104,-136}})));
  Modelica.Blocks.Sources.RealExpression MaxValue(y=max1.y)
    annotation (Placement(transformation(extent={{-116,-196},{-96,-176}})));
equation
  connect(vol1.port_b, CompValve.port_a)
    annotation (Line(points={{-94,27.2},{-94,60},{-64,60}}, color={0,127,255}));
  connect(add.y, CompValve.opening) annotation (Line(points={{-63,138},{-54,138},{-54,68}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-163,80},{-94,80},{-94,132},{-86,132}}, color={0,0,127}));
  connect(PID.u_m, realExpression.y) annotation (Line(points={{-122,156},{-122,126},{-163,126}}, color={0,0,127}));
  connect(timeTable.y, PID.u_s) annotation (Line(points={{-165,168},{-134,168}},                       color={0,0,127}));
  connect(PID.y, add.u1) annotation (Line(points={{-111,168},{-94,168},{-94,144},{-86,144}}, color={0,0,127}));
  connect(CompValve.port_b, cavern.port) annotation (Line(points={{-44,60},{-44,61},{-18,61}}, color={0,127,255}));
  connect(Source.ports[1], compressor2.inlet)
    annotation (Line(points={{-164,-40},{-156,-40},{-156,-64},{-142,-64}}, color={0,127,255}));
  connect(compressor2.outlet, vol1.port_a) annotation (Line(points={{-94,-64},{-94,12.8}}, color={0,127,255}));
  connect(convection.port_a, cavern.heatPort)
    annotation (Line(points={{27.8,104},{1.77636e-15,104},{1.77636e-15,79.6}}, color={191,0,0}));
  connect(fixedTemperature.port, convection.port_b)
    annotation (Line(points={{122,120},{78,120},{78,104},{64.2,104}}, color={191,0,0}));
  connect(speedcontrol.flange, compressor2.shaft_b) annotation (Line(points={{-52,-88},{-100,-88}}, color={0,0,0}));
  connect(max1.u1, ErrorMeasurement.y)
    annotation (Line(points={{-126,-140},{-150,-140},{-150,-130},{-159,-130}}, color={0,0,127}));
  connect(ramp.y, max1.u2) annotation (Line(points={{-159,-164},{-134,-164},{-134,-152},{-126,-152}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),
    Icon(coordinateSystem(extent={{-120,-100},{160,100}}), graphics={
                             Bitmap(extent={{-92,-72},{92,76}},   fileName="modelica://NHES/Icons/EnergyStoragePackage/CAES.jpg")}),
    Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",
      info="<html>
<p>This model contains the  gas turbine, generator and network models. The network model is based on swing equation.
</html>"),
    experiment(
      StopTime=10000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"));
end ChargingFinal;
