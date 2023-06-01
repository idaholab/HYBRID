within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model Plant_AS14
  parameter Real tablePhicC[11,7] = [0, 50, 60, 70, 80, 90, 100;
1, 0.00150, 0.00180, 0.00216, 0.00253, 0.00299, 0.00347;
2, 0.00162, 0.00193, 0.00228, 0.00266, 0.00311, 0.00354;
3, 0.00175, 0.00204, 0.00242, 0.00278, 0.00321, 0.00361;
4, 0.00187, 0.00218, 0.00252, 0.00290, 0.00329, 0.00367;
5, 0.00198, 0.00229, 0.00263, 0.00300, 0.00336, 0.00372;
6, 0.00210, 0.00240, 0.00273, 0.00308, 0.00343, 0.00376;
7, 0.00221, 0.00250, 0.00282, 0.00314, 0.00348, 0.00379;
8, 0.00232, 0.00259, 0.00290, 0.00318, 0.00353, 0.00382;
9, 0.00241, 0.00269, 0.00296, 0.00322, 0.00356, 0.00383;
10, 0.00249, 0.00276, 0.00299, 0.00324, 0.00359, 0.00384];

  parameter Real tablePR[11,7] = [0, 50, 60, 70, 80, 90, 100;
1, 1.203154154, 1.307102195, 1.435027275, 1.618785876, 1.870405144, 2.181863019;
2, 1.191305278, 1.299246521, 1.427159716, 1.606942942, 1.85856221, 2.138068526;
3, 1.187436863, 1.283404442, 1.423309129, 1.599081326, 1.838715045, 2.090286774;
4, 1.175582045, 1.27555471, 1.407449223, 1.58723245, 1.802906956, 2.034518617;
5, 1.159739966, 1.255725372, 1.387613943, 1.555429447, 1.755125204, 1.970769999;
6, 1.139910628, 1.235890092, 1.36378546, 1.519615417, 1.703356191, 1.903022236;
7, 1.11609403, 1.20408709, 1.323996054, 1.46783452, 1.643594833, 1.823306752;
8, 1.084296971, 1.172272203, 1.284200706, 1.408067219, 1.575853012, 1.739604007;
9, 1.048500767, 1.128507422, 1.228432549, 1.336332196, 1.50411799, 1.647908917;
10, 1.008699476, 1.084706987, 1.164672046, 1.260592087, 1.416422043, 1.556213826];

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
      4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
      4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
      89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
      90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  Components.Turbine2      turbine2(
    redeclare package Medium = Media.Air,
    pstart_in=710000,
    pstart_out=152000,
    tablePhic=tablePhicT,
    tableEta=tableEtaT,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=423.15,
    Tdes_in=473.15,
    Tstart_in=473.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{90,-88},{150,-28}}, rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{176,174},{196,194}})));
  TRANSFORM.Fluid.Valves.ValveLinear TurbValve(
    redeclare package Medium = Media.Air,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{60,50},{80,70}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Source(
    redeclare package Medium = Media.Air,
    p=100000,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-184,-50},{-164,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = Media.Air,
    p=10000,
    T=423.15,
    nPorts=1) annotation (Placement(transformation(extent={{186,-20},{166,0}})));
  TRANSFORM.Fluid.Valves.ValveLinear CompValve(
    redeclare package Medium = Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-64,50},{-44,70}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cavern(
    redeclare package Medium = Media.Air,
    p_start=compressor2.pstart_out,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=150000))
    annotation (Placement(transformation(extent={{-28,34},{28,88}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol2(
    redeclare package Medium = Media.Air,
    p_start=turbine2.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={96,8})));
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
    yMin=-0.999) annotation (Placement(transformation(extent={{-132,158},{-112,178}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-84,128},{-64,148}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=compressor2.Wc)
    annotation (Placement(transformation(extent={{-184,116},{-164,136}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,2e8; 1,2e8; 2,2e8; 3,2e8], timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-186,158},{-166,178}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-184,70},{-164,90}})));
  GasTurbine.Compressor.Compressor compressor2(
    redeclare package Medium = Media.Air,
    pstart_in=100000,
    pstart_out=4200000,
    Tstart_in=298.15,
    Tstart_out=298.15,
    eta0=0.9,
    PR0=42,
    w0=94) annotation (Placement(transformation(extent={{-144,-108},{-82,-54}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.999,
    duration=60,
    offset=1e-6,
    startTime=1000) annotation (Placement(transformation(extent={{136,144},{116,164}})));
equation
  connect(CompValve.port_b, Cavern.port_a)
    annotation (Line(points={{-44,60},{-44,61},{-16.8,61}}, color={0,127,255}));
  connect(TurbValve.port_b, vol2.port_a)
    annotation (Line(points={{80,60},{96,60},{96,15.2}}, color={0,127,255}));
  connect(vol1.port_b, CompValve.port_a)
    annotation (Line(points={{-94,27.2},{-94,60},{-64,60}}, color={0,127,255}));
  connect(vol2.port_b, turbine2.inlet)
    annotation (Line(points={{96,0.8},{96,-34}}, color={0,127,255}));
  connect(Cavern.port_b, TurbValve.port_a)
    annotation (Line(points={{16.8,61},{16.8,60},{60,60}}, color={0,127,255}));
  connect(add.y, CompValve.opening) annotation (Line(points={{-63,138},{-54,138},{-54,68}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-163,80},{-94,80},{-94,132},{-86,132}}, color={0,0,127}));
  connect(PID.u_m, realExpression.y) annotation (Line(points={{-122,156},{-122,126},{-163,126}}, color={0,0,127}));
  connect(timeTable.y, PID.u_s) annotation (Line(points={{-165,168},{-134,168}},                       color={0,0,127}));
  connect(PID.y, add.u1) annotation (Line(points={{-111,168},{-94,168},{-94,144},{-86,144}}, color={0,0,127}));
  connect(turbine2.outlet, Sink.ports[1]) annotation (Line(points={{144,-34},{144,-10},{166,-10}}, color={0,127,255}));
  connect(compressor2.inlet, Source.ports[1])
    annotation (Line(points={{-131.6,-59.4},{-146.8,-59.4},{-146.8,-40},{-164,-40}}, color={0,127,255}));
  connect(compressor2.outlet, vol1.port_a) annotation (Line(points={{-94.4,-59.4},{-94,12.8}}, color={0,127,255}));
  connect(ramp.y, TurbValve.opening) annotation (Line(points={{115,154},{70,154},{70,68}}, color={0,0,127}));
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
end Plant_AS14;
