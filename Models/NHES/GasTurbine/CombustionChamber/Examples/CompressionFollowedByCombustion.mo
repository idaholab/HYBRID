within NHES.GasTurbine.CombustionChamber.Examples;
model CompressionFollowedByCombustion
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T SourceAir(
    use_m_flow_in=true,
    redeclare package Medium = NHES.Media.Air,
     m_flow=165,
     nPorts=1,
    T=288.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,8})));
  Modelica.Fluid.Sources.Boundary_pT SinkFlueGas(
    redeclare package Medium = NHES.Media.FlueGas,
     nPorts=1,
    p=1560410)
              annotation (Placement(transformation(extent={{70,-10},{50,10}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp FuelFlowSignal(
     duration=10,
     height=0,
     startTime=10,
     offset=2.273076)
     annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
  Modelica.Fluid.Sources.MassFlowSource_T SourceFuel(
    use_m_flow_in=true,
    redeclare package Medium = NHES.Media.NaturalGas,
     m_flow=2,
     nPorts=1,
    T=303.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,40})));

  Modelica.Blocks.Sources.Ramp AirFlowSignal(
     duration=10,
     startTime=10,
     height=0,
     offset=108.408)
     annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
   CombustionChamber                 combustionChamber(
     V=0.125,
     S=0.25,
    pstart=1560410,
    Tstart=1340.378)
     annotation (Placement(transformation(extent={{-10,4},{10,24}})));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=288.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
   Compressor.Compressor                 compressor(
    redeclare package Medium = NHES.Media.Air,
     PR0=13,
     w0=108.408,
    pstart_in=101325,
    Tstart_in=288.15,
    Tstart_out=640.036)
     annotation (Placement(transformation(extent={{-34,-12},{-12,10}})));
   Modelica.Fluid.Sensors.Pressure pressFuel(redeclare package Medium =
        NHES.Media.NaturalGas)
     annotation (Placement(transformation(extent={{-10,52},{10,72}})));
   Modelica.Fluid.Sensors.Pressure pressAir_in(redeclare package Medium =
        NHES.Media.Air)
     annotation (Placement(transformation(extent={{-40,16},{-20,36}})));
   Modelica.Fluid.Sensors.MassFlowRate wExhuastGas(redeclare package Medium =
        NHES.Media.FlueGas)
     annotation (Placement(transformation(extent={{24,-10},{44,10}})));
equation
   connect(AirFlowSignal.y, SourceAir.m_flow_in)
     annotation (Line(points={{-79,16},{-60,16}},
                                                color={0,0,127}));
   connect(SourceFuel.m_flow_in, FuelFlowSignal.y)
     annotation (Line(points={{-60,48},{-79,48}}, color={0,0,127}));
   connect(compressor.outlet, combustionChamber.ina) annotation (Line(
         points={{-16.4,7.8},{-16.4,14},{-4,14}}, color={0,127,255}));
   connect(SourceAir.ports[1], compressor.inlet) annotation (Line(points={
           {-40,8},{-29.6,8},{-29.6,7.8}}, color={0,127,255}));
   connect(SourceFuel.ports[1], combustionChamber.inf) annotation (Line(
         points={{-40,40},{0,40},{0,18}}, color={0,127,255}));
   connect(pressFuel.port, combustionChamber.inf)
     annotation (Line(points={{0,52},{0,18}}, color={0,127,255}));
   connect(pressAir_in.port, compressor.inlet) annotation (Line(points={{
           -30,16},{-30,7.8},{-29.6,7.8}}, color={0,127,255}));
   connect(SinkFlueGas.ports[1], wExhuastGas.port_b)
     annotation (Line(points={{50,0},{44,0}}, color={0,127,255}));
   connect(wExhuastGas.port_a, combustionChamber.out) annotation (Line(
         points={{24,0},{20,0},{20,14},{4,14}}, color={0,127,255}));
  annotation (
    experiment(StopTime=100, Interval=1),
    experimentSetupOutput,
    Documentation(info="<html>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
             {100,100}})));
end CompressionFollowedByCombustion;
