within NHES.GasTurbine.Compressor.Examples;
model AirFlowDynamics
  extends Modelica.Icons.Example;

     AirSourceW airSourceW(
    redeclare package Medium = NHES.Media.Air,
       allowFlowReversal=false,
       use_in_thetaIGV=true,
       use_in_T=false,
       use_in_X=false,
       use_in_N=true)
       annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  Modelica.Fluid.Sources.Boundary_pT airSinkP(
    nPorts=1,
    redeclare package Medium = NHES.Media.Air,
    use_p_in=false,
    p=101325) annotation (Placement(transformation(extent={{60,-10},{40,10}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp ThetaIGVsignal(
    duration=0,
    offset=85,
    height=-10,
    startTime=5)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Fluid.Sensors.MassFlowRate wAir_in(redeclare package Medium =
        NHES.Media.Air)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp Nsignal(
    duration=0,
    startTime=10,
       height=-48.6*3*Modelica.Constants.pi*2/60,
       offset=4860*Modelica.Constants.pi*2/60)
    annotation (Placement(transformation(extent={{-10,20},{-30,40}})));
equation
  connect(ThetaIGVsignal.y, airSourceW.in_thetaIGV) annotation (Line(points=
         {{-59,30},{-49.4,30},{-49.4,7}}, color={0,0,127}));
  connect(airSinkP.ports[1], wAir_in.port_b)
    annotation (Line(points={{40,0},{10,0}}, color={0,127,255}));
  connect(wAir_in.port_a, airSourceW.flange)
    annotation (Line(points={{-10,0},{-32,0}}, color={0,127,255}));
  connect(Nsignal.y, airSourceW.in_N) annotation (Line(points={{-31,30},{
          -38.6,30},{-38.6,7}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
               -100},{100,100}})),
    experiment(StopTime=20, Interval=1),
    __Dymola_experimentSetupOutput);
end AirFlowDynamics;
