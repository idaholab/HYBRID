within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.OldTestModels;
model DischargingTest1
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
    pstart_in=700000,
    pstart_out=152000,
    tablePhic=tablePhicT,
    tableEta=tableEtaT,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=298.15,
    Tdes_in=473.15,
    Tstart_in=298.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{-20,-134},{40,-74}},rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{170,170},{190,190}})));
  TRANSFORM.Fluid.Valves.ValveLinear TurbValve(
    redeclare package Medium = Media.Air,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-64,4},{-44,24}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = Media.Air,
    p=152000,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{72,-66},{52,-46}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.999,
    duration=120,
    offset=0.001,
    startTime=1000) annotation (Placement(transformation(extent={{22,98},{2,118}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port cavern(
    redeclare package Medium = Media.Air,
    p_start(displayUnit="kPa") = 7200000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=150000))
    annotation (Placement(transformation(
        extent={{-30,-31},{30,31}},
        rotation=180,
        origin={-118,13})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol1(
    redeclare package Medium = Media.Air,
    p_start=7200000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.001))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-16,-20})));
equation
  connect(turbine2.outlet, Sink.ports[1]) annotation (Line(points={{34,-80},{34,-56},{52,-56}}, color={0,127,255}));
  connect(ramp.y, TurbValve.opening) annotation (Line(points={{1,108},{-54,108},{-54,22}}, color={0,0,127}));
  connect(cavern.port, TurbValve.port_a) annotation (Line(points={{-100,13},{-64,14}}, color={0,127,255}));
  connect(vol1.port_b, TurbValve.port_b) annotation (Line(points={{-16,-12.8},{-16,14},{-44,14}}, color={0,127,255}));
  connect(vol1.port_a, turbine2.inlet) annotation (Line(points={{-16,-27.2},{-16,-80},{-14,-80}}, color={0,127,255}));
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
end DischargingTest1;
