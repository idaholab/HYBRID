within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model CavernStorageModel
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

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110;
                                   2.36, 4.68e-3, 4.68e-3, 4.68e-3;
                                   2.88, 4.68e-3, 4.68e-3, 4.68e-3;
                                   3.56, 4.68e-3, 4.68e-3, 4.68e-3;
                                   4.46, 4.68e-3, 4.68e-3, 4.68e-3];

  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110;
                                  2.36, 89e-2, 89.5e-2, 89.3e-2;
                                  2.88, 90e-2, 90.6e-2, 90.5e-2;
                                  3.56, 90.5e-2, 90.6e-2, 90.5e-2;
                                  4.46, 90.2e-2, 90.3e-2, 90e-2];
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{172,170},{192,190}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port Cavern12(
    redeclare package Medium = Media.Air,
    p_start=2650000,
    T_start=386.12,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=3300000),
    use_HeatPort=true) annotation (Placement(transformation(extent={{120,123},{64,69}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=30)
    annotation (Placement(transformation(extent={{-74,134},{-126,182}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{-180,148},{-160,168}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Media.Air,
    m_flow=0,
    nPorts=1) annotation (Placement(transformation(extent={{176,86},{156,106}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction(
  redeclare package Material = TRANSFORM.Media.Solids.CustomSolids.Rock_l_3_d_2700_cp_860, redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D (
        nX=3,
        length_x=1,
        length_y=250,
        length_z=100))
    annotation (Placement(transformation(extent={{14,148},{-6,168}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port
                                       Cavern1(
    redeclare package Medium = Media.Air,
    p_start=2650000,
    T_start=386.12,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=3300000),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{128,9},{72,-45}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1(surfaceArea=25000, alpha=30)
    annotation (Placement(transformation(extent={{-66,20},{-118,68}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=298.15)
    annotation (Placement(transformation(extent={{-172,34},{-152,54}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Media.Air,
    m_flow=0,
    nPorts=1) annotation (Placement(transformation(extent={{184,-28},{164,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T=298.15)
    annotation (Placement(transformation(extent={{-170,-112},{-150,-92}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2(surfaceArea=25000, alpha=25)
    annotation (Placement(transformation(extent={{-4,-126},{-56,-78}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction1(redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Rock_l_3_d_2700_cp_860, redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D (
        nX=3,
        length_x=1,
        length_y=250,
        length_z=100))
    annotation (Placement(transformation(extent={{-96,-112},{-116,-92}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port Cavern(
    redeclare package Medium = Media.Air,
    p_start=2650000,
    T_start=384.727,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1e6),
    use_HeatPort=true) annotation (Placement(transformation(extent={{120,-135},{64,-189}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Media.Air,
    m_flow=0,
    nPorts=1) annotation (Placement(transformation(extent={{176,-172},{156,-152}})));
equation
  connect(convection.port_b, fixedTemperature.port)
    annotation (Line(points={{-118.2,158},{-160,158}},                   color={191,0,0}));
  connect(boundary.ports[1], Cavern12.port) annotation (Line(points={{156,96},{108.8,96}}, color={0,127,255}));
  connect(conduction.port_a1, Cavern12.heatPort) annotation (Line(points={{14,158},{92,158},{92,112.2}}, color={191,0,0}));
  connect(conduction.port_b1, convection.port_a) annotation (Line(points={{-6,158},{-81.8,158}}, color={191,0,0}));
  connect(convection1.port_b, fixedTemperature1.port) annotation (Line(points={{-110.2,44},{-152,44}}, color={191,0,0}));
  connect(boundary1.ports[1], Cavern1.port) annotation (Line(points={{164,-18},{116.8,-18}}, color={0,127,255}));
  connect(convection1.port_a, Cavern1.heatPort)
    annotation (Line(points={{-73.8,44},{100,44},{100,-1.8}}, color={191,0,0}));
  connect(fixedTemperature2.port, conduction1.port_b1)
    annotation (Line(points={{-150,-102},{-116,-102}},                         color={191,0,0}));
  connect(conduction1.port_a1, convection2.port_b) annotation (Line(points={{-96,-102},{-48.2,-102}}, color={191,0,0}));
  connect(Cavern.heatPort, convection2.port_a)
    annotation (Line(points={{92,-145.8},{92,-102},{-11.8,-102}}, color={191,0,0}));
  connect(boundary2.ports[1], Cavern.port) annotation (Line(points={{156,-162},{108.8,-162}}, color={0,127,255}));
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
end CavernStorageModel;
