within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.OldTestModels;
model Plant_AS13
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
  Components.BaseCompressor      compressor2(
    redeclare package Medium = Media.Air,
    tablePhic=tablePhicC,
    pstart_in=100000,
    pstart_out=420000,
    Tstart_in=298.15,
    tablePR=tablePR,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=298.15,
    explicitIsentropicEnthalpy=true,
    Tdes_in=298.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{-148,-88},{-88,-28}}, rotation=0)));
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
  TRANSFORM.Mechanics.Rotational.Sources.VariableSpeed variableSpeed1(w_fixed=376)
    annotation (Placement(transformation(extent={{-52,-68},{-72,-48}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{176,174},{196,194}})));
  TRANSFORM.Fluid.Valves.ValveLinear TurbValve(
    redeclare package Medium = Media.Air,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=1*0.999,
    rising=50,
    width=150,
    falling=50,
    period=250,
    offset=0.001,
    startTime=14000)
    annotation (Placement(transformation(extent={{120,100},{102,118}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Source(
    redeclare package Medium = Media.Air,
    p=100000,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-184,-20},{-164,0}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = Media.Air,
    p=10000,
    T=423.15,
    nPorts=1) annotation (Placement(transformation(extent={{186,-20},{166,0}})));
  Modelica.Blocks.Sources.Step step(
    height=-0.999,
    offset=1,
    startTime=9000)
                   annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  TRANSFORM.Fluid.Valves.ValveLinear CompValve(
    redeclare package Medium = Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-84,50},{-64,70}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cavern(
    redeclare package Medium = Media.Air,
    p_start=compressor2.pstart_out,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=100000))
    annotation (Placement(transformation(extent={{-28,34},{28,88}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol2(
    redeclare package Medium = Media.Air,
    p_start=turbine2.pstart_in,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.00001))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={96,8})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol1(
    redeclare package Medium = Media.Air,
    p_start=compressor2.pstart_out,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.00001))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-94,8})));
equation
  connect(variableSpeed1.flange, compressor2.shaft_b)
    annotation (Line(points={{-72,-58},{-100,-58}},                    color={0,0,0}));
  connect(turbine2.outlet, Sink.ports[1])
    annotation (Line(points={{144,-34},{144,-10},{166,-10}}, color={159,159,223}));
  connect(trapezoid.y, TurbValve.opening)
    annotation (Line(points={{101.1,109},{70,109},{70,68}},
                                                         color={0,0,127}));
  connect(step.y, CompValve.opening)
    annotation (Line(points={{-99,110},{-74,110},{-74,68}},  color={0,0,127}));
  connect(CompValve.port_b, Cavern.port_a)
    annotation (Line(points={{-64,60},{-64,61},{-16.8,61}}, color={0,127,255}));
  connect(TurbValve.port_b, vol2.port_a)
    annotation (Line(points={{80,60},{96,60},{96,15.2}}, color={0,127,255}));
  connect(vol1.port_b, CompValve.port_a)
    annotation (Line(points={{-94,15.2},{-94,60},{-84,60}}, color={0,127,255}));
  connect(vol2.port_b, turbine2.inlet)
    annotation (Line(points={{96,0.8},{96,-34}}, color={0,127,255}));
  connect(Cavern.port_b, TurbValve.port_a)
    annotation (Line(points={{16.8,61},{16.8,60},{60,60}}, color={0,127,255}));
  connect(compressor2.outlet, vol1.port_a) annotation (Line(points={{-94,-34},{-94,0.8}}, color={0,127,255}));
  connect(Source.ports[1], compressor2.inlet)
    annotation (Line(points={{-164,-10},{-156,-10},{-156,-34},{-142,-34}}, color={0,127,255}));
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
</html>"));
end Plant_AS13;
