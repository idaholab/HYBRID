within NHES.GasTurbine.Compressor.Examples;
model Compressor_SourceP
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T SinkW(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium = NHES.Media.Air,
       m_flow=-99.1823,
       T=640.036)
    annotation (Placement(transformation(extent={{60,6},{40,26}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT SourceP(
    nPorts=1,
    redeclare package Medium = NHES.Media.Air,
       p=101325,
       T=288.15)
             annotation (Placement(transformation(extent={{-80,6},{-60,26}},
          rotation=0)));
     Compressor                                       compressor(
    redeclare package Medium = NHES.Media.Air,
       PR0=13,
       w0=108.408,
       pstart_in=101325,
       Tstart_in=288.15,
       Tstart_out=640.036) annotation (Placement(transformation(extent={{-20,
               -20},{20,20}}, rotation=0)));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=288.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=10,
    startTime=10,
       height=0,
       offset=108.408)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{52,46},{60,54}})));
equation
  connect(SourceP.ports[1],compressor. inlet)
    annotation (Line(points={{-60,16},{-12,16}}, color={0,127,255}));
  connect(compressor.outlet, SinkW.ports[1])
    annotation (Line(points={{12,16},{12,16},{40,16}}, color={0,127,255}));
  connect(gain.u, ramp.y)
    annotation (Line(points={{51.2,50},{46,50},{41,50}}, color={0,0,127}));
  connect(gain.y, SinkW.m_flow_in) annotation (Line(points={{60.4,50},{68,50},{68,
          24},{60,24}}, color={0,0,127}));
  annotation (
    experiment(StopTime=100, Interval=1),
    experimentSetupOutput,
    Documentation(info="<html>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
               {100,100}})));
end Compressor_SourceP;
