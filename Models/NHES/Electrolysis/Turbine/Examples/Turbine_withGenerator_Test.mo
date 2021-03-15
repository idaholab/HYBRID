within NHES.Electrolysis.Turbine.Examples;
model Turbine_withGenerator_Test
  import NHES.Electrolysis;
  extends Modelica.Icons.Example;

  Turbine.TurbineShaft_PowerOut_NPT_HTSE turbine(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    w0=26.4648,
    PR0=17.307/1.01325,
    Xstart={0.674729,0.325271},
    phi_start(displayUnit="rad"),
    phi(displayUnit="rad", fixed=true),
    pstart_out=system.p_ambient,
    Tstart_in=605.841,
    Tstart_out=308.2712)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=
        298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT sinkP(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=system.p_ambient) annotation (Placement(transformation(extent={{80,
            6},{60,26}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp p_in_signal(
    startTime=10,
    duration=0,
    height=-2*1e5,
    offset=17.307e5)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Fluid.Sources.Boundary_pT sourceP(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    X={0.674729,0.325271},
    use_p_in=true,
    p=1730700,
    T=605.841)
    annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
  Modelica.Fluid.Sensors.Temperature temp(redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Electrical.ElectricGenerator_constSpeed generator(w_fixed=turbine.N0)
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
  Sources.PrescribedFrequency prescribedFrequency(f=60)
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
equation
  connect(sinkP.ports[1], turbine.outlet)
    annotation (Line(points={{60,16},{12,16}}, color={0,127,255}));
  connect(sourceP.ports[1], turbine.inlet)
    annotation (Line(points={{-44,16},{-12,16}}, color={0,127,255}));
  connect(temp.port, turbine.outlet) annotation (Line(points={{20,30},{20,
          16},{12,16}}, color={0,127,255}));
  connect(p_in_signal.y, sourceP.p_in) annotation (Line(points={{-79,50},
          {-74,50},{-74,24},{-66,24}}, color={0,0,127}));
  connect(turbine.shaft_b, generator.shaft)
    annotation (Line(points={{12,0},{20,0}},        color={0,0,0}));
  connect(prescribedFrequency.portElec_a, generator.powerGeneration)
    annotation (Line(
      points={{44,0},{36,0}},
      color={255,0,0},
      thickness=0.5));
  connect(turbine.W_GT, generator.W_GT) annotation (Line(points={{7.2,9.6},
          {28,9.6},{28,6.2}}, color={0,0,127}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
             {{-100,-100},{100,100}})), experiment(StopTime=100, Interval=
         1));
end Turbine_withGenerator_Test;
