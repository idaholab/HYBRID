within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L2_CE_test
  extends Modelica.Icons.Example;
  SteamTurbine_L2_HPOFWH_CE                                  pHTGR_BOPinit2_1
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume TES_DHX(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=3),
    Q_gen(displayUnit="MW") = 15000000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,0})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume DH_HX(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=3),
    Q_gen(displayUnit="MW") = -1000000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-64})));
equation
  connect(pHTGR_BOPinit2_1.port_b_feed, TES_DHX.port_a) annotation (Line(points
        ={{-40,-24},{-92,-24},{-92,-6}}, color={0,127,255}));
  connect(TES_DHX.port_b, pHTGR_BOPinit2_1.port_a_steam)
    annotation (Line(points={{-92,6},{-92,24},{-40,24}}, color={0,127,255}));
  connect(boundary.port, pHTGR_BOPinit2_1.port_a_elec)
    annotation (Line(points={{60,0},{40,0}}, color={255,0,0}));
  connect(pHTGR_BOPinit2_1.port_b_bypass, DH_HX.port_a)
    annotation (Line(points={{16,-40},{16,-64},{6,-64}}, color={0,127,255}));
  connect(DH_HX.port_b, pHTGR_BOPinit2_1.port_a_cond) annotation (Line(points={
          {-6,-64},{-16,-64},{-16,-40}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=20000,
      Interval=20,
      __Dymola_Algorithm="Esdirk45a"));
end L2_CE_test;
