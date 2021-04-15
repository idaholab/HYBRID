within NHES.HydrogenTurbine.CombustionChamber.Examples;
model CombustionChamber_postCompression
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T SourceAir(
    use_m_flow_in=true,
    redeclare package Medium = Media.Air,
     nPorts=1,
     m_flow=108.408,
    T=640.036) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
  Modelica.Fluid.Sources.Boundary_pT SinkFlueGas(
     nPorts=1,
    redeclare package Medium = Media.FlueGas,
    p=1560410)
              annotation (Placement(transformation(extent={{80,-10},{60,10}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp FuelFlowSignal(
     duration=10,
     height=0,
     startTime=10,
     offset=2.273076)
     annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
  Modelica.Fluid.Sources.MassFlowSource_T SourceFuel(
    use_m_flow_in=true,
    redeclare package Medium = Media.Hydrogen,
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
     annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
   CombustionChamber                 combustionChamber(
     V=0.125,
     S=0.25,
    pstart=1560410,
    Tstart=1340.378)
     annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=288.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
   connect(AirFlowSignal.y, SourceAir.m_flow_in)
     annotation (Line(points={{-79,8},{-60,8}}, color={0,0,127}));
   connect(SourceFuel.m_flow_in, FuelFlowSignal.y)
     annotation (Line(points={{-60,48},{-79,48}}, color={0,0,127}));
   connect(combustionChamber.ina, SourceAir.ports[1]) annotation (Line(
         points={{-4,0},{-4,0},{-40,0}},   color={0,127,255}));
   connect(SinkFlueGas.ports[1], combustionChamber.out)
     annotation (Line(points={{60,0},{4,0}},         color={0,127,255}));
   connect(combustionChamber.inf, SourceFuel.ports[1])
     annotation (Line(points={{0,4},{0,40},{-40,40}}, color={0,127,255}));
  annotation (
    experiment(StopTime=100, Interval=1),
    experimentSetupOutput,
    Documentation(info="<html>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
             {100,100}})));
end CombustionChamber_postCompression;
