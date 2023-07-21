within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L3_testinout
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L3_LPOFWHinout pHTGR_BOPinit2_1(
      redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3_in
      data(HPT_p_in=3500000))
    annotation (Placement(transformation(extent={{-42,-42},{38,38}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe(
    p_a_start=3700000,
    p_b_start=3705000,
    T_a_start=573.15,
    m_flow_a_start=5.5,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=6.5),
    use_HeatTransfer=true,
    redeclare model InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gen=15e6)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,0})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));

equation
  connect(pHTGR_BOPinit2_1.port_b_feed, pipe.port_a) annotation (Line(points={{-42,-26},
          {-92,-26},{-92,-10}},          color={0,127,255}));
  connect(pipe.port_b, pHTGR_BOPinit2_1.port_a_steam)
    annotation (Line(points={{-92,10},{-92,22},{-42,22}}, color={0,127,255}));
  connect(bypassdump.ports[1], pHTGR_BOPinit2_1.port_b_bypass)
    annotation (Line(points={{-58,0},{-50,0},{-50,-2},{-42,-2}},
                                               color={0,127,255}));
  connect(steamdump.ports[1], pHTGR_BOPinit2_1.prt_b_steamdump)
    annotation (Line(points={{-60,40},{-52,40},{-52,38},{-42,38}},
                                                 color={0,127,255}));
  connect(boundary.port, pHTGR_BOPinit2_1.port_a_elec)
    annotation (Line(points={{60,0},{50,0},{50,-2},{38,-2}},
                                             color={255,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=20000,
      Interval=20,
      __Dymola_Algorithm="Esdirk45a"));
end L3_testinout;
