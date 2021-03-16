within NHES.HydrogenTurbine.Turbine.Examples;
model Turbine_postCombustion
  extends Modelica.Icons.Example;

   Turbine                 turbine(
    redeclare package Medium = NHES.Media.FlueGas,
     pstart_out=system.p_ambient,
     Tstart_in=1340.378,
     Tstart_out=787.62,
     PR0=13,
     w0=110.681076)
     annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=
         288.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
    redeclare package Medium = NHES.Media.FlueGas,
     nPorts=1,
     p=101325)           annotation (Placement(transformation(extent={{60,
             6},{40,26}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp ExhaustFlowSignal(
     duration=10,
     startTime=10,
     height=0,
     offset=110.681076)
     annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  Modelica.Fluid.Sources.MassFlowSource_T SourceExhaust(
     use_m_flow_in=true,
     m_flow=165,
     nPorts=1,
    redeclare package Medium = NHES.Media.FlueGas,
    T=1340.378) annotation (Placement(transformation(
         extent={{-10,-10},{10,10}},
         rotation=0,
         origin={-50,16})));
equation
   connect(SinkExhaustGas.ports[1], turbine.outlet)
     annotation (Line(points={{40,16},{12,16}}, color={0,127,255}));
   connect(SourceExhaust.m_flow_in, ExhaustFlowSignal.y)
     annotation (Line(points={{-60,24},{-79,24}}, color={0,0,127}));
   connect(SourceExhaust.ports[1], turbine.inlet)
     annotation (Line(points={{-40,16},{-12,16}}, color={0,127,255}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
             {{-100,-100},{100,100}})));
end Turbine_postCombustion;
