within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model BraytonCycle
  NHES.GasTurbine.Compressor.Compressor compressor(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    pstart_in=930000,
    Tstart_in=298.15,
    Tstart_out=709.15,
    eta0=0.9,
    PR0=7.53,
    w0=248.9) annotation (Placement(transformation(extent={{-12,-76},{8,-56}})));
  NHES.GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    pstart_in=7000000,
    pstart_out=930000,
    Tstart_in=1173.15,
    Tstart_out=588.15,
    eta0=0.9,
    PR0=0.1328,
    w0=248.9) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p_start=7000000,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=10),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-54,-10})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    T_start=571.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=10),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={44,-18})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(Q_flow=6)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary1(Q_flow=-5)
    annotation (Placement(transformation(extent={{88,-28},{68,-8}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{60,44},{80,64}})));
equation
  connect(volume.port_b, turbine.inlet)
    annotation (Line(points={{-54,-4},{-54,18},{-6,18}}, color={0,127,255}));
  connect(volume.port_a, compressor.inlet)
    annotation (Line(points={{-54,-16},{-54,-54},{-8,-54},{-8,-58}}, color={0,127,255}));
  connect(volume1.port_a, turbine.outlet)
    annotation (Line(points={{44,-12},{44,18},{6,18}}, color={0,127,255}));
  connect(volume1.port_b, compressor.outlet)
    annotation (Line(points={{44,-24},{44,-54},{4,-54},{4,-58}}, color={0,127,255}));
  connect(boundary.port, volume.heatPort)
    annotation (Line(points={{-80,-10},{-60,-10}}, color={191,0,0}));
  connect(boundary1.port, volume1.heatPort)
    annotation (Line(points={{68,-18},{50,-18}}, color={191,0,0}));
  annotation ();
end BraytonCycle;
